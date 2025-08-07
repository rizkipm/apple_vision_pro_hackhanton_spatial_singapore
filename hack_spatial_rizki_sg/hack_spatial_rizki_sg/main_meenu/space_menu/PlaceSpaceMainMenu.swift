//
//  PlaceSpaceMainMenu.swift
//  hack_spatial_rizki_sg
//
//  Created by NUS on 7/8/25.
//

import SwiftUI
import RealityKit
import ARKit

// MARK: - Main Game View
/// The main view for the Space Catcher game.
/// It sets up the immersive space, handles game state, and overlays the UI.
struct PlaySpaceCatcherMainView: View {
    @Environment(\.dismiss) private var dismiss
    
    // Game State Management
    @State private var score: Int = 0
    @State private var timeLeft: Int = 60
    @State private var isGameActive: Bool = false
    @State private var currentLevel: GameLevel = .meteorCatch
    @State private var showLevelSelector: Bool = true
    @State private var showPlayAroundSpace = false

    // Timer for game countdown and spawning
    @State private var gameTimer: Timer?
    @State private var spawnTimer: Timer?

    // RealityKit content
    @State private var contentEntity = Entity()

    var body: some View {
        ZStack {
            // The 3D environment for the game
            RealityView { content in
                // Setup the initial scene
                setupScene(content: content)
            } update: { content in
                // This closure is called every frame.
                // We can add per-frame logic here if needed,
                // but hand tracking is handled via subscriptions.
            }
            .gesture(SpatialTapGesture().targetedToAnyEntity().onEnded { value in
                // Handle tap-to-catch for accessibility or alternative input
                handleCatch(entity: value.entity)
            })
            
            // Game UI Layer
            VStack {
                if showLevelSelector {
                    LevelSelectionView(currentLevel: $currentLevel, showLevelSelector: $showLevelSelector, onStart: startGame)
                } else {
                    GameHUDView(
                        score: $score,
                        timeLeft: $timeLeft,
                        currentLevel: $currentLevel,
                        onExit: {
                            endGame()
                            dismiss()
                        }
                    )
                }
            }
        }
        .onAppear(perform: setupHandTracking)
        .onDisappear(perform: endGame)
    }
    
    /// Configures the initial 3D scene with a space background.
    private func setupScene(content: RealityViewContent) {
        // Create a large sphere for the space background
        let skyboxMesh = MeshResource.generateSphere(radius: 1000)
        var skyboxMaterial = UnlitMaterial()
        
        // Use an asset for the skybox texture
        if let texture = try? TextureResource.load(named: "space_skybox") {
            skyboxMaterial.color = .init(texture: .init(texture))
        } else {
//            skyboxMaterial.color = .init(Color.black) // Fallback color
        }
        
        let skyboxEntity = ModelEntity(mesh: skyboxMesh, materials: [skyboxMaterial])
        // Render the skybox inside-out
        skyboxEntity.scale.x = -1
        
        contentEntity.addChild(skyboxEntity)
        content.add(contentEntity)
    }

    /// Sets up hand tracking to detect when a hand is near a catchable object.
    private func setupHandTracking() {
        // This is a simplified representation. In a real app, you'd use ARKit's
        // HandAnchor or InputDevicePoseComponent for precise tracking.
        // For this example, we'll simulate checking distance in a loop.
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            guard isGameActive else { return }
            // In a real VisionOS app, you would get the hand position from ARKit.
            // let handPosition = arkitSession.queryHandPosition()
            // For now, we simulate this check.
        }
    }

    // MARK: - Game Lifecycle
    
    /// Starts the game for the selected level.
    private func startGame() {
        score = 0
        timeLeft = 60
        isGameActive = true
        showLevelSelector = false
        
        // Start the game countdown timer
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            guard self.timeLeft > 0 else {
                endGame()
                return
            }
            self.timeLeft -= 1
        }
        
        // Start spawning objects based on the level
        let spawnInterval = currentLevel == .meteorCatch ? 1.5 : 1.2
        spawnTimer = Timer.scheduledTimer(withTimeInterval: spawnInterval, repeats: true) { _ in
            spawnObject()
        }
    }

    /// Ends the current game session and resets timers.
    private func endGame() {
        isGameActive = false
        gameTimer?.invalidate()
        spawnTimer?.invalidate()
        
        // Remove all game objects from the scene
        contentEntity.children.removeAll()
        
        // Show level selector again
        withAnimation {
            showLevelSelector = true
        }
    }

    // MARK: - Game Logic
    
    /// Spawns a meteor or a black hole based on the current level.
    private func spawnObject() {
        let meteor = createMeteorEntity()
        contentEntity.addChild(meteor)
        
        if currentLevel == .gravityDistortion {
            // Occasionally spawn a black hole that affects meteors
            if Double.random(in: 0...1) < 0.25 {
                let blackHole = createBlackHoleEntity()
                contentEntity.addChild(blackHole)
                
                // The distortion logic would be applied in the update loop
                // by checking distances between meteors and black holes.
            }
        }
    }

    /// Creates a single meteor entity with physics properties.
    private func createMeteorEntity() -> Entity {
        let meteor = ModelEntity(
            mesh: .generateSphere(radius: 0.05),
            materials: [SimpleMaterial(color: .brown, roughness: 0.8, isMetallic: false)]
        )
        
        // Set a random starting position away from the user
        let x = Float.random(in: -2...2)
        let y = Float.random(in: -1...1.5)
        let z = Float.random(in: -3...(-5))
        meteor.position = SIMD3<Float>(x, y, z)
        
        // Add physics body and collision shape
        meteor.generateCollisionShapes(recursive: false)
        meteor.components.set(PhysicsBodyComponent(massProperties: .default, mode: .dynamic))
        
        // Give it an initial push towards the user
        let impulse = SIMD3<Float>(0, 0, 2.5) // Adjust force as needed
        meteor.addForce(impulse, relativeTo: nil)
        
        // Add a component to identify it as a catchable object
        meteor.components.set(CatchableComponent())
        
        return meteor
    }
    
    /// Creates a black hole entity for the advanced level.
    private func createBlackHoleEntity() -> Entity {
        let blackHole = ModelEntity(
            mesh: .generateSphere(radius: 0.2),
            materials: [UnlitMaterial(color: .black)]
        )
        
        // Position it somewhere in the scene to affect meteors
        let x = Float.random(in: -1.5...1.5)
        let y = Float.random(in: -0.5...1.0)
        let z = Float.random(in: -2...(-3))
        blackHole.position = SIMD3<Float>(x, y, z)
        
        // Add a component to identify it as a gravity source
        blackHole.components.set(GravitySourceComponent())
        
        return blackHole
    }
    
    /// Handles the logic for catching an entity.
    private func handleCatch(entity: Entity) {
        // Ensure the tapped entity is a catchable meteor
        guard entity.components.has(CatchableComponent.self) else { return }
        
        // Increase score
        score += 10
        
        // Provide feedback (e.g., play a sound, show an effect)
        // playSound("zap.wav")
        
        // Remove the caught entity from the scene
        entity.removeFromParent()
    }
}

// MARK: - UI Components

/// A view to select the game difficulty level.
struct LevelSelectionView: View {
    @Binding var currentLevel: GameLevel
    @Binding var showLevelSelector: Bool
    var onStart: () -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Select Your Mission")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // Level 1 Button
            Button(action: {
                currentLevel = .meteorCatch
                onStart()
            }) {
                VStack {
                    Text("Meteor Catch")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("Normal Difficulty")
                        .font(.headline)
                        .opacity(0.8)
                }
                .padding()
                .frame(maxWidth: 300)
                .background(.green.opacity(0.8))
                .cornerRadius(20)
            }
            
            // Level 2 Button
            Button(action: {
                currentLevel = .gravityDistortion
                onStart()
            }) {
                VStack {
                    Text("Gravity Distortion")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("Advanced Difficulty")
                        .font(.headline)
                        .opacity(0.8)
                }
                .padding()
                .frame(maxWidth: 300)
                .background(.red.opacity(0.8))
                .cornerRadius(20)
            }
        }
        .foregroundColor(.white)
        .padding(40)
        .background(.black.opacity(0.5))
        .cornerRadius(30)
    }
}


/// The Heads-Up Display (HUD) for showing game stats.
struct GameHUDView: View {
    @Binding var score: Int
    @Binding var timeLeft: Int
    @Binding var currentLevel: GameLevel
    var onExit: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                // Level and Time Info
                VStack(alignment: .leading) {
                    Text(currentLevel.rawValue)
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Time Left: \(timeLeft)")
                        .font(.headline)
                }
                
                Spacer()
                
                // Score Info
                Text("Score: \(score)")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Exit Button
                Button(action: onExit) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            }
            .padding(20)
            .background(.black.opacity(0.4))
            .cornerRadius(20)
            .padding()
            
            Spacer()
        }
        .foregroundColor(.white)
    }
}

// MARK: - ECS Components & Game Data

/// An enum to define the game's difficulty levels.
enum GameLevel: String {
    case meteorCatch = "Meteor Catch"
    case gravityDistortion = "Gravity Distortion"
}

/// A component to mark an entity as catchable by the player.
struct CatchableComponent: Component, Codable {}

/// A component to mark an entity as a source of gravitational pull.
struct GravitySourceComponent: Component, Codable {}

// MARK: - Preview
#if DEBUG
struct SpaceCatcherMainView_Previews: PreviewProvider {
    static var previews: some View {
        PlaySpaceCatcherMainView()
    }
}
#endif

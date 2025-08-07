//
//  PlayCandyMainMenu.swift
//  hack_spatial_rizki_sg
//
//  Created by NUS on 7/8/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

//@main
//struct CandyPlanetApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//        
//        ImmersiveSpace(id: "CandyWorld") {
//            CandyWorldView()
//        }
//    }
//}

//struct PlayCandyContentView: View {
//    @State private var showImmersiveSpace = false
//    @State private var immersiveSpaceIsShown = false
//    @State private var selectedLevel: GameLevel = .beginner
//    
//    @Environment(\.openImmersiveSpace) var openImmersiveSpace
//    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
//    
//    enum GameLevel: String, CaseIterable {
//        case beginner = "Sweet Beginnings 🍬"
//        case advanced = "Candy Master 🎯"
//        
//        var description: String {
//            switch self {
//            case .beginner:
//                return "Perfect for building focus and coordination. Slow-moving candies with clear visual cues."
//            case .advanced:
//                return "Challenge your skills! Fast candies from multiple angles with golden bonuses."
//            }
//        }
//        
//        var therapeuticBenefits: [String] {
//            switch self {
//            case .beginner:
//                return ["✓ Improve hand-eye coordination", "✓ Build confidence", "✓ Reduce anxiety", "✓ Basic depth perception"]
//            case .advanced:
//                return ["✓ Enhanced focus training", "✓ Quick decision making", "✓ Advanced spatial awareness", "✓ Reaction time improvement"]
//            }
//        }
//    }
//    
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 30) {
//                // Header
//                VStack(spacing: 10) {
//                    Text("🍭 Candy Planet Therapy")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .foregroundStyle(.primary)
//                    
//                    Text("Therapeutic VR Experience for Focus & Coordination")
//                        .font(.headline)
//                        .foregroundStyle(.secondary)
//                }
//                
//                // Level Selection
//                VStack(alignment: .leading, spacing: 20) {
//                    Text("Choose Your Challenge Level")
//                        .font(.title2)
//                        .fontWeight(.semibold)
//                    
//                    ForEach(GameLevel.allCases, id: \.self) { level in
//                        LevelCard(
//                            level: level,
//                            isSelected: selectedLevel == level
//                        ) {
//                            selectedLevel = level
//                        }
//                    }
//                }
//                
//                Spacer()
//                
//                // Start Button
//                Button(action: {
//                    Task {
//                        switch await openImmersiveSpace(id: "CandyWorld") {
//                        case .opened:
//                            immersiveSpaceIsShown = true
//                        case .error, .userCancelled:
//                            break
//                        @unknown default:
//                            break
//                        }
//                    }
//                }) {
//                    HStack {
//                        Image(systemName: "play.circle.fill")
//                            .font(.title2)
//                        Text("Enter Candy World")
//                            .font(.title3)
//                            .fontWeight(.semibold)
//                    }
//                    .padding(.horizontal, 40)
//                    .padding(.vertical, 15)
//                    .background(.blue.gradient)
//                    .foregroundColor(.white)
//                    .clipShape(Capsule())
//                }
//                .disabled(immersiveSpaceIsShown)
//                
//                if immersiveSpaceIsShown {
//                    Button("Exit Candy World") {
//                        Task {
//                            await dismissImmersiveSpace()
//                            immersiveSpaceIsShown = false
//                        }
//                    }
//                    .padding()
//                }
//            }
//            .padding(40)
//        }
//        .preferredColorScheme(.light)
//    }
//}
//
//struct LevelCard: View {
//    let level: PlayCandyContentView.GameLevel
//    let isSelected: Bool
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            VStack(alignment: .leading, spacing: 15) {
//                HStack {
//                    Text(level.rawValue)
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                    
//                    Spacer()
//                    
//                    if isSelected {
//                        Image(systemName: "checkmark.circle.fill")
//                            .foregroundColor(.green)
//                            .font(.title2)
//                    }
//                }
//                
//                Text(level.description)
//                    .font(.body)
//                    .foregroundStyle(.secondary)
//                
//                VStack(alignment: .leading, spacing: 5) {
//                    Text("Therapeutic Benefits:")
//                        .font(.caption)
//                        .fontWeight(.medium)
//                        .foregroundStyle(.primary)
//                    
//                    ForEach(level.therapeuticBenefits, id: \.self) { benefit in
//                        Text(benefit)
//                            .font(.caption2)
//                            .foregroundStyle(.secondary)
//                    }
//                }
//            }
//            .padding(20)
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .background(isSelected ? .blue.opacity(0.1) : .gray.opacity(0.05))
//            .overlay(
//                RoundedRectangle(cornerRadius: 12)
//                    .stroke(isSelected ? .blue : .gray.opacity(0.3), lineWidth: isSelected ? 2 : 1)
//            )
//            .clipShape(RoundedRectangle(cornerRadius: 12))
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}
//
//struct CandyWorldView: View {
//    @State private var gameManager = CandyGameManager()
//    
//    var body: some View {
//        RealityView { content in
//            // Setup the candy world
//            await gameManager.setupWorld(content: content)
//        } update: { content in
//            // Update game state
//            gameManager.updateWorld()
//        }
//        .gesture(
//            TapGesture()
//                .targetedToAnyEntity()
//                .onEnded { value in
//                    gameManager.handleTap(on: value.entity)
//                }
//        )
//        .overlay(alignment: .top) {
//            GameHUD(gameManager: gameManager)
//        }
//    }
//}
//
//struct GameHUD: View {
//    @Bindable var gameManager: CandyGameManager
//    
//    var body: some View {
//        VStack(spacing: 10) {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text("Score: \(gameManager.score)")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                    
//                    Text("Accuracy: \(Int(gameManager.accuracy * 100))%")
//                        .font(.caption)
//                        .foregroundStyle(.secondary)
//                }
//                
//                Spacer()
//                
//                VStack(alignment: .trailing) {
//                    Text("Level: \(gameManager.currentLevel)")
//                        .font(.headline)
//                    
//                    Text("Streak: \(gameManager.streak)")
//                        .font(.caption)
//                        .foregroundStyle(.secondary)
//                }
//            }
//            
//            // Progress bar for current session
//            ProgressView(value: gameManager.sessionProgress)
//                .progressViewStyle(.linear)
//                .scaleEffect(y: 2)
//        }
//        .padding(20)
//        .background(.thinMaterial)
//        .clipShape(RoundedRectangle(cornerRadius: 15))
//        .padding(.horizontal, 40)
//    }
//}
//
//@Observable
//class CandyGameManager {
//    var score = 0
//    var accuracy: Float = 1.0
//    var streak = 0
//    var currentLevel = 1
//    var sessionProgress: Float = 0.0
//    
//    private var candyEntities: [Entity] = []
//    private var totalAttempts = 0
//    private var successfulCatches = 0
//    private var gameTimer: Timer?
//    private var worldAnchor: Entity?
//    
//    func setupWorld(content: RealityViewContent) async {
//        // Create world anchor
//        let anchor = Entity()
//        anchor.name = "CandyWorldAnchor"
//        content.add(anchor)
//        worldAnchor = anchor
//        
//        // Create candy planet environment
//        await createCandyEnvironment(anchor: anchor)
//        
//        // Start spawning candies
//        startCandySpawning()
//    }
//    
//    func updateWorld() {
//        // Update candy positions and check for missed candies
//        updateCandyPositions()
//        cleanupMissedCandies()
//    }
//    
//    func handleTap(on entity: Entity) {
//        guard let candyComponent = entity.components[CandyComponent.self] else { return }
//        
//        totalAttempts += 1
//        
//        if candyComponent.isActive {
//            // Successful catch!
//            successfulCatches += 1
//            score += candyComponent.points
//            streak += 1
//            
//            // Special effects for golden candy
//            if candyComponent.isGolden {
//                score += 50 // Bonus points
//                triggerGoldenCandyEffect(at: entity.position)
//            }
//            
//            // Remove the candy
//            entity.removeFromParent()
//            candyEntities.removeAll { $0 == entity }
//            
//            // Trigger success feedback
//            triggerSuccessFeedback()
//            
//        } else {
//            // Reset streak on miss
//            streak = 0
//        }
//        
//        // Update accuracy
//        accuracy = Float(successfulCatches) / Float(totalAttempts)
//        
//        // Check for level progression
//        checkLevelProgression()
//    }
//    
//    // MARK: - Private Methods
//    
//    private func createCandyEnvironment(anchor: Entity) async {
//        // Create colorful floating islands
//        let island1 = createFloatingIsland(position: SIMD3(0, 0, -3), color: .systemPink)
//        let island2 = createFloatingIsland(position: SIMD3(-2, 1, -4), color: .systemPurple)
//        let island3 = createFloatingIsland(position: SIMD3(2, -1, -5), color: .systemBlue)
//        
//        anchor.addChild(island1)
//        anchor.addChild(island2)
//        anchor.addChild(island3)
//        
//        // Add ambient lighting
//        let lighting = Entity()
////        lighting.components[DirectionalLightComponent.self] = DirectionalLightComponent(
////            color: .white,
////            intensity: 1000,
////            isRealWorldProxy: false
////        )
//        lighting.look(at: SIMD3(0, -1, -1), from: SIMD3(0, 1, 0), relativeTo: nil)
//        anchor.addChild(lighting)
//    }
//    
//    private func createFloatingIsland(position: SIMD3<Float>, color: UIColor) -> Entity {
//        let island = Entity()
//        island.position = position
//        
//        // Create island mesh
//        let mesh = MeshResource.generateSphere(radius: 0.3)
//        var material = SimpleMaterial()
//        material.color = .init(tint: color)
//        material.metallic = 0.2
//        material.roughness = 0.8
//        
//        island.components[ModelComponent.self] = ModelComponent(
//            mesh: mesh,
//            materials: [material]
//        )
//        
//        // Add floating animation
//        let animation = FromToByAnimation<Transform>(
//            name: "float",
//            from: .init(translation: position),
//            to: .init(translation: position + SIMD3(0, 0.2, 0)),
//            duration: 2.0,
//            timing: .easeInOut,
//            isAdditive: false,
//            bindTarget: .transform,
//            blendLayer: 0,
////            repeatMode: .pingPong
//        )
//        
//        if let animationResource = try? AnimationResource.generate(with: animation) {
//            island.playAnimation(animationResource)
//        }
//        
//        return island
//    }
//    
//    private func startCandySpawning() {
//        gameTimer = Timer.scheduledTimer(withTimeInterval: getDifficultySpawnInterval(), repeats: true) { _ in
//            self.spawnCandy()
//        }
//    }
//    
//    private func spawnCandy() {
//        guard let worldAnchor = worldAnchor else { return }
//        
//        let candyTypes: [CandyType] = [.lollipop, .donut, .gummyBear, .chocolate]
//        let randomType = candyTypes.randomElement() ?? .lollipop
//        let isGolden = Float.random(in: 0...1) < 0.15 // 15% chance for golden candy
//        
//        let candy = createCandyEntity(type: randomType, isGolden: isGolden)
//        
//        // Random spawn position with depth variation for therapy
//        let spawnPositions: [SIMD3<Float>] = [
//            SIMD3(-3, 2, -2),    // Left close
//            SIMD3(3, 2, -4),     // Right far
//            SIMD3(0, 3, -3),     // Top center
//            SIMD3(-1.5, 1, -6),  // Left far
//            SIMD3(1.5, 1, -1.5)  // Right close
//        ]
//        
//        let startPosition = spawnPositions.randomElement() ?? SIMD3(0, 2, -3)
//        let targetPosition = SIMD3(0, 0, -2) // Center target area
//        
//        candy.position = startPosition
//        worldAnchor.addChild(candy)
//        candyEntities.append(candy)
//        
//        // Animate candy movement
////        animateCandy(candy, from: startPosition, to: targetPosition)
//    }
//    
//    private func createCandyEntity(type: CandyType, isGolden: Bool) -> Entity {
//        let entity = Entity()
//        entity.name = "Candy_\(type.rawValue)"
//        
//        // Create candy mesh based on type
//        let mesh: MeshResource
//        let baseColor: UIColor
//        
//        switch type {
//        case .lollipop:
//            mesh = MeshResource.generateSphere(radius: 0.15)
//            baseColor = .systemRed
//        case .donut:
//            mesh = MeshResource.generateBox(width: 0.2, height: 0.05, depth: 0.2, cornerRadius: 0.1)
//            baseColor = .systemOrange
//        case .gummyBear:
//            mesh = MeshResource.generateSphere(radius: 0.12)
//            baseColor = .systemGreen
//        case .chocolate:
//            mesh = MeshResource.generateBox(size: 0.15)
//            baseColor = .systemBrown
//        }
//        
//        // Material with glow effect
//        var material = SimpleMaterial()
//        material.color = .init(tint: isGolden ? .systemYellow : baseColor)
//        material.metallic = isGolden ? 0.8 : 0.2
//        material.roughness = isGolden ? 0.1 : 0.6
//        
//        if isGolden {
//            // Add glow for golden candies
////            material.emissiveColor = .init(color: .systemYellow, intensity: 0.5)
//        }
//        
//        entity.components[ModelComponent.self] = ModelComponent(
//            mesh: mesh,
//            materials: [material]
//        )
//        
//        // Add collision component for tap detection
//        entity.components[CollisionComponent.self] = CollisionComponent(
//            shapes: [.generateSphere(radius: 0.2)]
//        )
//        
//        // Add candy component with game data
//        entity.components[CandyComponent.self] = CandyComponent(
//            type: type,
//            isGolden: isGolden,
//            isActive: true,
//            points: isGolden ? 20 : 10
//        )
//        
//        // Add sparkle effect for golden candies
//        if isGolden {
//            addSparkleEffect(to: entity)
//        }
//        
//        return entity
//    }
//    
//    private func animateCandy(_ candy: Entity, from start: SIMD3<Float>, to target: SIMD3<Float>) {
//        let moveAnimation = FromToByAnimation<Transform>(
//            name: "move",
//            from: .init(translation: start),
//            to: .init(translation: target),
//            duration: getDifficultyMoveDuration(),
//            timing: .easeOut,
//            isAdditive: false,
//            bindTarget: .transform,
//            blendLayer: 0,
//            repeatMode: .none
//        )
//        
//        // Add rotation for visual appeal
//        let rotateAnimation = FromToByAnimation<Transform>(
//            name: "rotate",
//            from: .init(rotation: simd_quatf(angle: 0, axis: SIMD3(0, 1, 0))),
//            to: .init(rotation: simd_quatf(angle: .pi * 2, axis: SIMD3(0, 1, 0))),
//            duration: getDifficultyMoveDuration(),
//            timing: .linear,
//            isAdditive: true,
//            bindTarget: .transform,
//            blendLayer: 1,
//            repeatMode: .none
//        )
//        
//        if let moveResource = try? AnimationResource.generate(with: moveAnimation),
//           let rotateResource = try? AnimationResource.generate(with: rotateAnimation) {
//            candy.playAnimation(moveResource)
//            candy.playAnimation(rotateResource)
//        }
//    }
//    
//    private func addSparkleEffect(to entity: Entity) {
//        // Create particle system for sparkles
//        let sparkles = Entity()
//        sparkles.name = "Sparkles"
//        
//        // Simple sparkle effect with rotating small spheres
//        for i in 0..<6 {
//            let sparkle = Entity()
//            let mesh = MeshResource.generateSphere(radius: 0.02)
//            var material = SimpleMaterial()
//            material.color = .init(tint: .white)
////            material.emissiveColor = .init(color: .white, intensity: 1.0)
//            
//            sparkle.components[ModelComponent.self] = ModelComponent(
//                mesh: mesh,
//                materials: [material]
//            )
//            
//            let angle = Float(i) * (.pi * 2 / 6)
//            sparkle.position = SIMD3(
//                cos(angle) * 0.3,
//                sin(angle) * 0.3,
//                0
//            )
//            
//            sparkles.addChild(sparkle)
//        }
//        
//        entity.addChild(sparkles)
//        
//        // Rotate sparkles
//        let rotateAnimation = FromToByAnimation<Transform>(
//            name: "sparkleRotate",
//            from: .init(rotation: simd_quatf(angle: 0, axis: SIMD3(0, 0, 1))),
//            to: .init(rotation: simd_quatf(angle: .pi * 2, axis: SIMD3(0, 0, 1))),
//            duration: 1.0,
//            timing: .linear,
//            isAdditive: false,
//            bindTarget: .transform,
//            blendLayer: 0,
////            repeatMode: .loop
//        )
//        
//        if let resource = try? AnimationResource.generate(with: rotateAnimation) {
//            sparkles.playAnimation(resource)
//        }
//    }
//    
//    private func updateCandyPositions() {
//        // Update session progress
//        sessionProgress = min(1.0, Float(totalAttempts) / 50.0) // 50 attempts per session
//    }
//    
//    private func cleanupMissedCandies() {
//        // Remove candies that are too far or old
//        let missedCandies = candyEntities.filter { candy in
//            // Check if candy is behind the user or too close (missed)
//            candy.position.z > 0 || distance(candy.position, SIMD3(0, 0, 0)) > 8
//        }
//        
//        for candy in missedCandies {
//            if let index = candyEntities.firstIndex(of: candy) {
//                candyEntities.remove(at: index)
//            }
//            candy.removeFromParent()
//            
//            // Count as missed attempt if it was active
//            if candy.components[CandyComponent.self]?.isActive == true {
//                totalAttempts += 1
//                streak = 0 // Reset streak on miss
//                accuracy = Float(successfulCatches) / Float(totalAttempts)
//            }
//        }
//    }
//    
//    private func triggerGoldenCandyEffect(at position: SIMD3<Float>) {
//        // Create explosion effect for golden candy
//        guard let worldAnchor = worldAnchor else { return }
//        
//        let explosion = Entity()
//        explosion.position = position
//        
//        // Create multiple sparkle particles
//        for _ in 0..<12 {
//            let particle = Entity()
//            let mesh = MeshResource.generateSphere(radius: 0.03)
//            var material = SimpleMaterial()
//            material.color = .init(tint: .systemYellow)
////            material.emissiveColor = .init(color: .systemYellow, intensity: 1.0)
//            
//            particle.components[ModelComponent.self] = ModelComponent(
//                mesh: mesh,
//                materials: [material]
//            )
//            
//            let randomDirection = SIMD3<Float>(
//                Float.random(in: -1...1),
//                Float.random(in: -1...1),
//                Float.random(in: -1...1)
//            ).normalized() * Float.random(in: 0.5...1.5)
//            
//            particle.position = SIMD3(0, 0, 0)
//            explosion.addChild(particle)
//            
//            // Animate particles outward
//            let animation = FromToByAnimation<Transform>(
//                name: "explode",
//                from: .init(translation: SIMD3(0, 0, 0)),
//                to: .init(translation: randomDirection),
//                duration: 1.0,
//                timing: .easeOut,
//                isAdditive: false,
//                bindTarget: .transform,
//                blendLayer: 0,
//                repeatMode: .none
//            )
//            
//            if let resource = try? AnimationResource.generate(with: animation) {
//                particle.playAnimation(resource)
//            }
//        }
//        
//        worldAnchor.addChild(explosion)
//        
//        // Remove explosion after animation
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            explosion.removeFromParent()
//        }
//    }
//    
//    private func triggerSuccessFeedback() {
//        // Visual feedback for successful catch
//        // Could add haptic feedback here for real device
//        print("Success! Score: \(score), Streak: \(streak)")
//    }
//    
//    private func checkLevelProgression() {
//        let newLevel = min(5, (score / 100) + 1) // Level up every 100 points
//        if newLevel > currentLevel {
//            currentLevel = newLevel
//            
//            // Restart timer with new difficulty
//            gameTimer?.invalidate()
//            startCandySpawning()
//        }
//    }
//    
//    private func getDifficultySpawnInterval() -> TimeInterval {
//        // Faster spawning at higher levels
//        let baseInterval: TimeInterval = 3.0
//        let levelMultiplier = 1.0 - (Double(currentLevel - 1) * 0.15)
//        return baseInterval * max(0.5, levelMultiplier)
//    }
//    
//    private func getDifficultyMoveDuration() -> TimeInterval {
//        // Faster movement at higher levels
//        let baseDuration: TimeInterval = 4.0
//        let levelMultiplier = 1.0 - (Double(currentLevel - 1) * 0.2)
//        return baseDuration * max(1.0, levelMultiplier)
//    }
//}
//
//// MARK: - Supporting Types
//
//enum CandyType: String, CaseIterable {
//    case lollipop = "lollipop"
//    case donut = "donut"
//    case gummyBear = "gummyBear"
//    case chocolate = "chocolate"
//}
//
//struct CandyComponent: Component {
//    let type: CandyType
//    let isGolden: Bool
//    var isActive: Bool
//    let points: Int
//}
//
//// MARK: - Helper Extensions
//
//extension SIMD3 where Scalar == Float {
//    func normalized() -> SIMD3<Float> {
//        let length = sqrt(x*x + y*y + z*z)
//        guard length > 0 else { return SIMD3(0, 0, 0) }
//        return SIMD3(x/length, y/length, z/length)
//    }
//}
//
//extension Float {
//    static func random(in range: ClosedRange<Float>) -> Float {
//        return Float.random(in: range)
//    }
//}
struct PlayCandyContentView: View {
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    @State private var selectedLevel: GameLevel = .beginner
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    enum GameLevel: String, CaseIterable {
        case beginner = "Sweet Beginnings 🍬"
        case advanced = "Candy Master 🎯"
        
        var description: String {
            switch self {
            case .beginner:
                return "Perfect for building focus and coordination. Slow-moving candies with clear visual cues."
            case .advanced:
                return "Challenge your skills! Fast candies from multiple angles with golden bonuses."
            }
        }
        
        var therapeuticBenefits: [String] {
            switch self {
            case .beginner:
                return ["✓ Improve hand-eye coordination", "✓ Build confidence", "✓ Reduce anxiety", "✓ Basic depth perception"]
            case .advanced:
                return ["✓ Enhanced focus training", "✓ Quick decision making", "✓ Advanced spatial awareness", "✓ Reaction time improvement"]
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 10) {
                    Text("🍭 Candy Planet Therapy")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    
                    Text("Therapeutic VR Experience for Focus & Coordination")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                
                // Level Selection
                VStack(alignment: .leading, spacing: 20) {
                    Text("Choose Your Challenge Level")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ForEach(GameLevel.allCases, id: \.self) { level in
                        LevelCard(
                            level: level,
                            isSelected: selectedLevel == level
                        ) {
                            selectedLevel = level
                        }
                    }
                }
                
                Spacer()
                
                // Start Button
                Button(action: {
                    Task {
                        switch await openImmersiveSpace(id: "CandyWorld") {
                        case .opened:
                            immersiveSpaceIsShown = true
                        case .error, .userCancelled:
                            break
                        @unknown default:
                            break
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: "play.circle.fill")
                            .font(.title2)
                        Text("Enter Candy World")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .background(.blue.gradient)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
                .disabled(immersiveSpaceIsShown)
                
                if immersiveSpaceIsShown {
                    Button("Exit Candy World") {
                        Task {
                            await dismissImmersiveSpace()
                            immersiveSpaceIsShown = false
                        }
                    }
                    .padding()
                }
            }
            .padding(40)
        }
        .preferredColorScheme(.light)
    }
}

struct LevelCard: View {
    let level: PlayCandyContentView.GameLevel
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text(level.rawValue)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.title2)
                    }
                }
                
                Text(level.description)
                    .font(.body)
                    .foregroundStyle(.secondary)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Therapeutic Benefits:")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.primary)
                    
                    ForEach(level.therapeuticBenefits, id: \.self) { benefit in
                        Text(benefit)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(isSelected ? .blue.opacity(0.1) : .gray.opacity(0.05))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? .blue : .gray.opacity(0.3), lineWidth: isSelected ? 2 : 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CandyWorldView: View {
    @State private var gameManager = CandyGameManager()
    
    var body: some View {
        RealityView { content in
            // Setup the candy world
            await gameManager.setupWorld(content: content)
        } update: { content in
            // Update game state
            gameManager.updateWorld()
        }
        .gesture(
            SpatialTapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    gameManager.handleTap(on: value.entity)
                }
        )
        .overlay(alignment: .top) {
            GameHUD(gameManager: gameManager)
        }
    }
}

struct GameHUD: View {
    @Bindable var gameManager: CandyGameManager
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Score: \(gameManager.score)")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Accuracy: \(Int(gameManager.accuracy * 100))%")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Level: \(gameManager.currentLevel)")
                        .font(.headline)
                    
                    Text("Streak: \(gameManager.streak)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            // Progress bar for current session
            ProgressView(value: gameManager.sessionProgress)
                .progressViewStyle(.linear)
                .scaleEffect(y: 2)
        }
        .padding(20)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal, 40)
    }
}

@Observable
class CandyGameManager {
    var score = 0
    var accuracy: Float = 1.0
    var streak = 0
    var currentLevel = 1
    var sessionProgress: Float = 0.0
    
    private var candyEntities: [Entity] = []
    private var totalAttempts = 0
    private var successfulCatches = 0
    private var gameTimer: Timer?
    private var worldAnchor: Entity?
    
    func setupWorld(content: RealityViewContent) async {
        // Create world anchor
        let anchor = AnchorEntity(.head)
        anchor.name = "CandyWorldAnchor"
        content.add(anchor)
        worldAnchor = anchor
        
        // Create candy planet environment
        await createCandyEnvironment(anchor: anchor)
        
        // Start spawning candies
        startCandySpawning()
    }
    
    func updateWorld() {
        // Update candy positions and check for missed candies
        updateCandyPositions()
        cleanupMissedCandies()
    }
    
    func handleTap(on entity: Entity) {
        guard let candyComponent = entity.components[CandyComponent.self] else { return }
        
        totalAttempts += 1
        
        if candyComponent.isActive {
            // Successful catch!
            successfulCatches += 1
            score += candyComponent.points
            streak += 1
            
            // Special effects for golden candy
            if candyComponent.isGolden {
                score += 50 // Bonus points
                triggerGoldenCandyEffect(at: entity.position)
            }
            
            // Remove the candy
            entity.removeFromParent()
            candyEntities.removeAll { $0 == entity }
            
            // Trigger success feedback
            triggerSuccessFeedback()
            
        } else {
            // Reset streak on miss
            streak = 0
        }
        
        // Update accuracy
        accuracy = totalAttempts > 0 ? Float(successfulCatches) / Float(totalAttempts) : 1.0
        
        // Check for level progression
        checkLevelProgression()
    }
    
    // MARK: - Private Methods
    
    private func createCandyEnvironment(anchor: Entity) async {
        // Create colorful floating islands
        let island1 = createFloatingIsland(position: SIMD3<Float>(0, 0, -3), color: .systemPink)
        let island2 = createFloatingIsland(position: SIMD3<Float>(-2, 1, -4), color: .systemPurple)
        let island3 = createFloatingIsland(position: SIMD3<Float>(2, -1, -5), color: .systemBlue)
        
        anchor.addChild(island1)
        anchor.addChild(island2)
        anchor.addChild(island3)
        
        // Add ambient lighting (Simplified for visionOS compatibility)
        let lighting = Entity()
        let lightComponent = DirectionalLightComponent(
            color: .white,
            intensity: 500
        )
        lighting.components.set(lightComponent)
        lighting.look(at: SIMD3<Float>(0, -1, -1), from: SIMD3<Float>(0, 1, 0), relativeTo: nil)
        anchor.addChild(lighting)
    }
    
    private func createFloatingIsland(position: SIMD3<Float>, color: UIColor) -> Entity {
        let island = Entity()
        island.position = position
        
        // Create island mesh
        let mesh = MeshResource.generateSphere(radius: 0.3)
        var material = SimpleMaterial()
        material.color = .init(tint: color)
        material.metallic = 0.2
        material.roughness = 0.8
        
        island.components[ModelComponent.self] = ModelComponent(
            mesh: mesh,
            materials: [material]
        )
        
        // Add floating animation (Fixed for visionOS)
        let startTransform = Transform(translation: position)
        let endTransform = Transform(translation: position + SIMD3<Float>(0, 0.2, 0))
        
        let animation = FromToByAnimation<Transform>(
            name: "float",
            from: startTransform,
            to: endTransform,
            duration: 2.0,
            timing: .easeInOut,
            isAdditive: false,
            bindTarget: .transform,
            blendLayer: 0,
            repeatMode: .autoReverse
        )
        
        if let animationResource = try? AnimationResource.generate(with: animation) {
            let repeatAnimation = animationResource.repeat()
            island.playAnimation(repeatAnimation)
        }
        
        return island
    }
    
    private func startCandySpawning() {
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(withTimeInterval: getDifficultySpawnInterval(), repeats: true) { _ in
            Task {
                await MainActor.run {
                    self.spawnCandy()
                }
            }
        }
    }
    
    private func spawnCandy() {
        guard let worldAnchor = worldAnchor else { return }
        
        let candyTypes: [CandyType] = [.lollipop, .donut, .gummyBear, .chocolate]
        let randomType = candyTypes.randomElement() ?? .lollipop
        let isGolden = Float.random(in: 0...1) < 0.15 // 15% chance for golden candy
        
        let candy = createCandyEntity(type: randomType, isGolden: isGolden)
        
        // Random spawn position with depth variation for therapy
        let spawnPositions: [SIMD3<Float>] = [
            SIMD3<Float>(-3, 2, -2),    // Left close
            SIMD3<Float>(3, 2, -4),     // Right far
            SIMD3<Float>(0, 3, -3),     // Top center
            SIMD3<Float>(-1.5, 1, -6),  // Left far
            SIMD3<Float>(1.5, 1, -1.5)  // Right close
        ]
        
        let startPosition = spawnPositions.randomElement() ?? SIMD3<Float>(0, 2, -3)
        let targetPosition = SIMD3<Float>(0, 0, -2) // Center target area
        
        candy.position = startPosition
        worldAnchor.addChild(candy)
        candyEntities.append(candy)
        
        // Animate candy movement
        animateCandy(candy, from: startPosition, to: targetPosition)
    }
    
    private func createCandyEntity(type: CandyType, isGolden: Bool) -> Entity {
        let entity = Entity()
        entity.name = "Candy_\(type.rawValue)"
        
        // Create candy mesh based on type
        let mesh: MeshResource
        let baseColor: UIColor
        
        switch type {
        case .lollipop:
            mesh = MeshResource.generateSphere(radius: 0.15)
            baseColor = .systemRed
        case .donut:
            mesh = MeshResource.generateBox(width: 0.2, height: 0.05, depth: 0.2, cornerRadius: 0.1)
            baseColor = .systemOrange
        case .gummyBear:
            mesh = MeshResource.generateSphere(radius: 0.12)
            baseColor = .systemGreen
        case .chocolate:
            mesh = MeshResource.generateBox(size: 0.15)
            baseColor = .systemBrown
        }
        
        // Material with glow effect (Fixed for visionOS)
        var material = SimpleMaterial()
        material.color = .init(tint: isGolden ? .systemYellow : baseColor)
        material.metallic = isGolden ? 0.8 : 0.2
        material.roughness = isGolden ? 0.1 : 0.6
        
        entity.components[ModelComponent.self] = ModelComponent(
            mesh: mesh,
            materials: [material]
        )
        
        // Add collision component for tap detection
        entity.components[CollisionComponent.self] = CollisionComponent(
            shapes: [.generateSphere(radius: 0.2)]
        )
        
        // Add input target component for gesture recognition
        entity.components[InputTargetComponent.self] = InputTargetComponent()
        
        // Add candy component with game data
        entity.components[CandyComponent.self] = CandyComponent(
            type: type,
            isGolden: isGolden,
            isActive: true,
            points: isGolden ? 20 : 10
        )
        
        // Add sparkle effect for golden candies
        if isGolden {
            addSparkleEffect(to: entity)
        }
        
        return entity
    }
    
    private func animateCandy(_ candy: Entity, from start: SIMD3<Float>, to target: SIMD3<Float>) {
        let moveAnimation = FromToByAnimation<Transform>(
            name: "move",
            from: Transform(translation: start),
            to: Transform(translation: target),
            duration: getDifficultyMoveDuration(),
            timing: .easeOut,
            isAdditive: false,
            bindTarget: .transform,
            blendLayer: 0,
            repeatMode: .none
        )
        
        // Add rotation for visual appeal
        let rotateAnimation = FromToByAnimation<Transform>(
            name: "rotate",
            from: Transform(rotation: simd_quatf(angle: 0, axis: SIMD3<Float>(0, 1, 0))),
            to: Transform(rotation: simd_quatf(angle: .pi * 2, axis: SIMD3<Float>(0, 1, 0))),
            duration: getDifficultyMoveDuration(),
            timing: .linear,
            isAdditive: true,
            bindTarget: .transform,
            blendLayer: 1,
            repeatMode: .none
        )
        
        if let moveResource = try? AnimationResource.generate(with: moveAnimation),
           let rotateResource = try? AnimationResource.generate(with: rotateAnimation) {
            candy.playAnimation(moveResource)
            candy.playAnimation(rotateResource)
        }
    }
    
    private func addSparkleEffect(to entity: Entity) {
        // Create particle system for sparkles
        let sparkles = Entity()
        sparkles.name = "Sparkles"
        
        // Simple sparkle effect with rotating small spheres
        for i in 0..<6 {
            let sparkle = Entity()
            let mesh = MeshResource.generateSphere(radius: 0.02)
            var material = SimpleMaterial()
            material.color = .init(tint: .white)
            
            sparkle.components[ModelComponent.self] = ModelComponent(
                mesh: mesh,
                materials: [material]
            )
            
            let angle = Float(i) * (.pi * 2 / 6)
            sparkle.position = SIMD3<Float>(
                cos(angle) * 0.3,
                sin(angle) * 0.3,
                0
            )
            
            sparkles.addChild(sparkle)
        }
        
        entity.addChild(sparkles)
        
        // Rotate sparkles (Fixed for visionOS)
        let rotateAnimation = FromToByAnimation<Transform>(
            name: "sparkleRotate",
            from: Transform(rotation: simd_quatf(angle: 0, axis: SIMD3<Float>(0, 0, 1))),
            to: Transform(rotation: simd_quatf(angle: .pi * 2, axis: SIMD3<Float>(0, 0, 1))),
            duration: 1.0,
            timing: .linear,
            isAdditive: false,
            bindTarget: .transform,
            blendLayer: 0,
            repeatMode: .autoReverse
        )
        
        if let resource = try? AnimationResource.generate(with: rotateAnimation) {
            let repeatAnimation = resource.repeat()
            sparkles.playAnimation(repeatAnimation)
        }
    }
    
    private func updateCandyPositions() {
        // Update session progress
        sessionProgress = min(1.0, Float(totalAttempts) / 50.0) // 50 attempts per session
    }
    
    private func cleanupMissedCandies() {
        // Remove candies that are too far or old
        let missedCandies = candyEntities.filter { candy in
            // Check if candy is behind the user or too close (missed)
            candy.position.z > 0 || distance(candy.position, SIMD3<Float>(0, 0, 0)) > 8
        }
        
        for candy in missedCandies {
            if let index = candyEntities.firstIndex(of: candy) {
                candyEntities.remove(at: index)
            }
            candy.removeFromParent()
            
            // Count as missed attempt if it was active
            if candy.components[CandyComponent.self]?.isActive == true {
                totalAttempts += 1
                streak = 0 // Reset streak on miss
                accuracy = totalAttempts > 0 ? Float(successfulCatches) / Float(totalAttempts) : 1.0
            }
        }
    }
    
    private func triggerGoldenCandyEffect(at position: SIMD3<Float>) {
        // Create explosion effect for golden candy
        guard let worldAnchor = worldAnchor else { return }
        
        let explosion = Entity()
        explosion.position = position
        
        // Create multiple sparkle particles
        for _ in 0..<12 {
            let particle = Entity()
            let mesh = MeshResource.generateSphere(radius: 0.03)
            var material = SimpleMaterial()
            material.baseColor = MaterialColorParameter.color(.systemYellow)
            
            particle.components[ModelComponent.self] = ModelComponent(
                mesh: mesh,
                materials: [material]
            )
            
            let randomDirection = SIMD3<Float>(
                Float.random(in: -1...1),
                Float.random(in: -1...1),
                Float.random(in: -1...1)
            ).normalized() * Float.random(in: 0.5...1.5)
            
            particle.position = SIMD3<Float>(0, 0, 0)
            explosion.addChild(particle)
            
            // Animate particles outward
            let animation = FromToByAnimation<Transform>(
                name: "explode",
                from: Transform(translation: SIMD3<Float>(0, 0, 0)),
                to: Transform(translation: randomDirection),
                duration: 1.0,
                timing: .easeOut,
                isAdditive: false,
                bindTarget: .transform,
                blendLayer: 0,
                repeatMode: .none
            )
            
            if let resource = try? AnimationResource.generate(with: animation) {
                particle.playAnimation(resource)
            }
        }
        
        worldAnchor.addChild(explosion)
        
        // Remove explosion after animation
        Task {
            try? await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds
            explosion.removeFromParent()
        }
    }
    
    private func triggerSuccessFeedback() {
        // Visual feedback for successful catch
        print("Success! Score: \(score), Streak: \(streak)")
        
        // Add haptic feedback for real device
        #if os(visionOS)
        // Haptic feedback would go here
        #endif
    }
    
    private func checkLevelProgression() {
        let newLevel = min(5, (score / 100) + 1) // Level up every 100 points
        if newLevel > currentLevel {
            currentLevel = newLevel
            
            // Restart timer with new difficulty
            startCandySpawning()
        }
    }
    
    private func getDifficultySpawnInterval() -> TimeInterval {
        // Faster spawning at higher levels
        let baseInterval: TimeInterval = 3.0
        let levelMultiplier = 1.0 - (Double(currentLevel - 1) * 0.15)
        return baseInterval * max(0.5, levelMultiplier)
    }
    
    private func getDifficultyMoveDuration() -> TimeInterval {
        // Faster movement at higher levels
        let baseDuration: TimeInterval = 4.0
        let levelMultiplier = 1.0 - (Double(currentLevel - 1) * 0.2)
        return baseDuration * max(1.0, levelMultiplier)
    }
}

// MARK: - Supporting Types

enum CandyType: String, CaseIterable {
    case lollipop = "lollipop"
    case donut = "donut"
    case gummyBear = "gummyBear"
    case chocolate = "chocolate"
}

struct CandyComponent: Component {
    let type: CandyType
    let isGolden: Bool
    var isActive: Bool
    let points: Int
}

// MARK: - Helper Extensions

extension SIMD3 where Scalar == Float {
    func normalized() -> SIMD3<Float> {
        let length = sqrt(x*x + y*y + z*z)
        guard length > 0 else { return SIMD3<Float>(0, 0, 0) }
        return SIMD3<Float>(x/length, y/length, z/length)
    }
}

extension Float {
    static func random(in range: ClosedRange<Float>) -> Float {
        return Float.random(in: range)
    }
}

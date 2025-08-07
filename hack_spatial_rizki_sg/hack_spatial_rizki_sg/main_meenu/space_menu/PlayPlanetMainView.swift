//
//  PlayPlanetMainView.swift
//  hack_spatial_rizki_sg
//
//  Created by NUS on 7/8/25.
//

//import SwiftUI
//
////struct PlayPlanetMainView: View {
////    var body: some View {
////        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
////    }
////}
////
////#Preview {
////    PlayPlanetMainView()
////}
import SwiftUI
import RealityKit
import RealityKitContent
import AVFoundation

//@main
//struct PlanetCatchApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//        .windowStyle(.volumetric)
//        .defaultSize(width: 2, height: 2, depth: 2, in: .meters)
//    }
//}

//struct PlayPlanetMainView: View {
//    @StateObject private var gameState = GameState()
//    @State private var audioPlayer: AVAudioPlayer?
//    
//    var body: some View {
//        ZStack {
//            if gameState.gameStarted {
//                RealityView { content in
//                    setupGame(content: content)
//                } update: { content in
//                    updateGame(content: content)
//                }
//            } else {
//                MenuView(gameState: gameState)
//            }
//            
//            // UI Overlay
//            VStack {
//                if gameState.gameStarted {
//                    HStack {
//                        Text("Score: \(gameState.score)")
//                            .font(.title2)
//                            .foregroundColor(.white)
//                        Spacer()
//                        Text("Level: \(gameState.currentLevel)")
//                            .font(.title2)
//                            .foregroundColor(.white)
//                        Spacer()
//                        Text("Health: \(gameState.health)/3")
//                            .font(.title2)
//                            .foregroundColor(gameState.health <= 1 ? .red : .white)
//                    }
//                    .padding()
//                    Spacer()
//                    
//                    if gameState.gameOver {
//                        GameOverView(gameState: gameState)
//                    }
//                }
//            }
//        }
//        .preferredColorScheme(.dark)
//    }
//    
//    func setupGame(content: RealityViewContent) {
//        // Setup background space environment
//        let backgroundEntity = Entity()
//        backgroundEntity.name = "background"
//        
//        // Create starfield
//        for _ in 0..<200 {
//            let star = Entity()
//            star.components.set(ModelComponent(
//                mesh: .generateSphere(radius: 0.005),
//                materials: [SimpleMaterial(color: .white, isMetallic: false)]
//            ))
//            
//            let x = Float.random(in: -5...5)
//            let y = Float.random(in: -5...5)
//            let z = Float.random(in: -8...-2)
//            star.position = SIMD3(x, y, z)
//            
//            backgroundEntity.addChild(star)
//        }
//        content.add(backgroundEntity)
//        
//        // Setup game area boundaries
//        let boundary = Entity()
//        boundary.name = "boundary"
//        content.add(boundary)
//        
//        playBackgroundMusic()
//    }
//    
//    func updateGame(content: RealityViewContent) {
//        guard gameState.gameStarted && !gameState.gameOver else { return }
//        
//        // Spawn objects based on level
//        if gameState.shouldSpawnObject {
//            spawnGameObject(content: content)
//            gameState.resetSpawnTimer()
//        }
//        
//        // Update existing objects
//        updateGameObjects(content: content)
//        
//        gameState.update()
//    }
//    
//    func spawnGameObject(content: RealityViewContent) {
//        let objectType = GameObjectType.random(for: gameState.currentLevel)
//        let entity = createGameObject(type: objectType)
//        
//        // Position object randomly around the player
//        let angle = Float.random(in: 0...(2 * Float.pi))
//        let distance = Float.random(in: 2...4)
//        let height = Float.random(in: -1...1)
//        
//        entity.position = SIMD3(
//            cos(angle) * distance,
//            height,
//            sin(angle) * distance - 2
//        )
//        
//        // Add movement component
//        entity.components.set(MovementComponent(
//            velocity: calculateVelocity(for: objectType, level: gameState.currentLevel),
//            objectType: objectType
//        ))
//        
//        content.add(entity)
//    }
//    
//    func createGameObject(type: GameObjectType) -> Entity {
//        let entity = Entity()
//        entity.name = type.rawValue
//        
//        var material: Material
//        var scale: Float = 1.0
//        
//        switch type {
//        case .meteor:
//            material = SimpleMaterial(color: .orange, isMetallic: true)
//            scale = 0.15
//        case .planet:
//            material = SimpleMaterial(color: .blue, isMetallic: false)
//            scale = 0.2
//        case .satellite:
//            material = SimpleMaterial(color: .silver, isMetallic: true)
//            scale = 0.1
//        case .blackHole:
//            material = SimpleMaterial(color: .black, isMetallic: false)
//            scale = 0.3
//        }
//        
//        entity.components.set(ModelComponent(
//            mesh: .generateSphere(radius: scale),
//            materials: [material]
//        ))
//        
//        // Add glow effect for planets and meteors
//        if type != .blackHole {
//            let glowEntity = Entity()
//            glowEntity.components.set(ModelComponent(
//                mesh: .generateSphere(radius: scale * 1.2),
//                materials: [UnlitMaterial(color: type.glowColor.withAlphaComponent(0.3))]
//            ))
//            entity.addChild(glowEntity)
//        }
//        
//        // Add collision component
//        entity.components.set(CollisionComponent(shapes: [.generateSphere(radius: scale)]))
//        entity.components.set(InputTargetComponent())
//        
//        // Add rotation animation
//        let rotationAnimation = AnimationResource.makeRotation(
//            angle: .pi * 2,
//            axis: SIMD3(0, 1, 0),
//            duration: 2.0,
//            repeatMode: .repeat
//        )
//        entity.playAnimation(rotationAnimation)
//        
//        return entity
//    }
//    
//    func calculateVelocity(for type: GameObjectType, level: Int) -> SIMD3<Float> {
//        let baseSpeed: Float = level == 1 ? 0.5 : 1.0
//        let speedMultiplier = type.speedMultiplier
//        
//        let direction = SIMD3(
//            Float.random(in: -1...1),
//            Float.random(in: -0.5...0.5),
//            Float.random(in: -1...1)
//        )
//        let normalizedDirection = normalize(direction)
//        
//        return normalizedDirection * baseSpeed * speedMultiplier
//    }
//    
//    func updateGameObjects(content: RealityViewContent) {
//        for entity in content.entities {
//            guard let movement = entity.components[MovementComponent.self] else { continue }
//            
//            // Update position
//            entity.position += movement.velocity * 0.016 // ~60fps
//            
//            // Remove objects that are too far away
//            let distance = length(entity.position)
//            if distance > 10 {
//                content.remove(entity)
//            }
//            
//            // Handle black hole gravity effect
//            if movement.objectType == .blackHole {
//                applyBlackHoleGravity(blackHole: entity, content: content)
//            }
//        }
//    }
//    
//    func applyBlackHoleGravity(blackHole: Entity, content: RealityViewContent) {
//        for entity in content.entities {
//            guard entity != blackHole,
//                  var movement = entity.components[MovementComponent.self],
//                  movement.objectType != .blackHole else { continue }
//            
//            let distance = length(entity.position - blackHole.position)
//            if distance < 2.0 {
//                let direction = normalize(blackHole.position - entity.position)
//                let gravityForce = direction * 0.02 * (2.0 - distance)
//                movement.velocity += gravityForce
//                entity.components.set(movement)
//            }
//        }
//    }
//    
//    func playBackgroundMusic() {
//        guard let url = Bundle.main.url(forResource: "space_ambient", withExtension: "mp3") else { return }
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.numberOfLoops = -1
//            audioPlayer?.volume = 0.3
//            audioPlayer?.play()
//        } catch {
//            print("Could not play background music: \(error)")
//        }
//    }
//}
//
//// MARK: - Game State Management
//class GameState: ObservableObject {
//    @Published var gameStarted = false
//    @Published var gameOver = false
//    @Published var score = 0
//    @Published var health = 3
//    @Published var currentLevel = 1
//    @Published var shouldSpawnObject = false
//    
//    private var spawnTimer: Timer?
//    private var gameTimer: Timer?
//    
//    func startGame(level: Int) {
//        currentLevel = level
//        gameStarted = true
//        gameOver = false
//        score = 0
//        health = 3
//        
//        startSpawnTimer()
//    }
//    
//    func endGame() {
//        gameOver = true
//        stopTimers()
//    }
//    
//    func resetGame() {
//        gameStarted = false
//        gameOver = false
//        score = 0
//        health = 3
//        stopTimers()
//    }
//    
//    func update() {
//        if health <= 0 {
//            endGame()
//        }
//    }
//    
//    func resetSpawnTimer() {
//        shouldSpawnObject = false
//    }
//    
//    private func startSpawnTimer() {
//        let interval = currentLevel == 1 ? 2.0 : 1.0
//        spawnTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
//            self.shouldSpawnObject = true
//        }
//    }
//    
//    private func stopTimers() {
//        spawnTimer?.invalidate()
//        gameTimer?.invalidate()
//        spawnTimer = nil
//        gameTimer = nil
//    }
//    
//    func objectCaught(_ type: GameObjectType) {
//        switch type {
//        case .meteor:
//            score += 10
//        case .planet:
//            score += 20
//        case .satellite:
//            score += 15
//        case .blackHole:
//            health -= 1
//        }
//    }
//}
//
//// MARK: - Game Components
//struct MovementComponent: Component {
//    var velocity: SIMD3<Float>
//    var objectType: GameObjectType
//}
//
//enum GameObjectType: String, CaseIterable {
//    case meteor = "meteor"
//    case planet = "planet"
//    case satellite = "satellite"
//    case blackHole = "blackHole"
//    
//    var speedMultiplier: Float {
//        switch self {
//        case .meteor: return 2.0
//        case .planet: return 0.8
//        case .satellite: return 1.5
//        case .blackHole: return 0.3
//        }
//    }
//    
//    var glowColor: UIColor {
//        switch self {
//        case .meteor: return .orange
//        case .planet: return .blue
//        case .satellite: return .cyan
//        case .blackHole: return .purple
//        }
//    }
//    
//    static func random(for level: Int) -> GameObjectType {
//        let level1Objects: [GameObjectType] = [.meteor, .planet, .satellite]
//        let level2Objects: [GameObjectType] = [.meteor, .planet, .satellite, .blackHole]
//        
//        let availableObjects = level == 1 ? level1Objects : level2Objects
//        return availableObjects.randomElement()!
//    }
//}
//
//// MARK: - UI Views
//struct MenuView: View {
//    @ObservedObject var gameState: GameState
//    
//    var body: some View {
//        VStack(spacing: 30) {
//            Text("🌌 PLANET CATCH")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .foregroundColor(.white)
//            
//            Text("Therapeutic Space Adventure")
//                .font(.title2)
//                .foregroundColor(.gray)
//            
//            VStack(spacing: 20) {
//                Button("Level 1 - Gentle") {
//                    gameState.startGame(level: 1)
//                } .buttonStyle(GameButtonStyle(color: .blue))
//                
//                Button("Level 2 - Challenge") {
//                    gameState.startGame(level: 2)
//                } .buttonStyle(GameButtonStyle(color: .red))
//            }
//            
//            VStack(alignment: .leading, spacing: 10) {
//                Text("How to Play:")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                
//                Text("👆 Tap meteors, planets, and satellites to catch them")
//                Text("⚫ Avoid black holes - they damage your health")
//                Text("🎯 Perfect for improving hand-eye coordination")
//                Text("🧠 Great therapy for stroke and ADHD patients")
//            }
//            .font(.body)
//            .foregroundColor(.gray)
//            .padding()
//            .background(Color.black.opacity(0.3))
//            .cornerRadius(15)
//        }
//        .padding(40)
//    }
//}
//
//struct GameOverView: View {
//    @ObservedObject var gameState: GameState
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Game Over!")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .foregroundColor(.white)
//            
//            Text("Final Score: \(gameState.score)")
//                .font(.title)
//                .foregroundColor(.yellow)
//            
//            Text("Level: \(gameState.currentLevel)")
//                .font(.title2)
//                .foregroundColor(.gray)
//            
//            HStack(spacing: 20) {
//                Button("Play Again") {
//                    gameState.startGame(level: gameState.currentLevel)
//                }
//                .buttonStyle(GameButtonStyle(color: .green))
//                
//                Button("Menu") {
//                    gameState.resetGame()
//                }
//                .buttonStyle(GameButtonStyle(color: .blue))
//            }
//        }
//        .padding(30)
//        .background(Color.black.opacity(0.8))
//        .cornerRadius(20)
//    }
//}
//
//struct GameButtonStyle: ButtonStyle {
//    let color: Color
//    
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .font(.title2)
//            .fontWeight(.semibold)
//            .foregroundColor(.white)
//            .padding(.horizontal, 30)
//            .padding(.vertical, 15)
//            .background(color.opacity(configuration.isPressed ? 0.6 : 0.8))
//            .cornerRadius(25)
//            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
//    }
//}


//PlayPlanetMainView



import SwiftUI
import RealityKit
import AVFoundation
import AudioToolbox

//@main
//struct PlanetCatchApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//        .windowStyle(.volumetric)
//        .defaultSize(width: 2, height: 2, depth: 2, in: .meters)
//    }
//}

struct PlayPlanetMainView: View {
    @StateObject private var gameState = GameState()
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        ZStack {
            if gameState.gameStarted {
                RealityView { content in
                    setupGame(content: content)
                } update: { content in
                    updateGame(content: content)
                }
                .gesture(
                    SpatialTapGesture()
                        .targetedToAnyEntity()
                        .onEnded { event in
                            handleTap(entity: event.entity)
                        }
                )
            } else {
                MenuView(gameState: gameState)
            }
            
            // UI Overlay
            VStack {
                if gameState.gameStarted {
                    HStack {
                        Text("Score: \(gameState.score)")
                            .font(.title2)
                            .foregroundColor(.white)
                        Spacer()
                        Text("Level: \(gameState.currentLevel)")
                            .font(.title2)
                            .foregroundColor(.white)
                        Spacer()
                        Text("Health: \(gameState.health)/3")
                            .font(.title2)
                            .foregroundColor(gameState.health <= 1 ? .red : .white)
                    }
                    .padding()
                    Spacer()
                    
                    if gameState.gameOver {
                        GameOverView(gameState: gameState)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    func setupGame(content: RealityViewContent) {
        // Setup background space environment
        let backgroundEntity = Entity()
        backgroundEntity.name = "background"
        
        // Create starfield
        for _ in 0..<200 {
            let star = Entity()
            let starMaterial = SimpleMaterial(color: UIColor.white, isMetallic: false)
            star.components.set(ModelComponent(
                mesh: .generateSphere(radius: 0.005),
                materials: [starMaterial]
            ))
            
            let x = Float.random(in: -5...5)
            let y = Float.random(in: -5...5)
            let z = Float.random(in: -8...(-2))
            star.position = SIMD3(x, y, z)
            
            backgroundEntity.addChild(star)
        }
        content.add(backgroundEntity)
        
        // Setup game area boundaries
        let boundary = Entity()
        boundary.name = "boundary"
        content.add(boundary)
        
        playBackgroundMusic()
    }
    
    func updateGame(content: RealityViewContent) {
        guard gameState.gameStarted && !gameState.gameOver else { return }
        
        // Spawn objects based on level
        if gameState.shouldSpawnObject {
            spawnGameObject(content: content)
            gameState.resetSpawnTimer()
        }
        
        // Update existing objects
        updateGameObjects(content: content)
        
        // Update rotations
        updateRotations(content: content)
        
        gameState.update()
    }
    
    func spawnGameObject(content: RealityViewContent) {
        let objectType = GameObjectType.random(for: gameState.currentLevel)
        let entity = createGameObject(type: objectType)
        
        // Position object randomly around the player
        let angle = Float.random(in: 0...(2 * Float.pi))
        let distance = Float.random(in: 2...4)
        let height = Float.random(in: -1...1)
        
        entity.position = SIMD3(
            cos(angle) * distance,
            height,
            sin(angle) * distance - 2
        )
        
        // Add movement component
        entity.components.set(MovementComponent(
            velocity: calculateVelocity(for: objectType, level: gameState.currentLevel),
            objectType: objectType
        ))
        
        content.add(entity)
    }
    
    func createGameObject(type: GameObjectType) -> Entity {
        let entity = Entity()
        entity.name = type.rawValue
        
        var material: SimpleMaterial
        var scale: Float = 1.0
        
        switch type {
        case .meteor:
            material = SimpleMaterial(color: UIColor.orange, isMetallic: true)
            scale = 0.15
        case .planet:
            material = SimpleMaterial(color: UIColor.blue, isMetallic: false)
            scale = 0.2
        case .satellite:
            material = SimpleMaterial(color: UIColor.lightGray, isMetallic: true)
            scale = 0.1
        case .blackHole:
            material = SimpleMaterial(color: UIColor.black, isMetallic: false)
            scale = 0.3
        }
        
        entity.components.set(ModelComponent(
            mesh: .generateSphere(radius: scale),
            materials: [material]
        ))
        
        // Add glow effect for planets and meteors
        if type != .blackHole {
            let glowEntity = Entity()
            let glowMaterial = SimpleMaterial(color: type.glowColor.withAlphaComponent(0.3), isMetallic: false)
            glowEntity.components.set(ModelComponent(
                mesh: .generateSphere(radius: scale * 1.2),
                materials: [glowMaterial]
            ))
            entity.addChild(glowEntity)
        }
        
        // Add collision component
        entity.components.set(CollisionComponent(shapes: [.generateSphere(radius: scale)]))
        
        // Add simple rotation using transform updates
        addRotationBehavior(to: entity)
        
        return entity
    }
    
    func calculateVelocity(for type: GameObjectType, level: Int) -> SIMD3<Float> {
        let baseSpeed: Float = level == 1 ? 0.5 : 1.0
        let speedMultiplier = type.speedMultiplier
        
        let direction = SIMD3(
            Float.random(in: -1...1),
            Float.random(in: -0.5...0.5),
            Float.random(in: -1...1)
        )
        let normalizedDirection = normalize(direction)
        
        return normalizedDirection * baseSpeed * speedMultiplier
    }
    
    func updateGameObjects(content: RealityViewContent) {
        for entity in content.entities {
            guard let movement = entity.components[MovementComponent.self] else { continue }
            
            // Update position
            entity.position += movement.velocity * 0.016 // ~60fps
            
            // Remove objects that are too far away
            let distance = length(entity.position)
            if distance > 10 {
                content.remove(entity)
            }
            
            // Handle black hole gravity effect
            if movement.objectType == .blackHole {
                applyBlackHoleGravity(blackHole: entity, content: content)
            }
        }
    }
    
    func applyBlackHoleGravity(blackHole: Entity, content: RealityViewContent) {
        for entity in content.entities {
            guard entity != blackHole,
                  var movement = entity.components[MovementComponent.self],
                  movement.objectType != .blackHole else { continue }
            
            let distance = length(entity.position - blackHole.position)
            if distance < 2.0 {
                let direction = normalize(blackHole.position - entity.position)
                let gravityForce = direction * 0.02 * (2.0 - distance)
                movement.velocity += gravityForce
                entity.components.set(movement)
            }
        }
    }
    
    func addRotationBehavior(to entity: Entity) {
        // Add a component to track rotation
        entity.components.set(RotationComponent())
    }
    
    func updateRotations(content: RealityViewContent) {
        for entity in content.entities {
            if entity.components[RotationComponent.self] != nil {
                let currentRotation = entity.transform.rotation
                let deltaRotation = simd_quatf(angle: 0.02, axis: SIMD3(0, 1, 0))
                entity.transform.rotation = currentRotation * deltaRotation
            }
        }
    }
    
    func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "space_ambient", withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.volume = 0.3
            audioPlayer?.play()
        } catch {
            print("Could not play background music: \(error)")
        }
    }
    
    func handleTap(entity: Entity) {
        guard let objectType = GameObjectType(rawValue: entity.name) else { return }
        
        // Remove the tapped entity
        entity.removeFromParent()
        
        // Update game state based on object type
        gameState.objectCaught(objectType)
        
        // Play sound effect based on object type
        playTapSound(for: objectType)
    }
    
    func playTapSound(for type: GameObjectType) {
        // Play system sound for tap feedback
        AudioServicesPlaySystemSound(1104) // Pop sound
    }
}

// MARK: - Game State Management
class GameState: ObservableObject {
    @Published var gameStarted = false
    @Published var gameOver = false
    @Published var score = 0
    @Published var health = 3
    @Published var currentLevel = 1
    @Published var shouldSpawnObject = false
    
    private var spawnTimer: Timer?
    private var gameTimer: Timer?
    
    func startGame(level: Int) {
        currentLevel = level
        gameStarted = true
        gameOver = false
        score = 0
        health = 3
        
        startSpawnTimer()
    }
    
    func endGame() {
        gameOver = true
        stopTimers()
    }
    
    func resetGame() {
        gameStarted = false
        gameOver = false
        score = 0
        health = 3
        stopTimers()
    }
    
    func update() {
        if health <= 0 {
            endGame()
        }
    }
    
    func resetSpawnTimer() {
        shouldSpawnObject = false
    }
    
    private func startSpawnTimer() {
        let interval = currentLevel == 1 ? 2.0 : 1.0
        spawnTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            self.shouldSpawnObject = true
        }
    }
    
    private func stopTimers() {
        spawnTimer?.invalidate()
        gameTimer?.invalidate()
        spawnTimer = nil
        gameTimer = nil
    }
    
    func objectCaught(_ type: GameObjectType) {
        switch type {
        case .meteor:
            score += 10
        case .planet:
            score += 20
        case .satellite:
            score += 15
        case .blackHole:
            health -= 1
        }
    }
}

// MARK: - Game Components
struct MovementComponent: Component {
    var velocity: SIMD3<Float>
    var objectType: GameObjectType
}

struct RotationComponent: Component {
    // Empty component just for marking entities that should rotate
}

enum GameObjectType: String, CaseIterable {
    case meteor = "meteor"
    case planet = "planet"
    case satellite = "satellite"
    case blackHole = "blackHole"
    
    var speedMultiplier: Float {
        switch self {
        case .meteor: return 2.0
        case .planet: return 0.8
        case .satellite: return 1.5
        case .blackHole: return 0.3
        }
    }
    
    var glowColor: UIColor {
        switch self {
        case .meteor: return .orange
        case .planet: return .blue
        case .satellite: return .cyan
        case .blackHole: return .purple
        }
    }
    
    static func random(for level: Int) -> GameObjectType {
        let level1Objects: [GameObjectType] = [.meteor, .planet, .satellite]
        let level2Objects: [GameObjectType] = [.meteor, .planet, .satellite, .blackHole]
        
        let availableObjects = level == 1 ? level1Objects : level2Objects
        return availableObjects.randomElement()!
    }
}

// MARK: - UI Views
struct MenuView: View {
    @ObservedObject var gameState: GameState
    
    var body: some View {
        VStack(spacing: 30) {
            Text("🌌 PLANET CATCH")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Therapeutic Space Adventure")
                .font(.title2)
                .foregroundColor(.gray)
            
            VStack(spacing: 20) {
                Button("Level 1 - Gentle") {
                    gameState.startGame(level: 1)
                } .buttonStyle(GameButtonStyle(color: .blue))
                
                Button("Level 2 - Challenge") {
                    gameState.startGame(level: 2)
                } .buttonStyle(GameButtonStyle(color: .red))
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("How to Play:")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("👆 Tap meteors, planets, and satellites to catch them")
                Text("⚫ Avoid black holes - they damage your health")
                Text("🎯 Perfect for improving hand-eye coordination")
                Text("🧠 Great therapy for stroke and ADHD patients")
            }
            .font(.body)
            .foregroundColor(.gray)
            .padding()
            .background(Color.black.opacity(0.3))
            .cornerRadius(15)
        }
        .padding(40)
    }
}

struct GameOverView: View {
    @ObservedObject var gameState: GameState
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Game Over!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Final Score: \(gameState.score)")
                .font(.title)
                .foregroundColor(.yellow)
            
            Text("Level: \(gameState.currentLevel)")
                .font(.title2)
                .foregroundColor(.gray)
            
            HStack(spacing: 20) {
                Button("Play Again") {
                    gameState.startGame(level: gameState.currentLevel)
                }
                .buttonStyle(GameButtonStyle(color: .green))
                
                Button("Menu") {
                    gameState.resetGame()
                }
                .buttonStyle(GameButtonStyle(color: .blue))
            }
        }
        .padding(30)
        .background(Color.black.opacity(0.8))
        .cornerRadius(20)
    }
}

struct GameButtonStyle: ButtonStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(color.opacity(configuration.isPressed ? 0.6 : 0.8))
            .cornerRadius(25)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

////
////  PlayPlanetView.swift
////  Space Therapy Game for Vision Pro
////
////  Therapeutic game with meteor catching, satellite tracking, and space challenges
////  Designed for stroke recovery, ADHD therapy, and motor skill rehabilitation
////
//
//import SwiftUI
//import RealityKit
//import AVFoundation
//
//struct PlayPlanetView: View {
//    @Environment(\.dismiss) private var dismiss
//    @State private var selectedDifficulty: Difficulty = .easy
//    @State private var showDifficultySelection = true
//    @State private var gameMode: GameMode?
//    @State private var audioPlayer: AVAudioPlayer?
//    @State private var backgroundStars: [Star] = []
//    @State private var nebulaPulse: CGFloat = 0
//    @State private var planetRotations: [Double] = []
//    
//    enum Difficulty: String, CaseIterable {
//        case easy = "Beginner Explorer"
//        case hard = "Space Commander"
//        
//        var icon: String {
//            switch self {
//            case .easy: return "🌍"
//            case .hard: return "🚀"
//            }
//        }
//        
//        var description: String {
//            switch self {
//            case .easy: return "Slow meteors, helpful guides - Perfect for rehabilitation"
//            case .hard: return "Fast objects, black holes - Advanced motor control"
//            }
//        }
//        
//        var color: Color {
//            switch self {
//            case .easy: return Color(red: 0.3, green: 0.7, blue: 1.0)
//            case .hard: return Color(red: 1.0, green: 0.4, blue: 0.4)
//            }
//        }
//        
//        var meteorSpeed: ClosedRange<CGFloat> {
//            switch self {
//            case .easy: return 1...3
//            case .hard: return 3...7
//            }
//        }
//        
//        var spawnInterval: Double {
//            switch self {
//            case .easy: return 1.5
//            case .hard: return 0.7
//            }
//        }
//    }
//    
//    enum GameMode {
//        case meteorCatch
//        case satelliteTrack
//        case planetDefense
//    }
//    
//    var body: some View {
//        ZStack {
//            // Space Background
//            SpaceBackground(
//                stars: $backgroundStars,
//                nebulaPulse: $nebulaPulse,
//                planetRotations: $planetRotations
//            )
//            
//            if showDifficultySelection {
//                DifficultySelectionView(
//                    selectedDifficulty: $selectedDifficulty,
//                    showDifficultySelection: $showDifficultySelection,
//                    gameMode: $gameMode,
//                    onDismiss: { dismiss() }
//                )
//            } else if let mode = gameMode {
//                switch mode {
//                case .meteorCatch:
//                    MeteorCatchGameView(
//                        difficulty: selectedDifficulty,
//                        onBack: { backToDifficultySelection() }
//                    )
//                case .satelliteTrack:
//                    SatelliteTrackGameView(
//                        difficulty: selectedDifficulty,
//                        onBack: { backToDifficultySelection() }
//                    )
//                case .planetDefense:
//                    PlanetDefenseGameView(
//                        difficulty: selectedDifficulty,
//                        onBack: { backToDifficultySelection() }
//                    )
//                }
//            }
//        }
//        .onAppear {
//            setupAudio()
//            initializeBackground()
//        }
//        .onDisappear {
//            audioPlayer?.stop()
//        }
//    }
//    
//    func setupAudio() {
//        // Add space ambient sound if available
//        // For now, using system sounds
//    }
//    
//    func initializeBackground() {
//        // Generate stars
//        backgroundStars = (0..<100).map { _ in
//            Star(
//                position: CGPoint(
//                    x: CGFloat.random(in: 0...1200),
//                    y: CGFloat.random(in: 0...800)
//                ),
//                size: CGFloat.random(in: 1...3),
//                brightness: Double.random(in: 0.3...1.0)
//            )
//        }
//        
//        // Initialize planet rotations
//        planetRotations = (0..<5).map { _ in
//            Double.random(in: 0...360)
//        }
//        
//        // Start nebula animation
//        withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
//            nebulaPulse = 1
//        }
//    }
//    
//    func backToDifficultySelection() {
//        withAnimation(.spring()) {
//            showDifficultySelection = true
//            gameMode = nil
//        }
//    }
//}
//
//// MARK: - Space Background
//struct SpaceBackground: View {
//    @Binding var stars: [Star]
//    @Binding var nebulaPulse: CGFloat
//    @Binding var planetRotations: [Double]
//    @State private var shootingStarPosition: CGPoint = .zero
//    @State private var showShootingStar = false
//    
//    var body: some View {
//        ZStack {
//            // Deep space gradient
//            LinearGradient(
//                colors: [
//                    Color(red: 0.05, green: 0.05, blue: 0.15),
//                    Color(red: 0.1, green: 0.05, blue: 0.2),
//                    Color(red: 0.15, green: 0.1, blue: 0.25)
//                ],
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//            .ignoresSafeArea()
//            
//            // Nebula clouds
//            ForEach(0..<3, id: \.self) { index in
//                Circle()
//                    .fill(
//                        RadialGradient(
//                            colors: [
//                                Color.purple.opacity(0.3),
//                                Color.blue.opacity(0.2),
//                                Color.clear
//                            ],
//                            center: .center,
//                            startRadius: 50,
//                            endRadius: 200
//                        )
//                    )
//                    .frame(width: 300 + nebulaPulse * 50, height: 300 + nebulaPulse * 50)
//                    .blur(radius: 30)
//                    .position(
//                        x: CGFloat(200 + index * 300),
//                        y: CGFloat(150 + index * 100)
//                    )
//            }
//            
//            // Stars
//            ForEach(stars) { star in
//                Circle()
//                    .fill(Color.white.opacity(star.brightness))
//                    .frame(width: star.size, height: star.size)
//                    .position(star.position)
//                    .blur(radius: star.size > 2 ? 0.5 : 0)
//            }
//            
//            // Shooting star
//            if showShootingStar {
//                ShootingStarView()
//                    .position(shootingStarPosition)
//            }
//            
//            // Distant planets
//            ForEach(0..<3, id: \.self) { index in
//                Circle()
//                    .fill(
//                        LinearGradient(
//                            colors: [
//                                [Color.red, Color.orange][index % 2],
//                                [Color.orange, Color.blue][index % 2]
//                            ],
//                            startPoint: .topLeading,
//                            endPoint: .bottomTrailing
//                        )
//                    )
//                    .frame(width: 40, height: 40)
//                    .opacity(0.7)
//                    .position(
//                        x: CGFloat(900 + index * 50),
//                        y: CGFloat(100 + index * 60)
//                    )
//                    .rotationEffect(.degrees(planetRotations[safe: index] ?? 0))
//            }
//        }
//        .onAppear {
//            startShootingStars()
//        }
//    }
//    
//    func startShootingStars() {
//        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
//            shootingStarPosition = CGPoint(
//                x: CGFloat.random(in: 100...1000),
//                y: CGFloat.random(in: 50...200)
//            )
//            showShootingStar = true
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                showShootingStar = false
//            }
//        }
//    }
//}
//
//// MARK: - Difficulty Selection View
//struct DifficultySelectionView: View {
//    @Binding var selectedDifficulty: PlayPlanetView.Difficulty
//    @Binding var showDifficultySelection: Bool
//    @Binding var gameMode: PlayPlanetView.GameMode?
//    let onDismiss: () -> Void
//    @State private var hoveredMode: PlayPlanetView.GameMode?
//    @State private var glowAnimation: CGFloat = 0
//    
//    var body: some View {
//        VStack(spacing: 40) {
//            // Header
//            HStack {
//                Button(action: onDismiss) {
//                    HStack(spacing: 8) {
//                        Image(systemName: "chevron.left.circle.fill")
//                            .font(.title2)
//                        Text("Back")
//                            .font(.headline)
//                    }
//                    .foregroundColor(.white)
//                    .padding(.horizontal, 20)
//                    .padding(.vertical, 12)
//                    .background(Color.white.opacity(0.2))
//                    .cornerRadius(25)
//                }
//                
//                Spacer()
//            }
//            .padding(.horizontal, 40)
//            .padding(.top, 20)
//            
//            // Title
//            VStack(spacing: 15) {
//                HStack(spacing: 15) {
//                    Text("🌌")
//                        .font(.system(size: 60))
//                    Text("Space Therapy")
//                        .font(.system(size: 60, weight: .bold, design: .rounded))
//                        .foregroundStyle(
//                            LinearGradient(
//                                colors: [.cyan, .purple, .pink],
//                                startPoint: .leading,
//                                endPoint: .trailing
//                            )
//                        )
//                    Text("🌌")
//                        .font(.system(size: 60))
//                }
//                
//                Text("Therapeutic games for motor skills & cognitive training")
//                    .font(.title2)
//                    .foregroundColor(.white.opacity(0.9))
//            }
//            
//            // Difficulty Selection
//            HStack(spacing: 30) {
//                ForEach(PlayPlanetView.Difficulty.allCases, id: \.self) { difficulty in
//                    DifficultyCard(
//                        difficulty: difficulty,
//                        isSelected: selectedDifficulty == difficulty,
//                        onSelect: { selectedDifficulty = difficulty }
//                    )
//                }
//            }
//            .padding(.horizontal, 60)
//            
//            // Game Mode Selection
//            VStack(spacing: 20) {
//                Text("Choose Your Mission")
//                    .font(.title2)
//                    .foregroundColor(.white)
//                
//                HStack(spacing: 30) {
//                    // Meteor Catch Mode
//                    GameModeCard(
//                        title: "Meteor Catcher",
//                        icon: "☄️",
//                        description: "Catch falling meteors\nImproves hand-eye coordination",
//                        color: Color.orange,
//                        isHovered: hoveredMode == .meteorCatch,
//                        onTap: {
//                            gameMode = .meteorCatch
//                            showDifficultySelection = false
//                        },
//                        onHover: { hovering in
//                            hoveredMode = hovering ? .meteorCatch : nil
//                        }
//                    )
//                    
//                    // Satellite Track Mode
//                    GameModeCard(
//                        title: "Satellite Tracker",
//                        icon: "🛰️",
//                        description: "Follow orbital paths\nEnhances focus & tracking",
//                        color: Color.blue,
//                        isHovered: hoveredMode == .satelliteTrack,
//                        onTap: {
//                            gameMode = .satelliteTrack
//                            showDifficultySelection = false
//                        },
//                        onHover: { hovering in
//                            hoveredMode = hovering ? .satelliteTrack : nil
//                        }
//                    )
//                    
//                    // Planet Defense Mode
//                    GameModeCard(
//                        title: "Planet Defense",
//                        icon: "🪐",
//                        description: "Protect from asteroids\nTrains reaction time",
//                        color: Color.green,
//                        isHovered: hoveredMode == .planetDefense,
//                        onTap: {
//                            gameMode = .planetDefense
//                            showDifficultySelection = false
//                        },
//                        onHover: { hovering in
//                            hoveredMode = hovering ? .planetDefense : nil
//                        }
//                    )
//                }
//            }
//            .padding(.horizontal, 60)
//            
//            Spacer()
//        }
//        .onAppear {
//            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
//                glowAnimation = 1
//            }
//        }
//    }
//}
//
//// MARK: - Meteor Catch Game
//struct MeteorCatchGameView: View {
//    let difficulty: PlayPlanetView.Difficulty
//    let onBack: () -> Void
//    @State private var meteors: [Meteor] = []
//    @State private var score = 0
//    @State private var health = 100
//    @State private var handPosition = CGPoint(x: 500, y: 400)
//    @State private var caughtMeteors: Set<UUID> = []
//    @State private var blackHoles: [BlackHole] = []
//    @State private var powerUps: [PowerUp] = []
//    @State private var shieldActive = false
//    @State private var combo = 0
//    @State private var gameTime: Double = 0
//    @State private var isPaused = false
//    
//    var body: some View {
//        ZStack {
//            // Game field with space effects
//            Rectangle()
//                .fill(
//                    RadialGradient(
//                        colors: [
//                            Color.black.opacity(0.7),
//                            Color.purple.opacity(0.3)
//                        ],
//                        center: .center,
//                        startRadius: 100,
//                        endRadius: 600
//                    )
//                )
//                .ignoresSafeArea()
//            
//            // Black holes (for hard mode)
//            if difficulty == .hard {
//                ForEach(blackHoles) { blackHole in
//                    BlackHoleView(blackHole: blackHole)
//                }
//            }
//            
//            // Meteors
//            ForEach(meteors) { meteor in
//                MeteorView(
//                    speed: meteor,
//                    delay: caughtMeteors.contains(meteor.id)
//                )
//                .onTapGesture {
//                    catchMeteor(meteor)
//                }
//            }
//            
//            // Power-ups
//            ForEach(powerUps) { powerUp in
//                PowerUpView(powerUp: powerUp)
//                    .onTapGesture {
//                        collectPowerUp(powerUp)
//                    }
//            }
//            
//            // Hand/Spaceship indicator
//            ZStack {
//                if shieldActive {
//                    Circle()
//                        .stroke(Color.cyan, lineWidth: 3)
//                        .frame(width: 80, height: 80)
//                        .opacity(0.7)
//                }
//                
//                Image(systemName: "hand.raised.fill")
//                    .font(.system(size: 50))
//                    .foregroundColor(.white)
//                    .shadow(color: .cyan, radius: 10)
//            }
//            .position(handPosition)
//            
//            // UI Overlay
//            VStack {
//                // Top bar
//                HStack {
//                    Button(action: onBack) {
//                        HStack {
//                            Image(systemName: "chevron.left")
//                            Text("Back")
//                        }
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.black.opacity(0.5))
//                        .cornerRadius(20)
//                    }
//                    
//                    Spacer()
//                    
//                    // Timer
//                    Text(String(format: "⏱️ %.1f", gameTime))
//                        .font(.title2)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.black.opacity(0.5))
//                        .cornerRadius(20)
//                    
//                    // Pause button
//                    Button(action: { isPaused.toggle() }) {
//                        Image(systemName: isPaused ? "play.fill" : "pause.fill")
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.black.opacity(0.5))
//                            .cornerRadius(20)
//                    }
//                }
//                .padding()
//                
//                Spacer()
//                
//                // Bottom stats
//                HStack(spacing: 30) {
//                    // Health bar
//                    HStack {
//                        Text("❤️")
//                        ProgressView(value: Double(health), total: 100)
//                            .progressViewStyle(LinearProgressViewStyle(tint: healthColor))
//                            .frame(width: 150)
//                    }
//                    
//                    // Score
//                    Text("⭐ Score: \(score)")
//                        .font(.title2)
//                        .foregroundColor(.white)
//                    
//                    // Combo
//                    if combo > 1 {
//                        Text("🔥 x\(combo)")
//                            .font(.title2)
//                            .foregroundColor(.orange)
//                            .scaleEffect(1.2)
//                            .animation(.spring(), value: combo)
//                    }
//                    
//                    // Difficulty indicator
//                    Text(difficulty.icon + " " + difficulty.rawValue)
//                        .foregroundColor(difficulty.color)
//                }
//                .padding()
//                .background(Color.black.opacity(0.3))
//            }
//            
//            // Game Over overlay
//            if health <= 0 {
//                GameOverView(
//                    score: score,
//                    time: gameTime,
//                    onRestart: { restartGame() },
//                    onBack: onBack
//                )
//            }
//        }
//        .onAppear {
//            startGame()
//        }
//        .gesture(
//            DragGesture(minimumDistance: 0)
//                .onChanged { value in
//                    if !isPaused && health > 0 {
//                        handPosition = value.location
//                        checkMeteorProximity()
//                    }
//                }
//        )
//    }
//    
//    var healthColor: Color {
//        if health > 60 { return .green }
//        if health > 30 { return .yellow }
//        return .red
//    }
//    
//    func startGame() {
//        // Initialize black holes for hard mode
//        if difficulty == .hard {
//            blackHoles = [
//                BlackHole(position: CGPoint(x: 300, y: 300), strength: 50),
//                BlackHole(position: CGPoint(x: 700, y: 500), strength: 50)
//            ]
//        }
//        
//        // Start meteor spawning
//        Timer.scheduledTimer(withTimeInterval: difficulty.spawnInterval, repeats: true) { timer in
//            if !isPaused && health > 0 {
//                spawnMeteor()
//                gameTime += difficulty.spawnInterval
//                
//                // Spawn power-ups occasionally
//                if Int.random(in: 0...10) > 8 {
//                    spawnPowerUp()
//                }
//            }
//            
//            if health <= 0 {
//                timer.invalidate()
//            }
//        }
//        
//        // Update game physics
//        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
//            if !isPaused && health > 0 {
//                updateMeteorPositions()
//            }
//            
//            if health <= 0 {
//                timer.invalidate()
//            }
//        }
//    }
//    
//    func spawnMeteor() {
//        let meteor = Meteor(
//            position: CGPoint(
//                x: CGFloat.random(in: 100...900),
//                y: -50
//            ),
//            velocity: CGVector(
//                dx: CGFloat.random(in: -2...2),
//                dy: CGFloat.random(in: difficulty.meteorSpeed)
//            ),
//            size: CGFloat.random(in: 30...60),
//            type: Meteor.MeteorType.allCases.randomElement()!
//        )
//        meteors.append(meteor)
//    }
//    
//    func spawnPowerUp() {
//        let powerUp = PowerUp(
//            position: CGPoint(
//                x: CGFloat.random(in: 100...900),
//                y: -50
//            ),
//            type: PowerUp.PowerUpType.allCases.randomElement()!
//        )
//        powerUps.append(powerUp)
//        
//        // Animate power-up falling
//        withAnimation(.linear(duration: 5)) {
//            if let index = powerUps.firstIndex(where: { $0.id == powerUp.id }) {
//                powerUps[index].position.y = 800
//            }
//        }
//    }
//    
//    func updateMeteorPositions() {
//        for index in meteors.indices {
//            // Apply gravity
//            meteors[index].velocity.dy += 0.1
//            
//            // Apply black hole attraction (hard mode)
//            if difficulty == .hard {
//                for blackHole in blackHoles {
//                    let dx = blackHole.position.x - meteors[index].position.x
//                    let dy = blackHole.position.y - meteors[index].position.y
//                    let distance = sqrt(dx * dx + dy * dy)
//                    
//                    if distance < 200 {
//                        let force = blackHole.strength / (distance * distance)
//                        meteors[index].velocity.dx += dx * force * 0.001
//                        meteors[index].velocity.dy += dy * force * 0.001
//                    }
//                }
//            }
//            
//            // Update position
//            meteors[index].position.x += meteors[index].velocity.dx
//            meteors[index].position.y += meteors[index].velocity.dy
//            
//            // Check if meteor is off screen
//            if meteors[index].position.y > 850 && !caughtMeteors.contains(meteors[index].id) {
//                // Meteor missed - reduce health
//                if !shieldActive {
//                    health -= 10
//                    combo = 0
//                }
//            }
//        }
//        
//        // Remove off-screen meteors
//        meteors.removeAll { $0.position.y > 850 || caughtMeteors.contains($0.id) }
//        powerUps.removeAll { $0.position.y > 850 }
//    }
//    
//    func checkMeteorProximity() {
//        for meteor in meteors {
//            let distance = sqrt(
//                pow(meteor.position.x - handPosition.x, 2) +
//                pow(meteor.position.y - handPosition.y, 2)
//            )
//            
//            if distance < 60 && !caughtMeteors.contains(meteor.id) {
//                catchMeteor(meteor)
//            }
//        }
//    }
//    
//    func catchMeteor(_ meteor: Meteor) {
//        if !caughtMeteors.contains(meteor.id) {
//            caughtMeteors.insert(meteor.id)
//            
//            // Score based on meteor type
//            let baseScore = meteor.type.points
//            score += baseScore * (combo + 1)
//            combo += 1
//            
//            // Visual feedback
//            withAnimation(.easeOut(duration: 0.3)) {
//                // Meteor caught animation handled in view
//            }
//            
//            // Remove meteor after animation
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                meteors.removeAll { $0.id == meteor.id }
//            }
//        }
//    }
//    
//    func collectPowerUp(_ powerUp: PowerUp) {
//        switch powerUp.type {
//        case .shield:
//            shieldActive = true
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                shieldActive = false
//            }
//        case .health:
//            health = min(100, health + 20)
//        case .slowTime:
//            // Implement time slow effect
//            break
//        case .multiScore:
//            combo = min(combo + 3, 10)
//        }
//        
//        powerUps.removeAll { $0.id == powerUp.id }
//    }
//    
//    func restartGame() {
//        score = 0
//        health = 100
//        combo = 0
//        gameTime = 0
//        meteors = []
//        powerUps = []
//        caughtMeteors = []
//        isPaused = false
//        startGame()
//    }
//}
//
//// MARK: - Satellite Track Game
//struct SatelliteTrackGameView: View {
//    let difficulty: PlayPlanetView.Difficulty
//    let onBack: () -> Void
//    @State private var satellites: [Satellite] = []
//    @State private var currentPath: Path = Path()
//    @State private var targetPath: Path = Path()
//    @State private var accuracy: CGFloat = 0
//    @State private var level = 1
//    @State private var handPosition = CGPoint(x: 500, y: 400)
//    
//    var body: some View {
//        ZStack {
//            // Orbital background
//            ZStack {
//                ForEach(0..<3, id: \.self) { index in
//                    Circle()
//                        .stroke(Color.white.opacity(0.1), lineWidth: 2)
//                        .frame(width: CGFloat(200 + index * 150), height: CGFloat(200 + index * 150))
//                        .position(x: 500, y: 400)
//                }
//            }
//            
//            // Target orbital path
//            Path { path in
//                path.addEllipse(in: CGRect(x: 300, y: 250, width: 400, height: 300))
//            }
//            .stroke(Color.green.opacity(0.3), style: StrokeStyle(lineWidth: 40, dash: [10, 5]))
//            
//            // Satellites
//            ForEach(satellites) { satellite in
//                SatelliteView(satellite: satellite)
//            }
//            
//            // Tracking indicator
//            Image(systemName: "scope")
//                .font(.system(size: 60))
//                .foregroundColor(.cyan)
//                .position(handPosition)
//                .opacity(0.8)
//            
//            // UI
//            VStack {
//                HStack {
//                    Button(action: onBack) {
//                        HStack {
//                            Image(systemName: "chevron.left")
//                            Text("Back")
//                        }
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.black.opacity(0.5))
//                        .cornerRadius(20)
//                    }
//                    
//                    Spacer()
//                    
//                    Text("Level \(level)")
//                        .font(.title2)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.black.opacity(0.5))
//                        .cornerRadius(20)
//                }
//                .padding()
//                
//                Spacer()
//                
//                HStack {
//                    Text("Track the satellite's orbit")
//                        .foregroundColor(.white)
//                    
//                    Spacer()
//                    
//                    Text("Accuracy: \(Int(accuracy))%")
//                        .foregroundColor(.white)
//                }
//                .padding()
//                .background(Color.black.opacity(0.3))
//            }
//        }
//        .onAppear {
//            startTracking()
//        }
//        .gesture(
//            DragGesture(minimumDistance: 0)
//                .onChanged { value in
//                    handPosition = value.location
//                    checkSatelliteTracking()
//                }
//        )
//    }
//    
//    func startTracking() {
//        // Create satellites with orbital motion
//        satellites = [
//            Satellite(
//                position: CGPoint(x: 500, y: 250),
//                orbit: CGRect(x: 300, y: 250, width: 400, height: 300),
//                speed: difficulty == .easy ? 0.5 : 1.5
//            )
//        ]
//        
//        // Animate satellite orbits
//        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
//            for index in satellites.indices {
//                satellites[index].angle += satellites[index].speed * 0.05
//                let x = satellites[index].orbit.midX + cos(satellites[index].angle) * satellites[index].orbit.width / 2
//                let y = satellites[index].orbit.midY + sin(satellites[index].angle) * satellites[index].orbit.height / 2
//                satellites[index].position = CGPoint(x: x, y: y)
//            }
//        }
//    }
//    
//    func checkSatelliteTracking() {
//        for satellite in satellites {
//            let distance = sqrt(
//                pow(satellite.position.x - handPosition.x, 2) +
//                pow(satellite.position.y - handPosition.y, 2)
//            )
//            
//            if distance < 50 {
//                accuracy = min(100, accuracy + 1)
//            } else {
//                accuracy = max(0, accuracy - 0.5)
//            }
//        }
//    }
//}
//
//// MARK: - Planet Defense Game
//struct PlanetDefenseGameView: View {
//    let difficulty: PlayPlanetView.Difficulty
//    let onBack: () -> Void
//    @State private var asteroids: [Asteroid] = []
//    @State private var planetHealth = 100
//    @State private var shields: [Shield] = []
//    @State private var score = 0
//    @State private var handPosition = CGPoint(x: 500, y: 400)
//    
//    var body: some View {
//        ZStack {
//            // Planet at center
//            ZStack {
//                Circle()
//                    .fill(
//                        RadialGradient(
//                            colors: [Color.blue, Color.green, Color.blue.opacity(0.5)],
//                            center: .center,
//                            startRadius: 50,
//                            endRadius: 150
//                        )
//                    )
//                    .frame(width: 200, height: 200)
//                    .position(x: 500, y: 400)
//                
//                // Planet health indicator
//                Circle()
//                    .stroke(Color.red.opacity(0.7), lineWidth: 5)
//                    .frame(width: 220, height: 220)
//                    .position(x: 500, y: 400)
//                    .opacity(planetHealth < 50 ? 1 : 0)
//                    .animation(.easeInOut(duration: 0.5).repeatForever(), value: planetHealth)
//            }
//            
//            // Asteroids
//            ForEach(asteroids) { asteroid in
//                AsteroidView(asteroid: asteroid)
//                    .onTapGesture {
//                        destroyAsteroid(asteroid)
//                    }
//            }
//            
//            // Defense shields
//            ForEach(shields) { shield in
//                ShieldView(shield: shield)
//            }
//            
//            // Defense laser pointer
//            Image(systemName: "target")
//                .font(.system(size: 50))
//                .foregroundColor(.red.opacity(0.8))
//                .position(handPosition)
//            
//            // UI
//            VStack {
//                HStack {
//                    Button(action: onBack) {
//                        HStack {
//                            Image(systemName: "chevron.left")
//                            Text("Back")
//                        }
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.black.opacity(0.5))
//                        .cornerRadius(20)
//                    }
//                    
//                    Spacer()
//                    
//                    Text("🪐 Planet Health: \(planetHealth)%")
//                        .font(.title2)
//                        .foregroundColor(planetHealth > 50 ? .green : .red)
//                        .padding()
//                        .background(Color.black.opacity(0.5))
//                        .cornerRadius(20)
//                }
//                .padding()
//                
//                Spacer()
//                
//                HStack {
//                    Text("Tap asteroids to destroy them!")
//                        .foregroundColor(.white)
//                    
//                    Spacer()
//                    
//                    Text("Score: \(score)")
//                        .font(.title2)
//                        .foregroundColor(.white)
//                }
//                .padding()
//                .background(Color.black.opacity(0.3))
//            }
//            
//            if planetHealth <= 0 {
//                GameOverView(
//                    score: score,
//                    time: 0,
//                    onRestart: { restartDefense() },
//                    onBack: onBack
//                )
//            }
//        }
//        .onAppear {
//            startDefense()
//        }
//        .gesture(
//            DragGesture(minimumDistance: 0)
//                .onChanged { value in
//                    handPosition = value.location
//                }
//        )
//    }
//    
//    func startDefense() {
//        // Spawn asteroids
//        Timer.scheduledTimer(withTimeInterval: difficulty.spawnInterval, repeats: true) { timer in
//            if planetHealth > 0 {
//                spawnAsteroid()
//            } else {
//                timer.invalidate()
//            }
//        }
//        
//        // Update asteroid positions
//        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
//            if planetHealth > 0 {
//                updateAsteroids()
//            } else {
//                timer.invalidate()
//            }
//        }
//    }
//    
//    func spawnAsteroid() {
//        let angle = Double.random(in: 0...(2 * .pi))
//        let distance: CGFloat = 500
//        let asteroid = Asteroid(
//            position: CGPoint(
//                x: 500 + cos(angle) * distance,
//                y: 400 + sin(angle) * distance
//            ),
//            velocity: CGVector(
//                dx: -cos(angle) * CGFloat.random(in: difficulty.meteorSpeed),
//                dy: -sin(angle) * CGFloat.random(in: difficulty.meteorSpeed)
//            ),
//            size: CGFloat.random(in: 30...70)
//        )
//        asteroids.append(asteroid)
//    }
//    
//    func updateAsteroids() {
//        for index in asteroids.indices {
//            asteroids[index].position.x += asteroids[index].velocity.dx
//            asteroids[index].position.y += asteroids[index].velocity.dy
//            
//            // Check collision with planet
//            let distance = sqrt(
//                pow(asteroids[index].position.x - 500, 2) +
//                pow(asteroids[index].position.y - 400, 2)
//            )
//            
//            if distance < 120 {
//                planetHealth -= 10
//                asteroids.remove(at: index)
//                break
//            }
//        }
//        
//        // Remove off-screen asteroids
//        asteroids.removeAll { asteroid in
//            asteroid.position.x < -100 || asteroid.position.x > 1100 ||
//            asteroid.position.y < -100 || asteroid.position.y > 900
//        }
//    }
//    
//    func destroyAsteroid(_ asteroid: Asteroid) {
//        if let index = asteroids.firstIndex(where: { $0.id == asteroid.id }) {
//            score += Int(100 / asteroid.size) * 10
//            asteroids.remove(at: index)
//            
//            // Explosion effect
//            // Add visual feedback here
//        }
//    }
//    
//    func restartDefense() {
//        planetHealth = 100
//        score = 0
//        asteroids = []
//        shields = []
//        startDefense()
//    }
//}
//
//// MARK: - Supporting Views and Models
//
//struct Star: Identifiable {
//    let id = UUID()
//    let position: CGPoint
//    let size: CGFloat
//    let brightness: Double
//}
//
//struct ShootingStarView: View {
//    @State private var offset: CGFloat = 0
//    
//    var body: some View {
//        ZStack {
//            ForEach(0..<3, id: \.self) { index in
//                Circle()
//                    .fill(Color.white)
//                    .frame(width: 5 - CGFloat(index), height: 5 - CGFloat(index))
//                    .offset(x: -CGFloat(index * 20) - offset, y: CGFloat(index * 10) + offset/2)
//                    .opacity(1.0 - Double(index) * 0.3)
//            }
//        }
//        .onAppear {
//            withAnimation(.linear(duration: 1)) {
//                offset = 200
//            }
//        }
//    }
//}
//
//struct DifficultyCard: View {
//    let difficulty: PlayPlanetView.Difficulty
//    let isSelected: Bool
//    let onSelect: () -> Void
//    
//    var body: some View {
//        VStack(spacing: 15) {
//            Text(difficulty.icon)
//                .font(.system(size: 50))
//            
//            Text(difficulty.rawValue)
//                .font(.headline)
//                .foregroundColor(.white)
//            
//            Text(difficulty.description)
//                .font(.caption)
//                .foregroundColor(.white.opacity(0.8))
//                .multilineTextAlignment(.center)
//                .frame(width: 200)
//        }
//        .padding(25)
//        .background(
//            RoundedRectangle(cornerRadius: 20)
//                .fill(difficulty.color.opacity(isSelected ? 0.8 : 0.4))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 20)
//                        .stroke(isSelected ? Color.white : Color.clear, lineWidth: 3)
//                )
//        )
//        .scaleEffect(isSelected ? 1.05 : 1.0)
//        .onTapGesture(perform: onSelect)
//    }
//}
//
//struct GameModeCard: View {
//    let title: String
//    let icon: String
//    let description: String
//    let color: Color
//    let isHovered: Bool
//    let onTap: () -> Void
//    let onHover: (Bool) -> Void
//    
//    var body: some View {
//        VStack(spacing: 15) {
//            Text(icon)
//                .font(.system(size: 60))
//            
//            Text(title)
//                .font(.title3)
//                .fontWeight(.bold)
//                .foregroundColor(.white)
//            
//            Text(description)
//                .font(.caption)
//                .foregroundColor(.white.opacity(0.9))
//                .multilineTextAlignment(.center)
//                .frame(width: 180, height: 40)
//        }
//        .frame(width: 220, height: 200)
//        .background(
//            RoundedRectangle(cornerRadius: 25)
//                .fill(
//                    LinearGradient(
//                        colors: [color, color.opacity(0.6)],
//                        startPoint: .top,
//                        endPoint: .bottom
//                    )
//                )
//                .shadow(color: color.opacity(0.5), radius: isHovered ? 15 : 5)
//        )
//        .overlay(
//            RoundedRectangle(cornerRadius: 25)
//                .stroke(Color.white.opacity(0.3), lineWidth: 2)
//        )
//        .scaleEffect(isHovered ? 1.1 : 1.0)
//        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isHovered)
//        .onHover(perform: onHover)
//        .onTapGesture(perform: onTap)
//    }
//}
//
//struct Meteor: Identifiable {
//    let id = UUID()
//    var position: CGPoint
//    var velocity: CGVector
//    let size: CGFloat
//    let type: MeteorType
//    
//    enum MeteorType: CaseIterable {
//        case normal, ice, fire, golden
//        
//        var color: LinearGradient {
//            switch self {
//            case .normal:
//                return LinearGradient(colors: [.gray, .brown], startPoint: .top, endPoint: .bottom)
//            case .ice:
//                return LinearGradient(colors: [.cyan, .blue], startPoint: .top, endPoint: .bottom)
//            case .fire:
//                return LinearGradient(colors: [.orange, .red], startPoint: .top, endPoint: .bottom)
//            case .golden:
//                return LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom)
//            }
//        }
//        
//        var points: Int {
//            switch self {
//            case .normal: return 10
//            case .ice: return 15
//            case .fire: return 20
//            case .golden: return 50
//            }
//        }
//    }
//}
//
////struct MeteorView: View {
////    let meteor: Meteor
////    let isCaught: Bool
////    @State private var rotation: Double = 0
////    @State private var trailOpacity: Double = 1
////    
////    var body: some View {
////        ZStack {
////            // Meteor trail
////            ForEach(0..<5, id: \.self) { index in
////                Circle()
////                    .fill(meteor.type.color)
////                    .frame(width: meteor.size - CGFloat(index * 5), height: meteor.size - CGFloat(index * 5))
////                    .offset(y: -CGFloat(index * 10))
////                    .opacity(trailOpacity * (1.0 - Double(index) * 0.2))
////            }
////            
////            // Main meteor
////            Circle()
////                .fill(meteor.type.color)
////                .frame(width: meteor.size, height: meteor.size)
////                .overlay(
////                    Circle()
////                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
////                )
////                .shadow(color: meteor.type.color.colors[0].opacity(0.5), radius: 10)
////        }
////        .position(meteor.position)
////        .rotationEffect(.degrees(rotation))
////        .scaleEffect(isCaught ? 1.5 : 1.0)
////        .opacity(isCaught ? 0 : 1)
////        .onAppear {
////            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
////                rotation = 360
////            }
////            withAnimation(.easeIn(duration: 1).repeatForever(autoreverses: true)) {
////                trailOpacity = 0.3
////            }
////        }
////    }
////}
//
//struct BlackHole: Identifiable {
//    let id = UUID()
//    let position: CGPoint
//    let strength: CGFloat
//}
//
//struct BlackHoleView: View {
//    let blackHole: BlackHole
//    @State private var rotation: Double = 0
//    @State private var scale: CGFloat = 1
//    
//    var body: some View {
//        ZStack {
//            // Event horizon
//            Circle()
//                .fill(Color.black)
//                .frame(width: 100, height: 100)
//            
//            // Accretion disk
//            ForEach(0..<3, id: \.self) { index in
//                Circle()
//                    .stroke(
//                        LinearGradient(
//                            colors: [.purple, .blue, .clear],
//                            startPoint: .leading,
//                            endPoint: .trailing
//                        ),
//                        lineWidth: 3
//                    )
//                    .frame(width: 120 + CGFloat(index * 30), height: 120 + CGFloat(index * 30))
//                    .rotationEffect(.degrees(rotation + Double(index * 30)))
//                    .opacity(0.7 - Double(index) * 0.2)
//            }
//            
//            // Gravitational lensing effect
//            Circle()
//                .fill(
//                    RadialGradient(
//                        colors: [.clear, .purple.opacity(0.3), .clear],
//                        center: .center,
//                        startRadius: 50,
//                        endRadius: 100
//                    )
//                )
//                .frame(width: 200, height: 200)
//                .scaleEffect(scale)
//        }
//        .position(blackHole.position)
//        .onAppear {
//            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
//                rotation = 360
//            }
//            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
//                scale = 1.2
//            }
//        }
//    }
//}
//
//struct PowerUp: Identifiable {
//    let id = UUID()
//    var position: CGPoint
//    let type: PowerUpType
//    
//    enum PowerUpType: CaseIterable {
//        case shield, health, slowTime, multiScore
//        
//        var icon: String {
//            switch self {
//            case .shield: return "shield.fill"
//            case .health: return "heart.fill"
//            case .slowTime: return "clock.fill"
//            case .multiScore: return "star.fill"
//            }
//        }
//        
//        var color: Color {
//            switch self {
//            case .shield: return .cyan
//            case .health: return .red
//            case .slowTime: return .purple
//            case .multiScore: return .yellow
//            }
//        }
//    }
//}
//
//struct PowerUpView: View {
//    let powerUp: PowerUp
//    @State private var pulse: CGFloat = 1
//    @State private var rotation: Double = 0
//    
//    var body: some View {
//        ZStack {
//            // Glow effect
//            Circle()
//                .fill(powerUp.type.color.opacity(0.3))
//                .frame(width: 60, height: 60)
//                .scaleEffect(pulse)
//            
//            // Power-up icon
//            Image(systemName: powerUp.type.icon)
//                .font(.system(size: 30))
//                .foregroundColor(powerUp.type.color)
//                .rotationEffect(.degrees(rotation))
//        }
//        .position(powerUp.position)
//        .onAppear {
//            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
//                pulse = 1.3
//            }
//            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
//                rotation = 360
//            }
//        }
//    }
//}
//
//struct Satellite: Identifiable {
//    let id = UUID()
//    var position: CGPoint
//    let orbit: CGRect
//    let speed: CGFloat
//    var angle: CGFloat = 0
//}
//
//struct SatelliteView: View {
//    let satellite: Satellite
//    @State private var rotation: Double = 0
//    
//    var body: some View {
//        ZStack {
//            // Solar panels
//            HStack(spacing: 5) {
//                Rectangle()
//                    .fill(Color.blue.opacity(0.8))
//                    .frame(width: 30, height: 15)
//                
//                Rectangle()
//                    .fill(Color.gray)
//                    .frame(width: 20, height: 20)
//                
//                Rectangle()
//                    .fill(Color.blue.opacity(0.8))
//                    .frame(width: 30, height: 15)
//            }
//            
//            // Signal indicator
//            Circle()
//                .fill(Color.green)
//                .frame(width: 5, height: 5)
//                .offset(y: -10)
//                .opacity(rotation.truncatingRemainder(dividingBy: 180) < 90 ? 1 : 0.3)
//        }
//        .position(satellite.position)
//        .rotationEffect(.degrees(rotation))
//        .onAppear {
//            withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
//                rotation = 360
//            }
//        }
//    }
//}
//
//struct Asteroid: Identifiable {
//    let id = UUID()
//    var position: CGPoint
//    var velocity: CGVector
//    let size: CGFloat
//}
//
//struct AsteroidView: View {
//    let asteroid: Asteroid
//    @State private var rotation: Double = 0
//    
//    var body: some View {
//        ZStack {
//            // Asteroid body
//            Circle()
//                .fill(
//                    LinearGradient(
//                        colors: [.gray, .brown],
//                        startPoint: .topLeading,
//                        endPoint: .bottomTrailing
//                    )
//                )
//                .frame(width: asteroid.size, height: asteroid.size)
//                .overlay(
//                    // Craters
//                    ZStack {
//                        ForEach(0..<3, id: \.self) { _ in
//                            Circle()
//                                .fill(Color.black.opacity(0.3))
//                                .frame(
//                                    width: CGFloat.random(in: 5...15),
//                                    height: CGFloat.random(in: 5...15)
//                                )
//                                .offset(
//                                    x: CGFloat.random(in: -asteroid.size/4...asteroid.size/4),
//                                    y: CGFloat.random(in: -asteroid.size/4...asteroid.size/4)
//                                )
//                        }
//                    }
//                )
//        }
//        .position(asteroid.position)
//        .rotationEffect(.degrees(rotation))
//        .onAppear {
//            withAnimation(.linear(duration: Double.random(in: 3...6)).repeatForever(autoreverses: false)) {
//                rotation = 360
//            }
//        }
//    }
//}
//
//struct Shield: Identifiable {
//    let id = UUID()
//    let position: CGPoint
//    var strength: Int = 100
//}
//
//struct ShieldView: View {
//    let shield: Shield
//    
//    var body: some View {
//        Circle()
//            .stroke(
//                LinearGradient(
//                    colors: [.cyan, .blue],
//                    startPoint: .top,
//                    endPoint: .bottom
//                ),
//                lineWidth: 3
//            )
//            .frame(width: 250, height: 250)
//            .opacity(Double(shield.strength) / 100.0)
//            .position(shield.position)
//    }
//}
//
//struct GameOverView: View {
//    let score: Int
//    let time: Double
//    let onRestart: () -> Void
//    let onBack: () -> Void
//    
//    var body: some View {
//        VStack(spacing: 30) {
//            Text("🌌 Mission Complete 🌌")
//                .font(.system(size: 50, weight: .bold))
//                .foregroundColor(.white)
//            
//            VStack(spacing: 15) {
//                Text("Final Score: \(score)")
//                    .font(.title)
//                    .foregroundColor(.yellow)
//                
//                if time > 0 {
//                    Text(String(format: "Time: %.1f seconds", time))
//                        .font(.title2)
//                        .foregroundColor(.white)
//                }
//                
//                // Star rating
//                HStack(spacing: 10) {
//                    ForEach(0..<5, id: \.self) { index in
//                        Image(systemName: index < scoreToStars(score) ? "star.fill" : "star")
//                            .font(.title)
//                            .foregroundColor(.yellow)
//                    }
//                }
//            }
//            
//            HStack(spacing: 30) {
//                Button(action: onRestart) {
//                    Text("Try Again")
//                        .font(.title2)
//                        .foregroundColor(.white)
//                        .padding(.horizontal, 40)
//                        .padding(.vertical, 15)
//                        .background(Color.green)
//                        .cornerRadius(25)
//                }
//                
//                Button(action: onBack) {
//                    Text("Back to Menu")
//                        .font(.title2)
//                        .foregroundColor(.white)
//                        .padding(.horizontal, 40)
//                        .padding(.vertical, 15)
//                        .background(Color.blue)
//                        .cornerRadius(25)
//                }
//            }
//        }
//        .padding(50)
//        .background(
//            RoundedRectangle(cornerRadius: 30)
//                .fill(Color.black.opacity(0.9))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 30)
//                        .stroke(
//                            LinearGradient(
//                                colors: [.cyan, .purple],
//                                startPoint: .topLeading,
//                                endPoint: .bottomTrailing
//                            ),
//                            lineWidth: 3
//                        )
//                )
//        )
//    }
//    
//    func scoreToStars(_ score: Int) -> Int {
//        switch score {
//        case 0..<100: return 1
//        case 100..<300: return 2
//        case 300..<500: return 3
//        case 500..<800: return 4
//        default: return 5
//        }
//    }
//}
//
//// Safe array subscript extension
////extension Array {
////    subscript(safe index: Int) -> Element? {
////        guard index >= 0, index < count else { return nil }
////        return self[index]
////    }
////}
//
//#Preview {
//    PlayPlanetView()
//}

import SwiftUI
import RealityKit
import AVFoundation
import AudioToolbox


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
        guard let url = Bundle.main.url(forResource: "space_ambient", withExtension: "mp3") else {
            print("Background music file not found - continuing without music")
            return
        }
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

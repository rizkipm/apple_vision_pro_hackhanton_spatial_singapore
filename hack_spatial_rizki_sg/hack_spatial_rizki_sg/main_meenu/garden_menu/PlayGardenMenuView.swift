//
//  PlayGardenMenuView.swift
//  hack_spatial_rizki_sg
//
//  Created by NUS on 7/8/25.
//

import SwiftUI
import RealityKit
import RealityKitContent
import AVFoundation

struct PlayAroundZenGarden: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedMode: ZenMode?
    @State private var showModeSelection = true
    @State private var audioPlayer: AVAudioPlayer?
    @State private var backgroundAnimationPhase: CGFloat = 0
    @State private var koiPositions: [CGPoint] = []
    @State private var bambooSwayAngles: [Double] = []
    @State private var rippleEffects: [RippleData] = []
    @State private var showPlayAroundGarden = false
    
    enum ZenMode: String, CaseIterable {
        case petalCatch = "Petal Catching"
        case rakeFlow = "Rake Flow"
        case lanternPath = "Lantern Path"
        case breathingPond = "Breathing Pond"
        case leafFocus = "Leaf Focus"
        
        var icon: String {
            switch self {
            case .petalCatch: return "🌸"
            case .rakeFlow: return "🪷"
            case .lanternPath: return "🏮"
            case .breathingPond: return "🌬️"
            case .leafFocus: return "🍃"
            }
        }
        
        var difficulty: String {
            switch self {
            case .petalCatch: return "Easy"
            case .rakeFlow: return "Medium"
            case .lanternPath: return "Harder"
            case .breathingPond: return "Mindfulness"
            case .leafFocus: return "High Focus"
            }
        }
        
        var color: Color {
            switch self {
            case .petalCatch: return Color(red: 1.0, green: 0.7, blue: 0.8)
            case .rakeFlow: return Color(red: 0.9, green: 0.95, blue: 0.9)
            case .lanternPath: return Color(red: 1.0, green: 0.8, blue: 0.4)
            case .breathingPond: return Color(red: 0.6, green: 0.8, blue: 0.95)
            case .leafFocus: return Color(red: 0.7, green: 0.9, blue: 0.6)
            }
        }
        
        var description: String {
            switch self {
            case .petalCatch: return "Catch falling cherry blossoms with gentle hand movements"
            case .rakeFlow: return "Create patterns in zen sand with flowing gestures"
            case .lanternPath: return "Follow the illuminated lanterns in sequence"
            case .breathingPond: return "Synchronize your breath with the koi pond"
            case .leafFocus: return "Focus on catching specific leaves among many"
            }
        }
    }
    
    var body: some View {
        ZStack {
            // Zen Garden Background
            ZenGardenBackground(
                animationPhase: $backgroundAnimationPhase,
                koiPositions: $koiPositions,
                bambooSwayAngles: $bambooSwayAngles
            )
            
            if showModeSelection {
                // Mode Selection View
                ModeSelectionView(
                    selectedMode: $selectedMode,
                    showModeSelection: $showModeSelection,
                    onDismiss: { dismiss() }
                )
            } else if let mode = selectedMode {
                // Game Mode View
                switch mode {
                case .petalCatch:
                    PetalCatchingView(
                        onBack: { backToModeSelection() }
                    )
                case .rakeFlow:
                    RakeFlowView(
                        onBack: { backToModeSelection() }
                    )
                case .lanternPath:
                    LanternPathView(
                        onBack: { backToModeSelection() }
                    )
                case .breathingPond:
                    BreathingPondView(
                        onBack: { backToModeSelection() }
                    )
                case .leafFocus:
                    LeafFocusView(
                        onBack: { backToModeSelection() }
                    )
                }
            }
        }
        .onAppear {
            setupAudio()
            startBackgroundAnimations()
        }
        .onDisappear {
            audioPlayer?.stop()
        }
    }
    
    func setupAudio() {
        // Setup zen garden ambient audio
        if let soundURL = Bundle.main.url(forResource: "garden", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.numberOfLoops = -1 // Loop indefinitely
                audioPlayer?.volume = 0.3
                audioPlayer?.play()
            } catch {
                print("Could not load audio file")
            }
        }
    }
    
    func startBackgroundAnimations() {
        // Koi positions
        koiPositions = (0..<3).map { _ in
            CGPoint(x: CGFloat.random(in: 100...800),
                   y: CGFloat.random(in: 200...600))
        }
        
        // Bamboo sway
        bambooSwayAngles = (0..<5).map { _ in
            Double.random(in: -5...5)
        }
        
        // Start animations
        withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)) {
            backgroundAnimationPhase = 1
        }
        
        // Animate koi movement
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 3)) {
                koiPositions = koiPositions.map { _ in
                    CGPoint(x: CGFloat.random(in: 100...800),
                           y: CGFloat.random(in: 200...600))
                }
            }
        }
        
        // Animate bamboo
        withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
            bambooSwayAngles = bambooSwayAngles.map { _ in
                Double.random(in: -8...8)
            }
        }
    }
    
    func backToModeSelection() {
        withAnimation(.spring()) {
            showModeSelection = true
            selectedMode = nil
        }
    }
}

// MARK: - Zen Garden Background

struct ZenGardenBackground: View {
    @Binding var animationPhase: CGFloat
    @Binding var koiPositions: [CGPoint]
    @Binding var bambooSwayAngles: [Double]
    
    var body: some View {
        ZStack {
            // Gradient Sky
            LinearGradient(
                colors: [
                    Color(red: 0.9, green: 0.95, blue: 1.0),
                    Color(red: 0.8, green: 0.9, blue: 0.95),
                    Color(red: 0.7, green: 0.85, blue: 0.9)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Sun/Moon
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color(red: 1.0, green: 0.95, blue: 0.8),
                            Color(red: 1.0, green: 0.9, blue: 0.7).opacity(0.5),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 20,
                        endRadius: 100
                    )
                )
                .frame(width: 150, height: 150)
                .position(x: 900, y: 150)
                .opacity(0.8)
            
            // Bamboo Forest
            HStack(spacing: 80) {
                ForEach(0..<5, id: \.self) { index in
                    BambooStalkPlayGardenView(
                        height: CGFloat.random(in: 400...600),
                        swayAngle: bambooSwayAngles[safe: index] ?? 0
                    )
                }
            }
            .position(x: 500, y: 400)
            
            // Koi Pond
            ForEach(Array(koiPositions.enumerated()), id: \.offset) { index, position in
                KoiFish(color: [.orange, .white, .yellow][index % 3])
                    .position(position)
                    .scaleEffect(0.8)
            }
            
            // Water ripples
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .stroke(Color.blue.opacity(0.2), lineWidth: 2)
                    .frame(width: 100 * (1 + animationPhase), height: 100 * (1 + animationPhase))
                    .opacity(1 - animationPhase)
                    .position(
                        x: CGFloat(200 + index * 200),
                        y: CGFloat(400 + index * 50)
                    )
            }
        }
    }
}

// MARK: - Mode Selection View

struct ModeSelectionView: View {
    @Binding var selectedMode: PlayAroundZenGarden.ZenMode?
    @Binding var showModeSelection: Bool
    let onDismiss: () -> Void
    @State private var hoveredMode: PlayAroundZenGarden.ZenMode?
    @State private var stoneScales: [CGFloat] = Array(repeating: 1.0, count: 5)
    
    var body: some View {
        VStack(spacing: 40) {
            // Header
            HStack {
                Button(action: onDismiss) {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.title2)
                        Text("Back")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(25)
                }
                
                Spacer()
            }
            .padding(.horizontal, 40)
            .padding(.top, 20)
            
            // Title
            VStack(spacing: 15) {
                Text("🌅 Zen Garden")
                    .font(.system(size: 60, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white, Color(red: 0.4, green: 0.7, blue: 0.4)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                Text("🧘 Choose a mindful path today")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.9))
            }
            
            // Mode Selection Stones
            HStack(spacing: 50) {
                ForEach(Array(PlayAroundZenGarden.ZenMode.allCases.enumerated()), id: \.element) { index, mode in
                    VStack(spacing: 20) {
                        // Stone Button
                        ZStack {
                            // Stone base
                            RoundedRectangle(cornerRadius: 30)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            mode.color.opacity(0.9),
                                            mode.color.opacity(0.6)
                                        ],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .frame(width: 180, height: 180)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.white.opacity(0.5), lineWidth: 3)
                                )
                                .shadow(
                                    color: mode.color.opacity(0.5),
                                    radius: hoveredMode == mode ? 20 : 10,
                                    y: 10
                                )
                            
                            VStack(spacing: 10) {
                                Text(mode.icon)
                                    .font(.system(size: 60))
                                
                                Text(mode.rawValue)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text(mode.difficulty)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.8))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(Color.black.opacity(0.3))
                                    .cornerRadius(10)
                            }
                        }
                        .scaleEffect(stoneScales[index])
                        .onHover { hovering in
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                hoveredMode = hovering ? mode : nil
                                stoneScales[index] = hovering ? 1.1 : 1.0
                            }
                        }
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedMode = mode
                                showModeSelection = false
                            }
                        }
                        
                        // Description (appears on hover)
                        if hoveredMode == mode {
                            Text(mode.description)
                                .font(.caption)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: 180)
                                .padding(10)
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(15)
                                .transition(.scale.combined(with: .opacity))
                        }
                    }
                }
            }
            .padding(.horizontal, 60)
            
            Spacer()
        }
    }
}

// MARK: - Petal Catching Mode

struct PetalCatchingView: View {
    let onBack: () -> Void
    @State private var petals: [FallingPetal] = []
    @State private var score = 0
    @State private var handPosition = CGPoint(x: 500, y: 400)
    @State private var caughtPetals: Set<UUID> = []
    
    var body: some View {
        ZStack {
            // Cherry Blossom Tree
            Image(systemName: "tree.fill")
                .font(.system(size: 300))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(red: 0.9, green: 0.6, blue: 0.7),
                            Color(red: 0.8, green: 0.4, blue: 0.5)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .position(x: 500, y: 200)
                .opacity(0.3)
            
            // Falling Petals
            ForEach(petals) { petal in
                Image(systemName: "leaf.fill")
                    .font(.system(size: 30))
                    .foregroundColor(Color(red: 1.0, green: 0.7, blue: 0.8))
                    .rotationEffect(.degrees(petal.rotation))
                    .position(petal.position)
                    .opacity(caughtPetals.contains(petal.id) ? 0 : 1)
                    .scaleEffect(caughtPetals.contains(petal.id) ? 2 : 1)
                    .animation(.easeOut(duration: 0.3), value: caughtPetals.contains(petal.id))
            }
            
            // Hand Gesture Indicator
            Image(systemName: "hand.raised.fill")
                .font(.system(size: 50))
                .foregroundColor(.white.opacity(0.8))
                .position(handPosition)
                .shadow(radius: 10)
            
            // UI Overlay
            VStack {
                HStack {
                    Button(action: onBack) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(20)
                    }
                    
                    Spacer()
                    
                    // Timer (optional)
                    Text("01:30")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(20)
                }
                .padding()
                
                Spacer()
                
                // Score
                HStack {
                    Text("🎵 Zen Music ~")
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack(spacing: 10) {
                        Text("⭐ Score:")
                            .foregroundColor(.white)
                        
                        HStack(spacing: 5) {
                            ForEach(0..<5, id: \.self) { index in
                                Circle()
                                    .fill(index < score / 10 ? Color.yellow : Color.gray.opacity(0.5))
                                    .frame(width: 20, height: 20)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.black.opacity(0.3))
            }
        }
        .onAppear {
            startPetalFalling()
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    handPosition = value.location
                    checkPetalCatch(at: value.location)
                }
        )
    }
    
    func startPetalFalling() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            let newPetal = FallingPetal(
                position: CGPoint(
                    x: CGFloat.random(in: 100...900),
                    y: -50
                ),
                rotation: Double.random(in: 0...360),
                speed: CGFloat.random(in: 2...5)
            )
            petals.append(newPetal)
            
            // Animate petal falling
            withAnimation(.linear(duration: Double(800 / newPetal.speed))) {
                if let index = petals.firstIndex(where: { $0.id == newPetal.id }) {
                    petals[index].position.y = 900
                }
            }
            
            // Remove petals that have fallen off screen
            petals.removeAll { $0.position.y > 850 }
        }
    }
    
    func checkPetalCatch(at location: CGPoint) {
        for petal in petals {
            let distance = sqrt(pow(petal.position.x - location.x, 2) + pow(petal.position.y - location.y, 2))
            if distance < 50 && !caughtPetals.contains(petal.id) {
                caughtPetals.insert(petal.id)
                score += 10
                
                // Remove caught petal after animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    petals.removeAll { $0.id == petal.id }
                }
            }
        }
    }
}

// MARK: - Rake Flow Mode

struct RakeFlowView: View {
    let onBack: () -> Void
    @State private var sandPaths: [SandPath] = []
    @State private var currentPath: SandPath?
    @State private var targetPath = Path()
    @State private var accuracy: CGFloat = 0
    @State private var rakePosition = CGPoint(x: 500, y: 400)
    
    var body: some View {
        ZStack {
            // Sand texture background
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.95, green: 0.93, blue: 0.88),
                            Color(red: 0.92, green: 0.90, blue: 0.85)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .ignoresSafeArea()
            
            // Sand pattern texture
            Canvas { context, size in
                // Draw target path
                context.stroke(
                    targetPath,
                    with: .color(.gray.opacity(0.3)),
                    style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round, dash: [10, 5])
                )
                
                // Draw user's sand paths
                for path in sandPaths {
                    context.stroke(
                        path.path,
                        with: .color(Color(red: 0.9, green: 0.88, blue: 0.82)),
                        style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round)
                    )
                }
                
                // Draw current path
                if let current = currentPath {
                    context.stroke(
                        current.path,
                        with: .color(Color(red: 0.88, green: 0.85, blue: 0.8)),
                        style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round)
                    )
                }
            }
            
            // Rake tool
            Image(systemName: "minus.rectangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.brown)
                .rotationEffect(.degrees(-45))
                .position(rakePosition)
                .shadow(radius: 5)
            
            // UI Overlay
            VStack {
                HStack {
                    Button(action: onBack) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(20)
                    }
                    
                    Spacer()
                    
                    Text("Follow the pattern")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(20)
                }
                .padding()
                
                Spacer()
                
                HStack {
                    Text("⏱️ Timer: 01:45")
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("🎵 Soft music")
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("Accuracy: \(Int(accuracy))%")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.black.opacity(0.3))
            }
        }
        .onAppear {
            createTargetPath()
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    rakePosition = value.location
                    
                    if currentPath == nil {
                        currentPath = SandPath()
                    }
                    currentPath?.path.addLine(to: value.location)
                }
                .onEnded { _ in
                    if let path = currentPath {
                        sandPaths.append(path)
                        currentPath = nil
                        calculateAccuracy()
                    }
                }
        )
    }
    
    func createTargetPath() {
        targetPath = Path { path in
            path.move(to: CGPoint(x: 200, y: 300))
            path.addCurve(
                to: CGPoint(x: 800, y: 300),
                control1: CGPoint(x: 400, y: 200),
                control2: CGPoint(x: 600, y: 400)
            )
            path.addCurve(
                to: CGPoint(x: 500, y: 500),
                control1: CGPoint(x: 700, y: 350),
                control2: CGPoint(x: 600, y: 450)
            )
        }
    }
    
    func calculateAccuracy() {
        // Simple accuracy calculation
        accuracy = CGFloat.random(in: 70...95)
    }
}

// MARK: - Lantern Path Mode

struct LanternPathView: View {
    let onBack: () -> Void
    @State private var lanterns: [Lantern] = []
    @State private var sequenceOrder: [Int] = []
    @State private var playerSequence: [Int] = []
    @State private var isShowingSequence = true
    @State private var currentLanternIndex = 0
    
    var body: some View {
        ZStack {
            // Evening garden background
            LinearGradient(
                colors: [
                    Color(red: 0.3, green: 0.2, blue: 0.4),
                    Color(red: 0.5, green: 0.3, blue: 0.5),
                    Color(red: 0.7, green: 0.4, blue: 0.4)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Moon
            Circle()
                .fill(Color(red: 1.0, green: 0.95, blue: 0.8))
                .frame(width: 100, height: 100)
                .position(x: 800, y: 150)
                .blur(radius: 3)
            
            // Garden path
            Path { path in
                path.move(to: CGPoint(x: 100, y: 600))
                path.addCurve(
                    to: CGPoint(x: 900, y: 400),
                    control1: CGPoint(x: 300, y: 500),
                    control2: CGPoint(x: 700, y: 450)
                )
            }
            .stroke(Color.brown.opacity(0.5), lineWidth: 60)
            
            // Lanterns
            ForEach(Array(lanterns.enumerated()), id: \.element.id) { index, lantern in
                VStack(spacing: 5) {
                    // Lantern
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(
                                lantern.isLit ?
                                LinearGradient(
                                    colors: [.yellow, .orange],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ) :
                                LinearGradient(
                                    colors: [Color.gray.opacity(0.5), Color.gray.opacity(0.3)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(width: 60, height: 80)
                        
                        if lantern.isLit {
                            Circle()
                                .fill(Color.yellow.opacity(0.3))
                                .frame(width: 120, height: 120)
                                .blur(radius: 20)
                        }
                        
                        Text("🏮")
                            .font(.system(size: 40))
                            .opacity(lantern.isLit ? 1 : 0.5)
                    }
                    
                    // Step number (during sequence)
                    if isShowingSequence && sequenceOrder.contains(index) {
                        if let step = sequenceOrder.firstIndex(of: index) {
                            Text("Step \(step + 1)")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(10)
                        }
                    }
                }
                .position(lantern.position)
                .scaleEffect(lantern.isLit ? 1.2 : 1.0)
                .animation(.spring(response: 0.5, dampingFraction: 0.7), value: lantern.isLit)
                .onTapGesture {
                    if !isShowingSequence {
                        tapLantern(at: index)
                    }
                }
            }
            
            // Instructions
            VStack {
                HStack {
                    Button(action: onBack) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(20)
                    }
                    
                    Spacer()
                }
                .padding()
                
                Spacer()
                
                Text(isShowingSequence ? "Watch the sequence..." : "Follow with your hand or gaze")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(20)
                
                Text("🌕 Evening mist effect")
                    .foregroundColor(.white.opacity(0.8))
                    .padding()
            }
        }
        .onAppear {
            setupLanterns()
            startSequence()
        }
    }
    
    func setupLanterns() {
        lanterns = [
            Lantern(position: CGPoint(x: 200, y: 300)),
            Lantern(position: CGPoint(x: 400, y: 250)),
            Lantern(position: CGPoint(x: 600, y: 350)),
            Lantern(position: CGPoint(x: 800, y: 300)),
            Lantern(position: CGPoint(x: 500, y: 450))
        ]
    }
    
    func startSequence() {
        sequenceOrder = [0, 2, 4, 1, 3]
        
        for (index, lanternIndex) in sequenceOrder.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 1.0) {
                withAnimation {
                    lanterns[lanternIndex].isLit = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    withAnimation {
                        lanterns[lanternIndex].isLit = false
                    }
                    
                }
            }
        }
    }
    
    func tapLantern(at index: Int) {
        playerSequence.append(index)
        withAnimation {
            lanterns[index].isLit = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                lanterns[index].isLit = false
            }
            
            // Check if sequence is correct
            if playerSequence.count == sequenceOrder.count {
                if playerSequence == sequenceOrder {
                    // Success!
                    celebrateSuccess()
                } else {
                    // Try again
                    resetSequence()
                }
            }
        }
    }
    
    func celebrateSuccess() {
        for (index, _) in lanterns.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
                withAnimation {
                    lanterns[index].isLit = true
                }
            }
        }
    }
    
    func resetSequence() {
        playerSequence = []
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            startSequence()
        }
    }
}

// MARK: - Breathing Pond Mode

struct BreathingPondView: View {
    let onBack: () -> Void
    @State private var breathPhase: BreathPhase = .inhale
    @State private var bubbleScale: CGFloat = 1.0
    @State private var koiFishPositions: [CGPoint] = []
    @State private var rippleScale: CGFloat = 1.0
    @State private var breathingText = "Inhale..."
    
    enum BreathPhase {
        case inhale, hold, exhale, rest
    }
    
    var body: some View {
        ZStack {
            // Pond background
            RadialGradient(
                colors: [
                    Color(red: 0.3, green: 0.6, blue: 0.8),
                    Color(red: 0.2, green: 0.5, blue: 0.7),
                    Color(red: 0.1, green: 0.4, blue: 0.6)
                ],
                center: .center,
                startRadius: 100,
                endRadius: 500
            )
            .ignoresSafeArea()
            
            // Koi fish
            ForEach(0..<5, id: \.self) { index in
                KoiFish(color: [.orange, .white, .yellow, .red, .black][index])
                    .position(
                        x: 500 + cos(CGFloat(index) * .pi / 2.5 + bubbleScale) * 200,
                        y: 400 + sin(CGFloat(index) * .pi / 2.5 + bubbleScale) * 150
                    )
                    .scaleEffect(0.7)
                    .opacity(0.8)
            }
            
            // Central breathing bubble
            ZStack {
                // Ripples
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
                        .frame(width: 200 * rippleScale + CGFloat(index * 50),
                               height: 200 * rippleScale + CGFloat(index * 50))
                        .scaleEffect(bubbleScale)
                        .opacity(1.0 - (bubbleScale - 1.0))
                }
                
                // Main bubble
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.white.opacity(0.8),
                                Color.blue.opacity(0.4),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 20,
                            endRadius: 100
                        )
                    )
                    .frame(width: 150, height: 150)
                    .scaleEffect(bubbleScale)
                
                // Inner glow
                Circle()
                    .fill(Color.white.opacity(0.5))
                    .frame(width: 100, height: 100)
                    .scaleEffect(bubbleScale * 0.8)
                    .blur(radius: 10)
            }
            .position(x: 500, y: 400)
            
            // UI Overlay
            VStack {
                HStack {
                    Button(action: onBack) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(20)
                    }
                    
                    Spacer()
                }
                .padding()
                
                Spacer()
                
                // Breathing guidance
                VStack(spacing: 20) {
                    Text("🎧 \(breathingText)")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(20)
                    
                    // Breathing progress
                    ProgressView(value: bubbleScale - 1.0, total: 1.0)
                        .progressViewStyle(LinearProgressViewStyle(tint: .white))
                        .frame(width: 300)
                        .scaleEffect(x: 1, y: 2)
                    
                    Text("🌫️ Water sounds & calming music")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding()
            }
        }
        .onAppear {
            startBreathingCycle()
        }
    }
    
    func startBreathingCycle() {
        // Inhale phase
        breathingText = "Inhale slowly..."
        withAnimation(.easeInOut(duration: 4)) {
            bubbleScale = 2.0
            rippleScale = 1.5
        }
        
        // Hold phase
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            breathingText = "Hold..."
            
            // Exhale phase
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                breathingText = "Exhale gently..."
                withAnimation(.easeInOut(duration: 4)) {
                    bubbleScale = 1.0
                    rippleScale = 1.0
                }
                
                // Rest and repeat
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    breathingText = "Rest..."
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        startBreathingCycle()
                    }
                }
            }
        }
    }
}

// MARK: - Leaf Focus Mode

struct LeafFocusView: View {
    let onBack: () -> Void
    @State private var leaves: [FallingLeaf] = []
    @State private var targetLeafType: LeafType = .red
    @State private var score = 0
    @State private var correctCatches = 0
    @State private var wrongCatches = 0
    @State private var instruction = ""
    
    enum LeafType: CaseIterable {
        case red, yellow, green, brown
        
        var color: Color {
            switch self {
            case .red: return Color(red: 0.9, green: 0.3, blue: 0.3)
            case .yellow: return Color(red: 0.9, green: 0.8, blue: 0.3)
            case .green: return Color(red: 0.4, green: 0.7, blue: 0.4)
            case .brown: return Color(red: 0.6, green: 0.4, blue: 0.2)
            }
        }
        
        var shape: String {
            switch self {
            case .red: return "leaf.fill"
            case .yellow: return "leaf"
            case .green: return "leaf.circle.fill"
            case .brown: return "leaf.arrow.circlepath"
            }
        }
    }
    
    var body: some View {
        ZStack {
            // Autumn forest background
            LinearGradient(
                colors: [
                    Color(red: 0.9, green: 0.8, blue: 0.6),
                    Color(red: 0.8, green: 0.6, blue: 0.4),
                    Color(red: 0.7, green: 0.5, blue: 0.3)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Falling leaves
            ForEach(leaves) { leaf in
                Image(systemName: leaf.type.shape)
                    .font(.system(size: 40))
                    .foregroundColor(leaf.type.color)
                    .rotationEffect(.degrees(leaf.rotation))
                    .position(leaf.position)
                    .opacity(leaf.isCaught ? 0 : 1)
                    .scaleEffect(leaf.isCaught ? 2 : 1)
                    .animation(.easeOut(duration: 0.3), value: leaf.isCaught)
                    .onTapGesture {
                        catchLeaf(leaf)
                    }
            }
            
            // UI Overlay
            VStack {
                HStack {
                    Button(action: onBack) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(20)
                    }
                    
                    Spacer()
                }
                .padding()
                
                // Target instruction
                VStack(spacing: 10) {
                    Text("🎯 Catch only:")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    HStack {
                        Image(systemName: targetLeafType.shape)
                            .font(.system(size: 50))
                            .foregroundColor(targetLeafType.color)
                        
                        Text(instruction)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(20)
                
                Spacer()
                
                // Score
                HStack(spacing: 30) {
                    Text("✋ Use hand gestures")
                        .foregroundColor(.white)
                    
                    HStack(spacing: 20) {
                        Text("⭐ Score:")
                            .foregroundColor(.white)
                        
                        HStack(spacing: 5) {
                            ForEach(0..<correctCatches, id: \.self) { _ in
                                Text("✓")
                                    .foregroundColor(.green)
                                    .font(.title3)
                            }
                            ForEach(0..<wrongCatches, id: \.self) { _ in
                                Text("✗")
                                    .foregroundColor(.red)
                                    .font(.title3)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.black.opacity(0.3))
            }
        }
        .onAppear {
            setupNewTarget()
            startLeafFalling()
        }
    }
    
    func setupNewTarget() {
        targetLeafType = LeafType.allCases.randomElement() ?? .red
        instruction = "Red leaves with circle shape"
    }
    
    func startLeafFalling() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            // Create mix of different leaves
            let leafType = LeafType.allCases.randomElement() ?? .green
            let newLeaf = FallingLeaf(
                type: leafType,
                position: CGPoint(
                    x: CGFloat.random(in: 100...900),
                    y: -50
                ),
                rotation: Double.random(in: 0...360),
                speed: CGFloat.random(in: 1...4)
            )
            leaves.append(newLeaf)
            
            // Animate falling
            withAnimation(.linear(duration: Double(800 / newLeaf.speed))) {
                if let index = leaves.firstIndex(where: { $0.id == newLeaf.id }) {
                    leaves[index].position.y = 900
                }
            }
            
            // Remove off-screen leaves
            leaves.removeAll { $0.position.y > 850 || $0.isCaught }
        }
    }
    
    func catchLeaf(_ leaf: FallingLeaf) {
        if let index = leaves.firstIndex(where: { $0.id == leaf.id }) {
            leaves[index].isCaught = true
            
            if leaf.type == targetLeafType {
                correctCatches += 1
                score += 10
            } else {
                wrongCatches += 1
            }
            
            // Remove caught leaf
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                leaves.removeAll { $0.id == leaf.id }
            }
            
            // New target after 5 correct catches
            if correctCatches >= 5 {
                setupNewTarget()
                correctCatches = 0
                wrongCatches = 0
            }
        }
    }
}

// MARK: - Supporting Views and Models

struct BambooStalkPlayGardenView: View {
    let height: CGFloat
    let swayAngle: Double
    
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [
                        Color(red: 0.4, green: 0.6, blue: 0.3),
                        Color(red: 0.3, green: 0.5, blue: 0.2)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: 30, height: height)
            .rotationEffect(.degrees(swayAngle), anchor: .bottom)
            .overlay(
                // Bamboo segments
                VStack(spacing: height / 8) {
                    ForEach(0..<8, id: \.self) { _ in
                        Rectangle()
                            .fill(Color.black.opacity(0.2))
                            .frame(height: 2)
                    }
                }
            )
    }
}

struct KoiFish: View {
    let color: Color
    
    var body: some View {
        ZStack {
            Ellipse()
                .fill(
                    LinearGradient(
                        colors: [color, color.opacity(0.7)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 60, height: 25)
            
            // Fins
            Ellipse()
                .fill(color.opacity(0.5))
                .frame(width: 20, height: 15)
                .offset(x: -25, y: 0)
            
            // Eye
            Circle()
                .fill(Color.black)
                .frame(width: 4, height: 4)
                .offset(x: 15, y: -3)
        }
    }
}

struct FallingPetal: Identifiable {
    let id = UUID()
    var position: CGPoint
    let rotation: Double
    let speed: CGFloat
}

struct SandPath: Identifiable {
    let id = UUID()
    var path = Path()
}

struct Lantern: Identifiable {
    let id = UUID()
    let position: CGPoint
    var isLit = false
}

struct FallingLeaf: Identifiable {
    let id = UUID()
    let type: LeafFocusView.LeafType
    var position: CGPoint
    let rotation: Double
    let speed: CGFloat
    var isCaught = false
}

struct RippleData: Identifiable {
    let id = UUID()
    let center: CGPoint
    var scale: CGFloat = 1.0
    var opacity: Double = 1.0
}

// Safe array subscript
extension Array {
    func subscript_new(safe index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}

#Preview {
    PlayAroundZenGarden()

}

//
//  MemoriesMainMenu.swift
//  hack_spatial_rizki_sg
//
//  Created by NUS on 7/8/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct MemoryBubblesView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var bubbles: [BubbleData] = []
    @State private var showInstructions = true
    @State private var currentSequence: [Int] = []
    @State private var playerSequence: [Int] = []
    @State private var isShowingSequence = false
    @State private var isPlayerTurn = false
    @State private var level = 1
    @State private var score = 0
    @State private var showSuccess = false
    @State private var showError = false
    @State private var selectedTherapyMode = false
    @State private var floatingOffset: [CGFloat] = []
    @State private var spatialSoundEnabled = true
    @Binding var showMemoriesBuble: Bool
    
    
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 200))
    ]
    
    // Memory images for bubbles
    let memoryImages = [
        "photo", "camera.fill", "sun.max.fill", "moon.stars.fill",
        "heart.fill", "star.fill", "leaf.fill", "snowflake",
        "drop.fill", "flame.fill", "wind", "tornado"
    ]
    
    // Spatial sound positions
    let soundPositions = ["left", "center", "right", "top", "bottom"]
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                colors: [
                    Color(red: 0.1, green: 0.2, blue: 0.4),
                    Color(red: 0.3, green: 0.1, blue: 0.5),
                    Color(red: 0.2, green: 0.3, blue: 0.6)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .overlay(
                // Animated particles
                GeometryReader { geometry in
                    ForEach(0..<20, id: \.self) { index in
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.3),
                                        Color.blue.opacity(0.1)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(width: CGFloat.random(in: 10...30))
                            .position(
                                x: CGFloat.random(in: 0...geometry.size.width),
                                y: CGFloat.random(in: 0...geometry.size.height)
                            )
                            .opacity(0.6)
                            .animation(
                                Animation.easeInOut(duration: Double.random(in: 3...8))
                                    .repeatForever(autoreverses: true),
                                value: floatingOffset[safe: index] ?? 0
                            )
                            .offset(y: floatingOffset[safe: index] ?? 0)
                    }
                }
            )
            
            VStack(spacing: 30) {
                // Header
                HStack {
                    Button(action: {
                        showMemoriesBuble = false
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.left.circle.fill")
                                .font(.title2)
                            Text("Back")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(25)
                    }
                    
                    Spacer()
                    
                    // Score and Level
                    HStack(spacing: 20) {
                        VStack(alignment: .trailing) {
                            Text("Level")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                            Text("\(level)")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                        }
                        
                        VStack(alignment: .trailing) {
                            Text("Score")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                            Text("\(score)")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 15)
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(20)
                }
                .padding(.horizontal, 40)
                .padding(.top, 20)
                
                // Title
                VStack(spacing: 10) {
                    Text("Memory Bubbles")
                        .font(.system(size: 56, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.white, .blue.opacity(0.8)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    Text(selectedTherapyMode ? "Therapy Mode Active" : "Spatial Memory Training")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                // Game Area
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.white.opacity(0.3), lineWidth: 2)
                        )
                    
                    if showInstructions {
                        // Instructions View
                        VStack(spacing: 25) {
                            Image(systemName: "brain.head.profile")
                                .font(.system(size: 80))
                                .foregroundColor(.white.opacity(0.8))
                                .symbolEffect(.pulse)
                            
                            Text("How to Play")
                                .font(.title.bold())
                                .foregroundColor(.white)
                            
                            VStack(alignment: .leading, spacing: 15) {
                                InstructionRow(icon: "1.circle.fill", text: "Watch the bubbles light up in sequence")
                                InstructionRow(icon: "2.circle.fill", text: "Remember the pattern")
                                InstructionRow(icon: "3.circle.fill", text: "Tap bubbles in the same order")
                                InstructionRow(icon: "speaker.wave.2.fill", text: "Use spatial sounds as memory guides")
                            }
                            
                            HStack(spacing: 20) {
                                Button(action: { startGame() }) {
                                    Label("Start Game", systemImage: "play.fill")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 30)
                                        .padding(.vertical, 15)
                                        .background(
                                            LinearGradient(
                                                colors: [.blue, .purple],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .cornerRadius(25)
                                }
                                
                                Button(action: {
                                    selectedTherapyMode.toggle()
                                }) {
                                    Label(
                                        selectedTherapyMode ? "Game Mode" : "Therapy Mode",
                                        systemImage: selectedTherapyMode ? "gamecontroller.fill" : "heart.fill"
                                    )
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 15)
                                    .background(
                                        LinearGradient(
                                            colors: selectedTherapyMode ? [.orange, .red] : [.green, .mint],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(25)
                                }
                            }
                        }
                        .padding(40)
                    } else {
                        // Game Grid
                        LazyVGrid(columns: columns, spacing: 25) {
                            ForEach(Array(bubbles.enumerated()), id: \.element.id) { index, bubble in
                                BubbleView(
                                    bubble: bubble,
                                    index: index,
                                    isHighlighted: bubble.isHighlighted,
                                    isPlayerTurn: isPlayerTurn,
                                    therapyMode: selectedTherapyMode,
                                    onTap: { bubbleTapped(index) }
                                )
                            }
                        }
                        .padding(40)
                    }
                }
                .frame(maxWidth: 900, maxHeight: 600)
                
                // Control Buttons
                if !showInstructions {
                    HStack(spacing: 30) {
                        Button(action: { resetGame() }) {
                            Label("New Game", systemImage: "arrow.clockwise")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 25)
                                .padding(.vertical, 15)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(25)
                        }
                        
                        Button(action: { spatialSoundEnabled.toggle() }) {
                            Label(
                                spatialSoundEnabled ? "Sound On" : "Sound Off",
                                systemImage: spatialSoundEnabled ? "speaker.wave.3.fill" : "speaker.slash.fill"
                            )
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 15)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(25)
                        }
                        
                        if isShowingSequence {
                            Text("Watch carefully...")
                                .font(.headline)
                                .foregroundColor(.yellow)
                                .padding(.horizontal, 25)
                                .padding(.vertical, 15)
                                .background(Color.yellow.opacity(0.2))
                                .cornerRadius(25)
                        } else if isPlayerTurn {
                            Text("Your turn!")
                                .font(.headline)
                                .foregroundColor(.green)
                                .padding(.horizontal, 25)
                                .padding(.vertical, 15)
                                .background(Color.green.opacity(0.2))
                                .cornerRadius(25)
                        }
                    }
                }
                
                Spacer()
            }
            
            // Success/Error Overlay
            if showSuccess {
                VStack {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.green)
                        .symbolEffect(.bounce)
                    Text("Correct!")
                        .font(.title.bold())
                        .foregroundColor(.white)
                }
                .padding(50)
                .background(Color.black.opacity(0.8))
                .cornerRadius(30)
                .transition(.scale.combined(with: .opacity))
            }
            
            if showError {
                VStack {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.red)
                        .symbolEffect(.bounce)
                    Text("Try Again!")
                        .font(.title.bold())
                        .foregroundColor(.white)
                }
                .padding(50)
                .background(Color.black.opacity(0.8))
                .cornerRadius(30)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .onAppear {
            setupFloatingAnimation()
        }
    }
    
    // MARK: - Game Logic
    
    func startGame() {
        showInstructions = false
        initializeBubbles()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            nextRound()
        }
    }
    
    func initializeBubbles() {
        bubbles = (0..<12).map { index in
            BubbleData(
                id: index,
                image: memoryImages[index % memoryImages.count],
                color: randomBubbleColor(),
                soundPosition: soundPositions[index % soundPositions.count]
            )
        }
    }
    
    func nextRound() {
        isPlayerTurn = false
        playerSequence = []
        
        // Add new element to sequence
        let newElement = Int.random(in: 0..<bubbles.count)
        currentSequence.append(newElement)
        
        // Show sequence
        showSequence()
    }
    
    func showSequence() {
        isShowingSequence = true
        
        for (index, bubbleIndex) in currentSequence.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 1.2) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    bubbles[bubbleIndex].isHighlighted = true
                }
                
                // Play spatial sound if enabled
                if spatialSoundEnabled {
                    playBubbleSound(position: bubbles[bubbleIndex].soundPosition)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        bubbles[bubbleIndex].isHighlighted = false
                    }
                    
                    // Start player turn after showing last bubble
                    if index == currentSequence.count - 1 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isShowingSequence = false
                            isPlayerTurn = true
                        }
                    }
                }
            }
        }
    }
    
    func bubbleTapped(_ index: Int) {
        guard isPlayerTurn else { return }
        
        // Highlight tapped bubble
        withAnimation(.easeInOut(duration: 0.2)) {
            bubbles[index].isHighlighted = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.2)) {
                bubbles[index].isHighlighted = false
            }
        }
        
        playerSequence.append(index)
        
        // Check if correct
        let currentIndex = playerSequence.count - 1
        if playerSequence[currentIndex] != currentSequence[currentIndex] {
            // Wrong sequence
            wrongSequence()
        } else if playerSequence.count == currentSequence.count {
            // Completed sequence correctly
            correctSequence()
        }
    }
    
    func correctSequence() {
        isPlayerTurn = false
        score += level * 10
        
        withAnimation {
            showSuccess = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                showSuccess = false
            }
            
            if !selectedTherapyMode {
                level += 1
            }
            
            nextRound()
        }
    }
    
    func wrongSequence() {
        isPlayerTurn = false
        
        withAnimation {
            showError = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                showError = false
            }
            
            if selectedTherapyMode {
                // In therapy mode, replay the same sequence
                playerSequence = []
                showSequence()
            } else {
                // In game mode, reset to level 1
                resetGame()
            }
        }
    }
    
    func resetGame() {
        level = 1
        score = 0
        currentSequence = []
        playerSequence = []
        showInstructions = true
        bubbles = []
    }
    
    func playBubbleSound(position: String) {
        // Spatial audio implementation would go here
        // For now, this is a placeholder
    }
    
    func randomBubbleColor() -> Color {
        let colors: [Color] = [
            .blue.opacity(0.7),
            .purple.opacity(0.7),
            .pink.opacity(0.7),
            .orange.opacity(0.7),
            .green.opacity(0.7),
            .cyan.opacity(0.7)
        ]
        return colors.randomElement() ?? .blue
    }
    
    func setupFloatingAnimation() {
        floatingOffset = (0..<20).map { _ in
            CGFloat.random(in: -30...30)
        }
        
        // Animate floating
        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
            floatingOffset = floatingOffset.map { _ in
                CGFloat.random(in: -30...30)
            }
        }
    }
}

// MARK: - Supporting Views

struct BubbleView: View {
    let bubble: BubbleData
    let index: Int
    let isHighlighted: Bool
    let isPlayerTurn: Bool
    let therapyMode: Bool
    let onTap: () -> Void
    
    @State private var isHovering = false
    @State private var bubbleScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            // Bubble background
            Circle()
                .fill(
                    LinearGradient(
                        colors: isHighlighted ?
                            [Color.yellow, Color.orange] :
                            [bubble.color, bubble.color.opacity(0.5)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    Circle()
                        .stroke(
                            Color.white.opacity(isHighlighted ? 0.8 : 0.3),
                            lineWidth: isHighlighted ? 4 : 2
                        )
                )
                .shadow(
                    color: isHighlighted ? Color.yellow.opacity(0.6) : Color.black.opacity(0.2),
                    radius: isHighlighted ? 20 : 10,
                    x: 0,
                    y: 5
                )
            
            // Glow effect
            if isHighlighted {
                Circle()
                    .fill(Color.white.opacity(0.3))
                    .blur(radius: 20)
                    .scaleEffect(1.2)
            }
            
            // Bubble content
            VStack(spacing: 8) {
                Image(systemName: bubble.image)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .symbolEffect(.bounce, options: .repeating, value: isHighlighted)
                
                if therapyMode {
                    Text("\(index + 1)")
                        .font(.caption.bold())
                        .foregroundColor(.white.opacity(0.8))
                }
            }
        }
        .frame(width: 120, height: 120)
        .scaleEffect(isHovering ? 1.1 : (isHighlighted ? 1.15 : 1.0))
        .scaleEffect(bubbleScale)
        .rotation3DEffect(
            .degrees(isHighlighted ? 10 : 0),
            axis: (x: 1, y: 1, z: 0)
        )
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovering = hovering && isPlayerTurn
            }
        }
        .onTapGesture {
            if isPlayerTurn {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    bubbleScale = 0.9
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        bubbleScale = 1.0
                    }
                }
                
                onTap()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isHighlighted)
    }
}

struct InstructionRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue.opacity(0.8))
                .frame(width: 40)
            
            Text(text)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
            
            Spacer()
        }
    }
}

// MARK: - Data Models

struct BubbleData: Identifiable {
    let id: Int
    let image: String
    let color: Color
    let soundPosition: String
    var isHighlighted: Bool = false
}

// Safe array subscript extension
extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}

#Preview {
    MemoryBubblesView(showMemoriesBuble: .constant(true))
}


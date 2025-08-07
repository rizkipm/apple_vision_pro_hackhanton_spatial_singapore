////
////  CandyMainMenu.swift
////  hack_spatial_rizki_sg
////
////  Created by NUS on 7/8/25.
////


import SwiftUI

// MARK: - Candy Planet View
struct CandyPlanetView: View {
    @Binding var showCandyPlanet: Bool
    @State private var animateButton = false
    @State private var showGameContent = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.3),
                        Color.gray.opacity(0.4),
                        Color.yellow.opacity(0.3),
                        Color.purple.opacity(0.2)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Header section with candy background
                        ZStack {
                            // Candy background image placeholder
                            RoundedRectangle(cornerRadius: 0)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.pink.opacity(0.8),
                                            Color.orange.opacity(0.7),
                                            Color.yellow.opacity(0.6),
                                            Color.red.opacity(0.5)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(height: geometry.size.height * 0.6)
                                .overlay {
                                    ZStack {
                                        // Animated candy elements background
                                        CandyBackgroundView()
                                        
                                        // Large 3D animated candy on the left
                                        HStack {
                                            Large3DCandyView()
                                                .frame(width: 200, height: 300)
                                                .offset(x: -50, y: 20)
                                            
                                            Spacer()
                                            
                                            // 3D Lollipop model on the right center (using Simple3D)
                                            Simple3DLollipopView()
                                                .frame(width: 180, height: 250)
                                                .offset(x: 30, y: -10)
                                        }
                                    }
                                }
                            
                            // Top navigation bar
                            VStack {
                                HStack {
                                    // Start Exploring button
                                    Button {
                                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                            showGameContent = true
                                        }
                                    } label: {
                                        HStack(spacing: 8) {
                                            Image(systemName: "play.fill")
                                                .font(.system(size: 14, weight: .bold))
                                            
                                            Text("Start Exploring")
                                                .font(.system(size: 16, weight: .semibold))
                                        }
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 12)
                                        .background {
                                            Capsule()
                                                .fill(Color.red.opacity(0.9))
                                                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                                        }
                                    }
                                    .buttonStyle(.borderless)
                                    .hoverEffect(.lift)
                                    .scaleEffect(animateButton ? 1.05 : 1.0)
                                    .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: animateButton)
                                    
                                    Spacer()
                                    
                                    // Close button
                                    Button {
                                        showCandyPlanet = false
                                    } label: {
                                        Image(systemName: "xmark")
                                            .font(.title2)
                                            .fontWeight(.medium)
                                            .foregroundStyle(.white)
                                            .padding(12)
                                            .background {
                                                Circle()
                                                    .fill(.ultraThinMaterial.opacity(0.3))
                                            }
                                    }
                                    .buttonStyle(.borderless)
                                    .hoverEffect(.lift)
                                }
                                .padding(.horizontal, 24)
                                .padding(.top, 20)
                                
                                Spacer()
                            }
                        }
                        
                        // Content card section
                        VStack(spacing: 0) {
                            // Main content card
                            VStack(alignment: .leading, spacing: 24) {
                                // Title section
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Candy Planet")
                                        .font(.system(size: 36, weight: .bold, design: .rounded))
                                        .foregroundStyle(
                                            LinearGradient(
                                                gradient: Gradient(colors: [.pink, .red, .orange]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                    
                                    Text("A colorful candy-themed world set in a fantasy landscape. Balls are replaced with oversized sweets like lollipops and donuts. Ideal for attention therapy for kids with ADHD or sensory needs.")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(.primary.opacity(0.8))
                                        .lineSpacing(6)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                
                                // Ideas section
                                VStack(alignment: .leading, spacing: 16) {
                                    HStack {
                                        Image(systemName: "lightbulb.fill")
                                            .font(.title3)
                                            .foregroundStyle(.yellow)
                                        
                                        Text("Ideas:")
                                            .font(.system(size: 18, weight: .bold))
                                            .foregroundStyle(.primary)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 12) {
                                        IdeaItemView(
                                            icon: "target",
                                            text: "Catch candy flying from different angles",
                                            color: .pink
                                        )
                                        
                                        IdeaItemView(
                                            icon: "star.fill",
                                            text: "Bonus for catching \"golden candy\"",
                                            color: .orange
                                        )
                                        
                                        IdeaItemView(
                                            icon: "gamecontroller.fill",
                                            text: "Improve focus and coordination in a joyful, playful setting",
                                            color: .purple
                                        )
                                    }
                                }
                                
                                // Game features
                                GameFeaturesView()
                                
                                // Action buttons
                                VStack(spacing: 16) {
                                    // Primary action button
                                    Button {
                                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                            showGameContent = true
                                        }
                                    } label: {
                                        HStack {
                                            Image(systemName: "play.circle.fill")
                                                .font(.title2)
                                            
                                            Text("Start Playing")
                                                .font(.system(size: 18, weight: .semibold))
                                            
                                            Spacer()
                                            
                                            Image(systemName: "arrow.right")
                                                .font(.title3)
                                        }
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 24)
                                        .padding(.vertical, 16)
                                        .background {
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(
                                                    LinearGradient(
                                                        gradient: Gradient(colors: [.pink, .red]),
                                                        startPoint: .leading,
                                                        endPoint: .trailing
                                                    )
                                                )
                                                .shadow(color: .pink.opacity(0.3), radius: 12, x: 0, y: 6)
                                        }
                                    }
                                    .buttonStyle(.borderless)
                                    .hoverEffect(.lift)
                                    
                                    // Secondary action buttons
                                    HStack(spacing: 12) {
                                        SecondaryActionButton(
                                            title: "How to Play",
                                            icon: "questionmark.circle",
                                            color: .blue
                                        ) {
                                            // Show tutorial
                                        }
                                        
                                        SecondaryActionButton(
                                            title: "Settings",
                                            icon: "gear",
                                            color: .gray
                                        ) {
                                            // Show settings
                                        }
                                    }
                                }
                                .padding(.top, 8)
                            }
                            .padding(32)
                            .background {
                                RoundedRectangle(cornerRadius: 28)
                                    .fill(.ultraThinMaterial)
                                    .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
                            }
                            .padding(.horizontal, 24)
                            .offset(y: -40) // Overlap with the image section
                        }
                        
                        Spacer(minLength: 40)
                    }
                }
                .scrollContentBackground(.hidden)
                
                // Game content overlay
                if showGameContent {
                    GameContentOverlay(showGameContent: $showGameContent)
                }
            }
        }
        .onAppear {
            animateButton = true
        }
    }
}

// MARK: - 3D Lollipop Model View (Simplified)
struct Lollipop3DView: View {
    var body: some View {
        // Always use the SwiftUI-based fallback for compatibility
        FallbackLollipopView()
    }
}

// MARK: - Alternative Simple 3D Lollipop (No External Model)
struct Simple3DLollipopView: View {
    @State private var rotationY: Double = 0
    @State private var rotationX: Double = 0
    @State private var offsetY: Double = 0
    @State private var scale: Double = 1.0
    
    var body: some View {
        ZStack {
            // 3D Lollipop using SwiftUI 3D transforms
            VStack(spacing: 0) {
                // Lollipop candy (top)
                ZStack {
                    // Back layers for depth
                    ForEach(0..<5, id: \.self) { layer in
                        Circle()
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: [
                                        lollipopColors[layer % lollipopColors.count].opacity(0.8),
                                        lollipopColors[layer % lollipopColors.count].opacity(0.4)
                                    ]),
                                    center: .topLeading,
                                    startRadius: 5,
                                    endRadius: 40
                                )
                            )
                            .frame(width: 80 - CGFloat(layer * 3), height: 80 - CGFloat(layer * 3))
                            .offset(z: Double(layer) * -2)
                            .rotation3DEffect(
                                .degrees(rotationY + Double(layer * 10)),
                                axis: (x: 0, y: 1, z: 0)
                            )
                    }
                    
                    // Spiral pattern overlay
                    ForEach(0..<3, id: \.self) { index in
                        SpiralPath()
                            .stroke(
                                .white.opacity(0.6),
                                style: StrokeStyle(lineWidth: 2, lineCap: .round)
                            )
                            .frame(width: 60, height: 60)
                            .rotationEffect(.degrees(Double(index) * 120 + rotationY))
                    }
                    
                    // Highlight
                    Circle()
                        .fill(.white.opacity(0.8))
                        .frame(width: 12, height: 12)
                        .offset(x: -15, y: -15)
                }
                .frame(width: 80, height: 80)
                .rotation3DEffect(
                    .degrees(rotationX),
                    axis: (x: 1, y: 0, z: 0)
                )
                .rotation3DEffect(
                    .degrees(rotationY),
                    axis: (x: 0, y: 1, z: 0)
                )
                
                // Lollipop stick
                RoundedRectangle(cornerRadius: 3)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .brown.opacity(0.9),
                                .brown.opacity(0.6),
                                .brown.opacity(0.8)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 6, height: 100)
                    .rotation3DEffect(
                        .degrees(rotationX * 0.5),
                        axis: (x: 1, y: 0, z: 0)
                    )
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
            }
            .scaleEffect(scale)
            .offset(y: offsetY)
            .shadow(color: .pink.opacity(0.4), radius: 15, x: 0, y: 5)
        }
        .onAppear {
            startAnimations()
        }
    }
    
    private let lollipopColors: [Color] = [
        .pink, .red, .orange, .yellow, .purple
    ]
    
    private func startAnimations() {
        // Y-axis rotation
        withAnimation(.linear(duration: 8.0).repeatForever(autoreverses: false)) {
            rotationY = 360
        }
        
        // Subtle X-axis tilt
        withAnimation(.easeInOut(duration: 4.0).repeatForever(autoreverses: true)) {
            rotationX = 15
        }
        
        // Floating animation
        withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
            offsetY = -10
        }
        
        // Breathing scale
        withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
            scale = 1.1
        }
    }
}

// MARK: - Fallback Lollipop View
struct FallbackLollipopView: View {
    @State private var rotation = 0.0
    @State private var scale = 1.0
    @State private var offset = 0.0
    
    var body: some View {
        ZStack {
            // Lollipop stick
            RoundedRectangle(cornerRadius: 4)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.brown.opacity(0.8), .brown.opacity(0.6)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 8, height: 120)
                .offset(y: 40)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
            
            // Lollipop candy
            ZStack {
                // Main candy circle
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                .pink.opacity(0.9),
                                .red.opacity(0.8),
                                .purple.opacity(0.7)
                            ]),
                            center: .topLeading,
                            startRadius: 10,
                            endRadius: 50
                        )
                    )
                    .frame(width: 100, height: 100)
                    .overlay {
                        Circle()
                            .stroke(.white.opacity(0.4), lineWidth: 3)
                    }
                
                // Spiral pattern
                ForEach(0..<3, id: \.self) { index in
                    SpiralPath()
                        .stroke(
                            .white.opacity(0.6),
                            style: StrokeStyle(lineWidth: 3, lineCap: .round)
                        )
                        .frame(width: 80, height: 80)
                        .rotationEffect(.degrees(Double(index) * 120 + rotation))
                }
                
                // Center highlight
                Circle()
                    .fill(.white.opacity(0.8))
                    .frame(width: 15, height: 15)
                    .offset(x: -20, y: -20)
            }
            .offset(y: offset)
            .scaleEffect(scale)
            .rotationEffect(.degrees(rotation))
            .shadow(color: .pink.opacity(0.4), radius: 15, x: 0, y: 5)
        }
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        // Rotation animation
        withAnimation(.linear(duration: 8.0).repeatForever(autoreverses: false)) {
            rotation = 360
        }
        
        // Floating animation
        withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
            offset = -15
        }
        
        // Breathing scale
        withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
            scale = 1.1
        }
    }
}

// MARK: - Spiral Path for Lollipop Pattern
struct SpiralPath: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        path.move(to: center)
        
        for angle in stride(from: 0, through: 720, by: 10) {
            let radian = Double(angle) * .pi / 180
            let currentRadius = radius * (1 - Double(angle) / 720)
            let x = center.x + cos(radian) * currentRadius
            let y = center.y + sin(radian) * currentRadius
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        return path
    }
}
struct Large3DCandyView: View {
    @State private var rotationX: Double = 0
    @State private var rotationY: Double = 0
    @State private var rotationZ: Double = 0
    @State private var scale: Double = 1.0
    @State private var offsetY: Double = 0
    @State private var bounce: Bool = false
    
    var body: some View {
        ZStack {
            // Main candy body with 3D effect
            ZStack {
                // Shadow layer
                Ellipse()
                    .fill(.black.opacity(0.2))
                    .frame(width: 120, height: 40)
                    .offset(y: 100)
                    .scaleEffect(scale * 0.8)
                
                // Main candy layers for 3D effect
                ForEach(0..<5, id: \.self) { layer in
                    CandyLayer(
                        layerIndex: layer,
                        totalLayers: 5,
                        rotationX: rotationX,
                        rotationY: rotationY,
                        rotationZ: rotationZ
                    )
                    .scaleEffect(scale)
                    .offset(y: offsetY)
                }
                
                // Candy wrapper effect
                CandyWrapperView()
                    .scaleEffect(scale)
                    .offset(y: offsetY)
                    .rotation3DEffect(
                        .degrees(rotationY),
                        axis: (x: 0, y: 1, z: 0)
                    )
                
                // Sparkle effects
                SparkleEffectsView()
                    .scaleEffect(scale)
                    .offset(y: offsetY)
            }
        }
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        // Continuous rotation animation
        withAnimation(.linear(duration: 8.0).repeatForever(autoreverses: false)) {
            rotationY = 360
        }
        
        // Floating animation
        withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
            offsetY = -20
        }
        
        // Scale breathing animation
        withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
            scale = 1.1
        }
        
        // Slight tilt animation
        withAnimation(.easeInOut(duration: 4.0).repeatForever(autoreverses: true)) {
            rotationZ = 5
        }
        
        // X-axis wobble
        withAnimation(.easeInOut(duration: 3.5).repeatForever(autoreverses: true)) {
            rotationX = 10
        }
    }
}

// MARK: - Candy Layer for 3D Effect
struct CandyLayer: View {
    let layerIndex: Int
    let totalLayers: Int
    let rotationX: Double
    let rotationY: Double
    let rotationZ: Double
    
    var body: some View {
        let progress = Double(layerIndex) / Double(totalLayers - 1)
        let size = 80 + (20 * (1 - progress))
        
        RoundedRectangle(cornerRadius: size * 0.3)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        layerColor.opacity(0.9 - progress * 0.3),
                        layerColor.opacity(0.6 - progress * 0.2)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: size, height: size * 1.4)
            .overlay {
                RoundedRectangle(cornerRadius: size * 0.3)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .white.opacity(0.6),
                                .clear,
                                .black.opacity(0.2)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
            }
            .rotation3DEffect(
                .degrees(rotationX),
                axis: (x: 1, y: 0, z: 0)
            )
            .rotation3DEffect(
                .degrees(rotationY + Double(layerIndex) * 5),
                axis: (x: 0, y: 1, z: 0)
            )
            .rotation3DEffect(
                .degrees(rotationZ),
                axis: (x: 0, y: 0, z: 1)
            )
            .offset(z: Double(layerIndex) * -5)
    }
    
    private var layerColor: Color {
        let colors: [Color] = [.pink, .red, .orange, .yellow, .purple]
        return colors[layerIndex % colors.count]
    }
}

// MARK: - Candy Wrapper View
struct CandyWrapperView: View {
    @State private var shimmer = false
    
    var body: some View {
        ZStack {
            // Wrapper top
            Ellipse()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .white.opacity(0.8),
                            .white.opacity(0.4),
                            .clear
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 90, height: 30)
                .offset(y: -70)
            
            // Wrapper bottom
            Ellipse()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .clear,
                            .white.opacity(0.4),
                            .white.opacity(0.8)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 90, height: 30)
                .offset(y: 70)
            
            // Shimmer effect
            if shimmer {
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .clear,
                                .white.opacity(0.6),
                                .clear
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 20, height: 140)
                    .offset(x: shimmer ? 50 : -50)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: false).delay(1.0)) {
                shimmer.toggle()
            }
        }
    }
}

// MARK: - Sparkle Effects View
struct SparkleEffectsView: View {
    @State private var sparkles: [SparkleDataModel] = []
    
    var body: some View {
        ZStack {
            ForEach(sparkles, id: \.id) { sparkle in
                SparkleViewComponent(sparkle: sparkle)
            }
        }
        .onAppear {
            generateSparkles()
            startSparkleAnimation()
        }
    }
    
    private func generateSparkles() {
        sparkles = (0..<8).map { index in
            SparkleDataModel(
                id: index,
                x: Double.random(in: -80...80),
                y: Double.random(in: -100...100),
                size: Double.random(in: 4...12),
                opacity: Double.random(in: 0.3...0.8),
                delay: Double.random(in: 0...2)
            )
        }
    }
    
    private func startSparkleAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            for index in sparkles.indices {
                withAnimation(.easeInOut(duration: 1.5).delay(sparkles[index].delay)) {
                    sparkles[index].opacity = sparkles[index].opacity > 0.1 ? 0.1 : 0.8
                }
            }
        }
    }
}

// MARK: - Sparkle Data Model
struct SparkleDataModel {
    let id: Int
    let x: Double
    let y: Double
    let size: Double
    var opacity: Double
    let delay: Double
}

// MARK: - Individual Sparkle View Component
struct SparkleViewComponent: View {
    let sparkle: SparkleDataModel
    @State private var rotation = 0.0
    
    var body: some View {
        Image(systemName: "sparkle")
            .font(.system(size: sparkle.size, weight: .bold))
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(colors: [.yellow, .white, .pink]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .opacity(sparkle.opacity)
            .rotationEffect(.degrees(rotation))
            .position(x: sparkle.x + 100, y: sparkle.y + 150)
            .onAppear {
                withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
    }
}


// MARK: - Candy Layer Component for 3D Effect
struct CandyLayerComponent: View {
    let layerIndex: Int
    let totalLayers: Int
    let rotationX: Double
    let rotationY: Double
    let rotationZ: Double
    
    var body: some View {
        let progress = Double(layerIndex) / Double(totalLayers - 1)
        let size = 80 + (20 * (1 - progress))
        
        RoundedRectangle(cornerRadius: size * 0.3)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        layerColor.opacity(0.9 - progress * 0.3),
                        layerColor.opacity(0.6 - progress * 0.2)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: size, height: size * 1.4)
            .overlay {
                RoundedRectangle(cornerRadius: size * 0.3)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .white.opacity(0.6),
                                .clear,
                                .black.opacity(0.2)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
            }
            .rotation3DEffect(
                .degrees(rotationX),
                axis: (x: 1, y: 0, z: 0)
            )
            .rotation3DEffect(
                .degrees(rotationY + Double(layerIndex) * 5),
                axis: (x: 0, y: 1, z: 0)
            )
            .rotation3DEffect(
                .degrees(rotationZ),
                axis: (x: 0, y: 0, z: 1)
            )
    }
    
    private var layerColor: Color {
        let colors: [Color] = [.pink, .red, .orange, .yellow, .purple]
        return colors[layerIndex % colors.count]
    }
}

// MARK: - Candy Wrapper View Component
struct CandyWrapperViewComponent: View {
    @State private var shimmer = false
    
    var body: some View {
        ZStack {
            // Wrapper top
            Ellipse()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .white.opacity(0.8),
                            .white.opacity(0.4),
                            .clear
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 90, height: 30)
                .offset(y: -70)
            
            // Wrapper bottom
            Ellipse()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .clear,
                            .white.opacity(0.4),
                            .white.opacity(0.8)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 90, height: 30)
                .offset(y: 70)
            
            // Shimmer effect
            if shimmer {
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .clear,
                                .white.opacity(0.6),
                                .clear
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 20, height: 140)
                    .offset(x: shimmer ? 50 : -50)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: false).delay(1.0)) {
                shimmer.toggle()
            }
        }
    }
}


// MARK: - Sparkle Data
struct SparkleData {
    let id: Int
    let x: Double
    let y: Double
    let size: Double
    var opacity: Double
    let delay: Double
}

// MARK: - Individual Sparkle View
struct SparkleView: View {
    let sparkle: SparkleData
    @State private var rotation = 0.0
    
    var body: some View {
        Image(systemName: "sparkle")
            .font(.system(size: sparkle.size, weight: .bold))
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(colors: [.yellow, .white, .pink]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .opacity(sparkle.opacity)
            .rotationEffect(.degrees(rotation))
            .position(x: sparkle.x + 100, y: sparkle.y + 150)
            .onAppear {
                withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
    }
}

// MARK: - Enhanced Candy Background View
struct CandyBackgroundView: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            // Animated candy elements (smaller for background)
            ForEach(0..<12, id: \.self) { index in
                CandyElement(
                    color: candyColors.randomElement() ?? .pink,
                    size: CGFloat.random(in: 20...40),
                    delay: Double(index) * 0.3
                )
                .position(
                    x: CGFloat.random(in: 250...400), // Positioned more to the right
                    y: CGFloat.random(in: 50...400)
                )
            }
        }
        .onAppear {
            animate = true
        }
    }
    
    private let candyColors: [Color] = [
        .pink, .red, .orange, .yellow, .green, .blue, .purple
    ]
}

// MARK: - Candy Element
struct CandyElement: View {
    let color: Color
    let size: CGFloat
    let delay: Double
    
    @State private var rotation = 0.0
    @State private var scale = 0.8
    
    var body: some View {
        Circle()
            .fill(
                RadialGradient(
                    gradient: Gradient(colors: [color.opacity(0.8), color.opacity(0.4)]),
                    center: .topLeading,
                    startRadius: 5,
                    endRadius: size/2
                )
            )
            .frame(width: size, height: size)
            .overlay {
                Circle()
                    .stroke(.white.opacity(0.3), lineWidth: 2)
            }
            .scaleEffect(scale)
            .rotationEffect(.degrees(rotation))
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 3.0)
                    .repeatForever(autoreverses: true)
                    .delay(delay)
                ) {
                    rotation = 360
                    scale = 1.2
                }
            }
    }
}

// MARK: - Idea Item View
struct IdeaItemView: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(color)
                .frame(width: 24, height: 24)
                .background {
                    Circle()
                        .fill(color.opacity(0.1))
                }
            
            Text(text)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(.primary.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
        }
    }
}

// MARK: - Game Features View
struct GameFeaturesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "sparkles")
                    .font(.title3)
                    .foregroundStyle(.purple)
                
                Text("Game Features:")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.primary)
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                FeatureCard(
                    icon: "eye.fill",
                    title: "Visual Training",
                    description: "Enhance eye tracking",
                    color: .blue
                )
                
                FeatureCard(
                    icon: "hand.point.up.left.fill",
                    title: "Hand-Eye Coordination",
                    description: "Improve motor skills",
                    color: .green
                )
                
                FeatureCard(
                    icon: "brain.head.profile",
                    title: "Focus Training",
                    description: "Attention therapy",
                    color: .orange
                )
                
                FeatureCard(
                    icon: "heart.fill",
                    title: "Sensory Friendly",
                    description: "ADHD & autism support",
                    color: .red
                )
            }
        }
    }
}

// MARK: - Feature Card
struct FeatureCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
            
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
            
            Text(description)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial.opacity(0.5))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                }
        }
    }
}

// MARK: - Secondary Action Button
struct SecondaryActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    @State private var isHovered = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
            }
            .foregroundStyle(color)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.ultraThinMaterial.opacity(0.3))
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(color.opacity(0.3), lineWidth: 1)
                    }
            }
            .scaleEffect(isHovered ? 1.05 : 1.0)
        }
        .buttonStyle(.borderless)
        .hoverEffect(.lift)
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovered = hovering
            }
        }
    }
}

// MARK: - Game Content Overlay
struct GameContentOverlay: View {
    @Binding var showGameContent: Bool
    @State private var progress: Double = 0
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
                .onTapGesture {
                    showGameContent = false
                }
            
            VStack(spacing: 24) {
                // Loading animation
                VStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .stroke(.white.opacity(0.3), lineWidth: 8)
                            .frame(width: 80, height: 80)
                        
                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [.pink, .orange]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                style: StrokeStyle(lineWidth: 8, lineCap: .round)
                            )
                            .frame(width: 80, height: 80)
                            .rotationEffect(.degrees(-90))
                    }
                    
                    Text("Loading Candy Planet...")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    
                    Text("Preparing your sweet adventure")
                        .font(.body)
                        .foregroundStyle(.white.opacity(0.7))
                }
                
                Button {
                    showGameContent = false
                } label: {
                    Text("Cancel")
                        .foregroundStyle(.white.opacity(0.8))
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background {
                            Capsule()
                                .stroke(.white.opacity(0.3), lineWidth: 1)
                        }
                }
                .buttonStyle(.borderless)
                .hoverEffect(.lift)
            }
            .padding(40)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
            }
            .padding(40)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0)) {
                progress = 1.0
            }
        }
    }
}

#Preview {
    CandyPlanetView(showCandyPlanet: .constant(true))
}

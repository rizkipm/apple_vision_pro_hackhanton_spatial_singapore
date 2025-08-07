//
//  SpaceCatcherMainMenu.swift
//  hack_spatial_rizki_sg
//
//  Created by NUS on 7/8/25.
//

import SwiftUI

// MARK: - Space Catcher View
struct SpaceCatcherView: View {
    @Binding var showSpaceCatcher: Bool
    @State private var animateButton = false
    @State private var showGameContent = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black.opacity(0.9),
                        Color.purple.opacity(0.4),
                        Color.blue.opacity(0.3),
                        Color.indigo.opacity(0.2)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Header section with space background
                        ZStack {
                            // Space background
                            RoundedRectangle(cornerRadius: 0)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.black.opacity(0.9),
                                            Color.purple.opacity(0.7),
                                            Color.indigo.opacity(0.6),
                                            Color.blue.opacity(0.5)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(height: geometry.size.height * 0.6)
                                .overlay {
                                    ZStack {
                                        // Animated space elements background
                                        SpaceBackgroundView()
                                        
                                        // Large 3D Planet on the left
                                        HStack {
                                            Large3DPlanetView()
                                                .frame(width: 240, height: 320)
                                                .offset(x: -30, y: 0)
                                            
                                            Spacer()
                                            
                                            // 3D Spaceship on the right
                                            SpaceshipView()
                                                .frame(width: 200, height: 280)
                                                .offset(x: 40, y: -30)
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
                                                .fill(Color.orange.opacity(0.9))
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
                                        showSpaceCatcher = false
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
                                    Text("Space Catcher")
                                        .font(.system(size: 36, weight: .bold, design: .rounded))
                                        .foregroundStyle(
                                            LinearGradient(
                                                gradient: Gradient(colors: [.blue, .purple, .orange]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                    
                                    Text("A futuristic outer space world. Players catch meteors, satellites, or mini-planets in zero-gravity environments. Sci-fi sounds and speed make it ideal for teens and young adults.")
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
                                            icon: "circle.fill",
                                            text: "Catch high-speed meteors",
                                            color: .orange
                                        )
                                        
                                        IdeaItemView(
                                            icon: "eye.trianglebadge.exclamationmark",
                                            text: "Avoid black holes that mislead the trajectory",
                                            color: .purple
                                        )
                                        
                                        IdeaItemView(
                                            icon: "timer",
                                            text: "Competitive mode for fastest reaction time",
                                            color: .blue
                                        )
                                    }
                                }
                                
                                // Game features
                                SpaceGameFeaturesView()
                                
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
                                                        gradient: Gradient(colors: [.blue, .purple]),
                                                        startPoint: .leading,
                                                        endPoint: .trailing
                                                    )
                                                )
                                                .shadow(color: .blue.opacity(0.3), radius: 12, x: 0, y: 6)
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
                    SpaceGameContentOverlay(showGameContent: $showGameContent)
                }
            }
        }
        .onAppear {
            animateButton = true
        }
    }
}

// MARK: - Large 3D Planet View
struct Large3DPlanetView: View {
    @State private var rotationY: Double = 0
    @State private var scale: Double = 1.0
    @State private var offsetY: Double = 0
    @State private var glowIntensity: Double = 0.5
    
    var body: some View {
        ZStack {
            // Planet core with multiple layers
            ZStack {
                ForEach(0..<5, id: \.self) { layer in
                    PlanetLayer(
                        layerIndex: layer,
                        totalLayers: 5,
                        rotationY: rotationY,
                        glowIntensity: glowIntensity
                    )
                    .scaleEffect(scale)
                    .offset(y: offsetY)
                }
                
                // Planet atmosphere effect
                PlanetAtmosphereView()
                    .scaleEffect(scale)
                    .offset(y: offsetY)
                
                // Floating orbital elements
                OrbitalElementsView()
                    .scaleEffect(scale)
                    .offset(y: offsetY)
            }
        }
        .onAppear {
            startPlanetAnimations()
        }
    }
    
    private func startPlanetAnimations() {
        // Planet rotation
        let rotationAnimation = Animation.linear(duration: 12.0).repeatForever(autoreverses: false)
        withAnimation(rotationAnimation) {
            rotationY = 360
        }
        
        // Floating animation
        let floatAnimation = Animation.easeInOut(duration: 4.0).repeatForever(autoreverses: true)
        withAnimation(floatAnimation) {
            offsetY = -15
        }
        
        // Breathing scale
        let scaleAnimation = Animation.easeInOut(duration: 6.0).repeatForever(autoreverses: true)
        withAnimation(scaleAnimation) {
            scale = 1.08
        }
        
        // Glow effect
        let glowAnimation = Animation.easeInOut(duration: 3.0).repeatForever(autoreverses: true)
        withAnimation(glowAnimation) {
            glowIntensity = 1.0
        }
    }
}

// MARK: - Planet Layer
struct PlanetLayer: View {
    let layerIndex: Int
    let totalLayers: Int
    let rotationY: Double
    let glowIntensity: Double
    
    var body: some View {
        let progress = Double(layerIndex) / Double(totalLayers - 1)
        let size = 140 - (CGFloat(layerIndex) * 8)
        let layerRotation = rotationY + Double(layerIndex) * 10
        
        Circle()
            .fill(planetGradient(for: layerIndex, progress: progress))
            .frame(width: size, height: size)
            .overlay {
                Circle()
                    .stroke(planetRingColor(for: layerIndex).opacity(0.4), lineWidth: 1)
            }
            .rotation3DEffect(
                .degrees(layerRotation),
                axis: (x: 0, y: 1, z: 0)
            )
            .shadow(color: planetRingColor(for: layerIndex).opacity(glowIntensity * 0.6), radius: 10)
    }
    
    private func planetGradient(for layerIndex: Int, progress: Double) -> RadialGradient {
        let colors = planetColors[layerIndex % planetColors.count]
        
        return RadialGradient(
            gradient: Gradient(colors: [
                colors.0.opacity(0.9 - progress * 0.2),
                colors.1.opacity(0.6 - progress * 0.1)
            ]),
            center: .topLeading,
            startRadius: 10,
            endRadius: 60
        )
    }
    
    private func planetRingColor(for layerIndex: Int) -> Color {
        let ringColors: [Color] = [.blue, .purple, .cyan, .orange, .white]
        return ringColors[layerIndex % ringColors.count]
    }
    
    private let planetColors: [(Color, Color)] = [
        (.blue, .cyan),
        (.purple, .indigo),
        (.orange, .red),
        (.cyan, .blue),
        (.indigo, .purple)
    ]
}

// MARK: - Planet Atmosphere View
struct PlanetAtmosphereView: View {
    @State private var atmosphereGlow: Double = 0.3
    
    var body: some View {
        Circle()
            .fill(.clear)
            .stroke(
                LinearGradient(
                    gradient: Gradient(colors: [
                        .cyan.opacity(atmosphereGlow),
                        .blue.opacity(atmosphereGlow * 0.5),
                        .clear
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 4
            )
            .frame(width: 160, height: 160)
            .onAppear {
                let glowAnimation = Animation.easeInOut(duration: 2.5).repeatForever(autoreverses: true)
                withAnimation(glowAnimation) {
                    atmosphereGlow = 0.8
                }
            }
    }
}

// MARK: - Orbital Elements View
struct OrbitalElementsView: View {
    @State private var orbitals: [OrbitalElement] = []
    
    var body: some View {
        ZStack {
            ForEach(orbitals, id: \.id) { orbital in
                OrbitalElementView(orbital: orbital)
            }
        }
        .onAppear {
            generateOrbitals()
            startOrbitalAnimation()
        }
    }
    
    private func generateOrbitals() {
        orbitals = (0..<6).map { index in
            OrbitalElement(
                id: index,
                radius: Double.random(in: 80...120),
                angle: Double(index) * 60,
                size: Double.random(in: 6...12),
                speed: Double.random(in: 0.5...2.0),
                color: orbitalColors.randomElement() ?? .white
            )
        }
    }
    
    private func startOrbitalAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            for index in orbitals.indices {
                orbitals[index].angle += orbitals[index].speed
                if orbitals[index].angle > 360 {
                    orbitals[index].angle = 0
                }
            }
        }
    }
    
    private let orbitalColors: [Color] = [.white, .cyan, .yellow, .orange, .purple]
}

// MARK: - Orbital Element Model
struct OrbitalElement {
    let id: Int
    let radius: Double
    var angle: Double
    let size: Double
    let speed: Double
    let color: Color
}

// MARK: - Orbital Element View
struct OrbitalElementView: View {
    let orbital: OrbitalElement
    
    var body: some View {
        let x = orbital.radius * cos(orbital.angle * .pi / 180)
        let y = orbital.radius * sin(orbital.angle * .pi / 180)
        
        Circle()
            .fill(orbital.color)
            .frame(width: orbital.size, height: orbital.size)
            .shadow(color: orbital.color.opacity(0.8), radius: 4)
            .position(x: x + 120, y: y + 160)
    }
}

// MARK: - Spaceship View
struct SpaceshipView: View {
    @State private var engineGlow: Double = 0.5
    @State private var shipRotation: Double = 0
    @State private var engineFlicker: Bool = false
    @State private var offsetX: Double = 0
    
    var body: some View {
        ZStack {
            // Spaceship body
            SpaceshipBodyView(shipRotation: shipRotation)
            
            // Engine effects
            SpaceshipEngineView(engineGlow: engineGlow, engineFlicker: engineFlicker)
                .offset(y: 60)
            
            // Wing effects
            SpaceshipWingsView(shipRotation: shipRotation)
        }
        .offset(x: offsetX)
        .onAppear {
            startSpaceshipAnimations()
        }
    }
    
    private func startSpaceshipAnimations() {
        // Engine glow
        let engineAnimation = Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)
        withAnimation(engineAnimation) {
            engineGlow = 1.0
        }
        
        // Ship gentle rotation
        let rotationAnimation = Animation.easeInOut(duration: 8.0).repeatForever(autoreverses: true)
        withAnimation(rotationAnimation) {
            shipRotation = 10
        }
        
        // Horizontal movement
        let movementAnimation = Animation.easeInOut(duration: 5.0).repeatForever(autoreverses: true)
        withAnimation(movementAnimation) {
            offsetX = 20
        }
        
        // Engine flicker
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.1)) {
                engineFlicker.toggle()
            }
        }
    }
}

// MARK: - Spaceship Body View
struct SpaceshipBodyView: View {
    let shipRotation: Double
    
    var body: some View {
        ZStack {
            // Main body
            Ellipse()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .gray.opacity(0.9),
                            .white.opacity(0.7),
                            .gray.opacity(0.8)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 60, height: 120)
            
            // Cockpit
            Ellipse()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [.cyan.opacity(0.8), .blue.opacity(0.4)]),
                        center: .center,
                        startRadius: 5,
                        endRadius: 15
                    )
                )
                .frame(width: 30, height: 40)
                .offset(y: -20)
            
            // Body details
            ForEach(0..<3, id: \.self) { index in
                Rectangle()
                    .fill(.white.opacity(0.6))
                    .frame(width: 2, height: 15)
                    .offset(y: CGFloat(index) * 15 - 10)
            }
        }
        .rotation3DEffect(
            .degrees(shipRotation),
            axis: (x: 0, y: 0, z: 1)
        )
        .shadow(color: .cyan.opacity(0.4), radius: 8)
    }
}

// MARK: - Spaceship Engine View
struct SpaceshipEngineView: View {
    let engineGlow: Double
    let engineFlicker: Bool
    
    var body: some View {
        ZStack {
            // Engine flames
            ForEach(0..<3, id: \.self) { index in
                Ellipse()
                    .fill(flameColor(for: index))
                    .frame(width: 15 - CGFloat(index) * 3, height: 25 + CGFloat(index) * 8)
                    .opacity(engineFlicker && index == 0 ? 0.7 : engineGlow)
                    .offset(y: CGFloat(index) * 5)
            }
        }
    }
    
    private func flameColor(for index: Int) -> LinearGradient {
        let colors: [(Color, Color)] = [
            (.blue, .cyan),
            (.cyan, .white),
            (.white, .blue)
        ]
        
        let colorPair = colors[index % colors.count]
        return LinearGradient(
            gradient: Gradient(colors: [colorPair.0, colorPair.1]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

// MARK: - Spaceship Wings View
struct SpaceshipWingsView: View {
    let shipRotation: Double
    
    var body: some View {
        HStack(spacing: 50) {
            // Left wing
            WingView(isLeft: true)
            
            // Right wing
            WingView(isLeft: false)
        }
        .rotation3DEffect(
            .degrees(shipRotation * 0.5),
            axis: (x: 1, y: 0, z: 0)
        )
    }
}

// MARK: - Wing View
struct WingView: View {
    let isLeft: Bool
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: isLeft ? -20 : 20, y: -15))
            path.addLine(to: CGPoint(x: isLeft ? -25 : 25, y: 10))
            path.addLine(to: CGPoint(x: 0, y: 20))
            path.closeSubpath()
        }
        .fill(
            LinearGradient(
                gradient: Gradient(colors: [.gray.opacity(0.8), .white.opacity(0.6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .shadow(color: .black.opacity(0.3), radius: 3)
    }
}

// MARK: - Space Background View
struct SpaceBackgroundView: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            // Stars
            ForEach(0..<30, id: \.self) { index in
                StarView(
                    size: CGFloat.random(in: 2...6),
                    delay: Double.random(in: 0...3)
                )
                .position(
                    x: CGFloat.random(in: 50...450),
                    y: CGFloat.random(in: 50...400)
                )
            }
            
            // Meteors
            ForEach(0..<8, id: \.self) { index in
                MeteorView(
                    speed: Double.random(in: 1...3),
                    delay: Double.random(in: 0...5)
                )
                .position(
                    x: CGFloat.random(in: 100...400),
                    y: CGFloat.random(in: 100...300)
                )
            }
            
            // Nebula effects
            ForEach(0..<5, id: \.self) { index in
                NebulaView(
                    color: nebulaColors.randomElement() ?? .purple,
                    delay: Double.random(in: 0...4)
                )
                .position(
                    x: CGFloat.random(in: 200...400),
                    y: CGFloat.random(in: 100...350)
                )
            }
        }
        .onAppear {
            animate = true
        }
    }
    
    private let nebulaColors: [Color] = [.purple, .blue, .cyan, .indigo, .pink]
}

// MARK: - Star View
struct StarView: View {
    let size: CGFloat
    let delay: Double
    @State private var twinkle: Double = 0.3
    
    var body: some View {
        Image(systemName: "star.fill")
            .font(.system(size: size))
            .foregroundStyle(.white)
            .opacity(twinkle)
            .onAppear {
                let twinkleAnimation = Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true).delay(delay)
                withAnimation(twinkleAnimation) {
                    twinkle = 1.0
                }
            }
    }
}

// MARK: - Meteor View
struct MeteorView: View {
    let speed: Double
    let delay: Double
    @State private var offsetX: Double = 0
    @State private var offsetY: Double = 0
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            // Meteor trail
            Ellipse()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.orange, .red, .clear]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 30, height: 8)
            
            // Meteor core
            Circle()
                .fill(.orange)
                .frame(width: 8, height: 8)
                .shadow(color: .orange.opacity(0.8), radius: 4)
        }
        .rotationEffect(.degrees(rotation))
        .offset(x: offsetX, y: offsetY)
        .onAppear {
            let moveAnimation = Animation.linear(duration: 4.0 / speed).repeatForever(autoreverses: false).delay(delay)
            withAnimation(moveAnimation) {
                offsetX = 100
                offsetY = 100
                rotation = 360
            }
        }
    }
}

// MARK: - Nebula View
struct NebulaView: View {
    let color: Color
    let delay: Double
    @State private var scale: Double = 0.5
    @State private var opacity: Double = 0.2
    
    var body: some View {
        Circle()
            .fill(
                RadialGradient(
                    gradient: Gradient(colors: [
                        color.opacity(opacity),
                        color.opacity(opacity * 0.5),
                        .clear
                    ]),
                    center: .center,
                    startRadius: 10,
                    endRadius: 40
                )
            )
            .frame(width: 80, height: 80)
            .scaleEffect(scale)
            .onAppear {
                let nebulaAnimation = Animation.easeInOut(duration: 6.0).repeatForever(autoreverses: true).delay(delay)
                withAnimation(nebulaAnimation) {
                    scale = 1.2
                    opacity = 0.6
                }
            }
    }
}

// MARK: - Space Game Features View
struct SpaceGameFeaturesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "sparkles")
                    .font(.title3)
                    .foregroundStyle(.cyan)
                
                Text("Game Features:")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.primary)
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                FeatureCard(
                    icon: "bolt.fill",
                    title: "High-Speed Action",
                    description: "Fast-paced meteor catching",
                    color: .orange
                )
                
                FeatureCard(
                    icon: "eye.fill",
                    title: "Reflex Training",
                    description: "Quick reaction exercises",
                    color: .blue
                )
                
                FeatureCard(
                    icon: "target",
                    title: "Precision Tracking",
                    description: "Accurate object tracking",
                    color: .purple
                )
                
                FeatureCard(
                    icon: "timer",
                    title: "Competitive Mode",
                    description: "Fastest reaction time",
                    color: .cyan
                )
            }
        }
    }
}

// MARK: - Space Game Content Overlay
struct SpaceGameContentOverlay: View {
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
                                    gradient: Gradient(colors: [.blue, .purple]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                style: StrokeStyle(lineWidth: 8, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                    }
                    
                    Text("Loading Space Catcher...")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    
                    Text("Preparing your cosmic adventure")
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
    SpaceCatcherView(showSpaceCatcher: .constant(true))
}

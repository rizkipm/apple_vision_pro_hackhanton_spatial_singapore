import SwiftUI

// MARK: - Zen Garden View
struct ZenGardenView: View {
    @Binding var showZenGarden: Bool
    @State private var animateButton = false
    @State private var showGameContent = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.green.opacity(0.3),
                        Color.blue.opacity(0.2),
                        Color.brown.opacity(0.3),
                        Color.gray.opacity(0.2)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Header section with zen garden background
                        ZStack {
                            // Garden background
                            RoundedRectangle(cornerRadius: 0)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.green.opacity(0.8),
                                            Color.brown.opacity(0.6),
                                            Color.gray.opacity(0.7),
                                            Color.blue.opacity(0.5)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(height: geometry.size.height * 0.6)
                                .overlay {
                                    ZStack {
                                        // Animated garden elements background
                                        ZenGardenBackgroundView()
                                        
                                        // Large 3D zen tree on the left
                                        HStack {
                                            Large3DZenTreeView()
                                                .frame(width: 220, height: 320)
                                                .offset(x: -40, y: 10)
                                            
                                            Spacer()
                                            
                                            // 3D Stone garden on the right
                                            ZenStoneGardenView()
                                                .frame(width: 200, height: 280)
                                                .offset(x: 20, y: -20)
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
                                                .fill(Color.green.opacity(0.9))
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
                                        showZenGarden = false
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
                                    Text("Zen Garden")
                                        .font(.system(size: 36, weight: .bold, design: .rounded))
                                        .foregroundStyle(
                                            LinearGradient(
                                                gradient: Gradient(colors: [.green, .blue, .brown]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                    
                                    Text("A tranquil Japanese-style garden with calming music, bamboo, and flowing water. Slow-paced, mindful exercises for elderly users or post-stroke recovery.")
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
                                            icon: "leaf.fill",
                                            text: "Catch falling flower petals in slow motion",
                                            color: .green
                                        )
                                        
                                        IdeaItemView(
                                            icon: "eye.fill",
                                            text: "Reflex & depth training in a peaceful setting",
                                            color: .blue
                                        )
                                        
                                        IdeaItemView(
                                            icon: "lungs.fill",
                                            text: "Breathing/relaxation mini-practice before gameplay",
                                            color: .purple
                                        )
                                    }
                                }
                                
                                // Game features
                                ZenGameFeaturesView()
                                
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
                                                        gradient: Gradient(colors: [.green, .blue]),
                                                        startPoint: .leading,
                                                        endPoint: .trailing
                                                    )
                                                )
                                                .shadow(color: .green.opacity(0.3), radius: 12, x: 0, y: 6)
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
                    ZenGameContentOverlay(showGameContent: $showGameContent)
                }
            }
        }
        .onAppear {
            animateButton = true
        }
    }
}

// MARK: - Large 3D Zen Tree View
struct Large3DZenTreeView: View {
    @State private var rotationY: Double = 0
    @State private var scale: Double = 1.0
    @State private var offsetY: Double = 0
    @State private var windSway: Double = 0
    
    var body: some View {
        ZStack {
            // Tree trunk
            VStack(spacing: 0) {
                Spacer()
                
                // Tree trunk with 3D effect
                TreeTrunkView(windSway: windSway)
            }
            .frame(height: 200)
            
            // Tree foliage with layers
            VStack {
                ZStack {
                    ForEach(0..<5, id: \.self) { layer in
                        TreeFoliageLayer(
                            layerIndex: layer,
                            totalLayers: 5,
                            windSway: windSway,
                            rotationY: rotationY
                        )
                        .scaleEffect(scale)
                        .offset(y: offsetY)
                    }
                    
                    // Floating leaves effect
                    FloatingLeavesView()
                        .scaleEffect(scale)
                        .offset(y: offsetY)
                }
                
                Spacer()
            }
        }
        .onAppear {
            startTreeAnimations()
        }
    }
    
    private func startTreeAnimations() {
        // Gentle wind sway
        let windAnimation = Animation.easeInOut(duration: 4.0).repeatForever(autoreverses: true)
        withAnimation(windAnimation) {
            windSway = 3
        }
        
        // Floating animation
        let floatAnimation = Animation.easeInOut(duration: 3.5).repeatForever(autoreverses: true)
        withAnimation(floatAnimation) {
            offsetY = -8
        }
        
        // Breathing scale
        let scaleAnimation = Animation.easeInOut(duration: 5.0).repeatForever(autoreverses: true)
        withAnimation(scaleAnimation) {
            scale = 1.05
        }
        
        // Subtle rotation
        let rotationAnimation = Animation.linear(duration: 20.0).repeatForever(autoreverses: false)
        withAnimation(rotationAnimation) {
            rotationY = 10
        }
    }
}

// MARK: - Tree Trunk View (Separate Component)
struct TreeTrunkView: View {
    let windSway: Double
    
    var body: some View {
        ZStack {
            ForEach(0..<3, id: \.self) { layer in
                TrunkLayerView(layer: layer, windSway: windSway)
            }
        }
        .shadow(color: .black.opacity(0.3), radius: 5, x: 2, y: 2)
    }
}

// MARK: - Individual Trunk Layer
struct TrunkLayerView: View {
    let layer: Int
    let windSway: Double
    
    var body: some View {
        let layerOpacity = 0.9 - Double(layer) * 0.2
        let layerOpacity2 = 0.6 - Double(layer) * 0.1
        let layerWidth = 25 - CGFloat(layer * 2)
        let layerOffset = Double(layer) * -1
        let layerRotation = windSway + Double(layer) * 2
        
        RoundedRectangle(cornerRadius: 8)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.brown.opacity(layerOpacity),
                        Color.brown.opacity(layerOpacity2)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(width: layerWidth, height: 120)
            .offset(x: layerOffset)
            .rotation3DEffect(
                .degrees(layerRotation),
                axis: (x: 0, y: 0, z: 1)
            )
    }
}

// MARK: - Tree Foliage Layer
struct TreeFoliageLayer: View {
    let layerIndex: Int
    let totalLayers: Int
    let windSway: Double
    let rotationY: Double
    
    var body: some View {
        let progress = Double(layerIndex) / Double(totalLayers - 1)
        let size = 120 - (CGFloat(layerIndex) * 8)
        
        Circle()
            .fill(
                RadialGradient(
                    gradient: Gradient(colors: [
                        foliageColor.opacity(0.9 - progress * 0.2),
                        foliageColor.opacity(0.5 - progress * 0.1)
                    ]),
                    center: .topLeading,
                    startRadius: 10,
                    endRadius: size/2
                )
            )
            .frame(width: size, height: size)
            .overlay {
                Circle()
                    .stroke(.white.opacity(0.3), lineWidth: 1)
            }
            .rotation3DEffect(
                .degrees(windSway + Double(layerIndex) * 2),
                axis: (x: 0, y: 0, z: 1)
            )
            .rotation3DEffect(
                .degrees(rotationY + Double(layerIndex) * 3),
                axis: (x: 0, y: 1, z: 0)
            )
            .offset(y: CGFloat(layerIndex) * -10)
            .offset(z: Double(layerIndex) * -2)
    }
    
    private var foliageColor: Color {
        let colors: [Color] = [.green, Color.green.opacity(0.8), Color.mint, Color.teal]
        return colors[layerIndex % colors.count]
    }
}

// MARK: - Floating Leaves View
struct FloatingLeavesView: View {
    @State private var leaves: [FloatingLeaf] = []
    
    var body: some View {
        ZStack {
            ForEach(leaves, id: \.id) { leaf in
                FloatingLeafView(leaf: leaf)
            }
        }
        .onAppear {
            generateLeaves()
            startLeafAnimation()
        }
    }
    
    private func generateLeaves() {
        leaves = (0..<6).map { index in
            FloatingLeaf(
                id: index,
                x: Double.random(in: -60...60),
                y: Double.random(in: -80...80),
                size: Double.random(in: 8...16),
                rotation: Double.random(in: 0...360),
                delay: Double.random(in: 0...3)
            )
        }
    }
    
    private func startLeafAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            for index in leaves.indices {
                let leafDelay = leaves[index].delay
                let leafAnimation = Animation.easeInOut(duration: 2.0).delay(leafDelay)
                
                withAnimation(leafAnimation) {
                    leaves[index].y += 2
                    leaves[index].rotation += 5
                    
                    // Reset leaf position when it falls too far
                    if leaves[index].y > 100 {
                        leaves[index].y = -80
                        leaves[index].x = Double.random(in: -60...60)
                    }
                }
            }
        }
    }
}

// MARK: - Floating Leaf Model
struct FloatingLeaf {
    let id: Int
    var x: Double
    var y: Double
    let size: Double
    var rotation: Double
    let delay: Double
}

// MARK: - Floating Leaf View
struct FloatingLeafView: View {
    let leaf: FloatingLeaf
    
    var body: some View {
        let leafGradient = LinearGradient(
            gradient: Gradient(colors: [.green, .yellow, .orange]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        let leafPosition = CGPoint(x: leaf.x + 110, y: leaf.y + 160)
        
        Image(systemName: "leaf.fill")
            .font(.system(size: leaf.size))
            .foregroundStyle(leafGradient)
            .rotationEffect(.degrees(leaf.rotation))
            .position(leafPosition)
            .shadow(color: .green.opacity(0.3), radius: 3, x: 1, y: 1)
    }
}

// MARK: - Zen Stone Garden View
struct ZenStoneGardenView: View {
    @State private var waveAnimation: Double = 0
    @State private var stoneRotation: Double = 0
    @State private var rippleEffect: Bool = false
    
    var body: some View {
        ZStack {
            // Sand base with wave patterns
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.gray.opacity(0.7),
                                Color.brown.opacity(0.5),
                                Color.white.opacity(0.3)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 180, height: 120)
                
                // Sand wave patterns
                ForEach(0..<8, id: \.self) { index in
                    WavePattern(
                        waveOffset: waveAnimation + Double(index) * 20,
                        amplitude: 3.0,
                        frequency: 0.1
                    )
                    .stroke(.white.opacity(0.4), lineWidth: 1)
                    .frame(width: 160, height: 100)
                    .offset(y: CGFloat(index) * -8)
                }
            }
            
            // Zen stones
            HStack(spacing: 20) {
                ForEach(0..<3, id: \.self) { index in
                    ZenStone(
                        size: CGSize(width: 25 + index * 5, height: 15 + index * 3),
                        rotation: stoneRotation + Double(index) * 30,
                        color: stoneColors[index % stoneColors.count]
                    )
                }
            }
            .offset(y: -10)
            
            // Water ripple effects
            if rippleEffect {
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .stroke(.blue.opacity(0.3), lineWidth: 1)
                        .frame(width: 40 + CGFloat(index) * 20, height: 40 + CGFloat(index) * 20)
                        .scaleEffect(rippleEffect ? 1.5 : 0.5)
                        .opacity(rippleEffect ? 0 : 0.7)
                        .animation(.easeOut(duration: 2.0).delay(Double(index) * 0.3), value: rippleEffect)
                }
            }
        }
        .onAppear {
            startZenAnimations()
        }
    }
    
    private let stoneColors: [Color] = [.gray, .brown, Color.gray.opacity(0.8)]
    
    private func startZenAnimations() {
        // Wave animation
        withAnimation(.linear(duration: 8.0).repeatForever(autoreverses: false)) {
            waveAnimation = 360
        }
        
        // Stone rotation
        withAnimation(.easeInOut(duration: 10.0).repeatForever(autoreverses: true)) {
            stoneRotation = 15
        }
        
        // Ripple effect
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
            withAnimation {
                rippleEffect.toggle()
            }
        }
    }
}

// MARK: - Wave Pattern Shape
struct WavePattern: Shape {
    let waveOffset: Double
    let amplitude: Double
    let frequency: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let midHeight = height / 2
        
        path.move(to: CGPoint(x: 0, y: midHeight))
        
        for x in stride(from: 0, through: width, by: 2) {
            let y = midHeight + amplitude * sin((x * frequency) + (waveOffset * .pi / 180))
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        return path
    }
}

// MARK: - Zen Stone View
struct ZenStone: View {
    let size: CGSize
    let rotation: Double
    let color: Color
    
    var body: some View {
        Ellipse()
            .fill(
                RadialGradient(
                    gradient: Gradient(colors: [
                        color.opacity(0.9),
                        color.opacity(0.6),
                        color.opacity(0.8)
                    ]),
                    center: .topLeading,
                    startRadius: 5,
                    endRadius: 20
                )
            )
            .frame(width: size.width, height: size.height)
            .overlay {
                Ellipse()
                    .stroke(.white.opacity(0.3), lineWidth: 1)
            }
            .rotationEffect(.degrees(rotation))
            .shadow(color: .black.opacity(0.3), radius: 3, x: 1, y: 1)
    }
}

// MARK: - Zen Garden Background View
struct ZenGardenBackgroundView: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            // Bamboo stalks in background
            ForEach(0..<8, id: \.self) { index in
                BambooStalk(
                    height: CGFloat.random(in: 100...200),
                    delay: Double(index) * 0.5
                )
                .position(
                    x: CGFloat.random(in: 300...450),
                    y: CGFloat.random(in: 100...350)
                )
            }
            
            // Floating petals
            ForEach(0..<10, id: \.self) { index in
                FloatingPetal(
                    color: petalColors.randomElement() ?? .pink,
                    size: CGFloat.random(in: 8...16),
                    delay: Double(index) * 0.4
                )
                .position(
                    x: CGFloat.random(in: 100...400),
                    y: CGFloat.random(in: 50...300)
                )
            }
        }
        .onAppear {
            animate = true
        }
    }
    
    private let petalColors: [Color] = [
        .pink, .white, Color.pink.opacity(0.7), .purple.opacity(0.5)
    ]
}

// MARK: - Bamboo Stalk View
struct BambooStalk: View {
    let height: CGFloat
    let delay: Double
    @State private var sway: Double = 0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        .green.opacity(0.8),
                        .green.opacity(0.5)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(width: 8, height: height)
            .overlay {
                // Bamboo segments
                VStack(spacing: height/6) {
                    ForEach(0..<Int(height/30), id: \.self) { _ in
                        Rectangle()
                            .fill(.green.opacity(0.9))
                            .frame(height: 2)
                    }
                }
            }
            .rotation3DEffect(
                .degrees(sway),
                axis: (x: 0, y: 0, z: 1)
            )
            .onAppear {
                withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true).delay(delay)) {
                    sway = 8
                }
            }
    }
}

// MARK: - Floating Petal View
struct FloatingPetal: View {
    let color: Color
    let size: CGFloat
    let delay: Double
    @State private var offsetY: Double = 0
    @State private var rotation: Double = 0
    @State private var opacity: Double = 0.8
    
    var body: some View {
        Image(systemName: "oval.fill")
            .font(.system(size: size))
            .foregroundStyle(color)
            .rotationEffect(.degrees(rotation))
            .offset(y: offsetY)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeInOut(duration: 4.0).repeatForever(autoreverses: true).delay(delay)) {
                    offsetY = 50
                    rotation = 360
                    opacity = 0.3
                }
            }
    }
}

// MARK: - Zen Game Features View
struct ZenGameFeaturesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "sparkles")
                    .font(.title3)
                    .foregroundStyle(.green)
                
                Text("Game Features:")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.primary)
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                FeatureCard(
                    icon: "leaf.fill",
                    title: "Mindful Training",
                    description: "Meditation-based exercises",
                    color: .green
                )
                
                FeatureCard(
                    icon: "heart.fill",
                    title: "Stress Relief",
                    description: "Calming environment",
                    color: .blue
                )
                
                FeatureCard(
                    icon: "lungs.fill",
                    title: "Breathing Exercise",
                    description: "Guided relaxation",
                    color: .purple
                )
                
                FeatureCard(
                    icon: "figure.mind.and.body",
                    title: "Recovery Support",
                    description: "Post-stroke therapy",
                    color: .orange
                )
            }
        }
    }
}

// MARK: - Zen Game Content Overlay
struct ZenGameContentOverlay: View {
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
                                    gradient: Gradient(colors: [.green, .blue]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                style: StrokeStyle(lineWidth: 8, lineCap: .round)
                            )
                            .frame(width: 80, height: 80)
                            .rotationEffect(.degrees(-90))
                    }
                    
                    Text("Loading Zen Garden...")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    
                    Text("Preparing your peaceful journey")
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
    ZenGardenView(showZenGarden: .constant(true))
}

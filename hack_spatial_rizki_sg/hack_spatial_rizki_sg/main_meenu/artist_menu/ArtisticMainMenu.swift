import SwiftUI
import RealityKit
import RealityKitContent

struct ArtisticModeView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedMode: ArtMode = .freeExpression
    @State private var selectedColor: Color = .blue
    @State private var brushSize: CGFloat = 20
    @State private var drawingPaths: [DrawingPath] = []
    @State private var currentPath: DrawingPath?
    @State private var canvasRotation: Double = 0
    @State private var showColorPalette = true
    @State private var showShapeLibrary = false
    @State private var selectedShape: ShapeType = .circle
    @State private var capturedShapes: [CapturedShape] = []
    @State private var animationPhase: CGFloat = 0
    @State private var particlePositions: [CGPoint] = []
    @State private var therapyScore: Int = 0
    @State private var showTherapyInstructions = false
    @State private var currentTherapyTask: TherapyTask?
    @State private var taskCompleted = false
    @State private var breathingPhase: CGFloat = 1.0
    @Binding var showArtistMode: Bool
    
    enum ArtMode: String, CaseIterable {
        case freeExpression = "Free Expression"
        case guidedTherapy = "Guided Therapy"
        case shapeMatching = "Shape Matching"
        case colorTherapy = "Color Therapy"
        
        var icon: String {
            switch self {
            case .freeExpression: return "paintbrush.fill"
            case .guidedTherapy: return "heart.fill"
            case .shapeMatching: return "square.on.circle.fill"
            case .colorTherapy: return "paintpalette.fill"
            }
        }
    }
    
    enum ShapeType: String, CaseIterable {
        case circle = "Circle"
        case square = "Square"
        case triangle = "Triangle"
        case star = "Star"
        case heart = "Heart"
        
        var systemImage: String {
            switch self {
            case .circle: return "circle.fill"
            case .square: return "square.fill"
            case .triangle: return "triangle.fill"
            case .star: return "star.fill"
            case .heart: return "heart.fill"
            }
        }
    }
    
    let colorPalette: [Color] = [
        .red, .orange, .yellow, .green, .mint, .teal,
        .cyan, .blue, .indigo, .purple, .pink, .brown
    ]
    
    let therapeuticColors: [String: Color] = [
        "Calming Blue": Color(red: 0.4, green: 0.6, blue: 0.9),
        "Energizing Orange": Color(red: 1.0, green: 0.6, blue: 0.2),
        "Grounding Green": Color(red: 0.3, green: 0.7, blue: 0.4),
        "Peaceful Purple": Color(red: 0.6, green: 0.4, blue: 0.8),
        "Joyful Yellow": Color(red: 1.0, green: 0.9, blue: 0.3)
    ]
    
    var body: some View {
        ZStack {
            // Dynamic gradient background
            LinearGradient(
                colors: [
                    Color(red: 0.95, green: 0.95, blue: 1.0),
                    Color(red: 0.9, green: 0.92, blue: 0.98),
                    selectedColor.opacity(0.1)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 1.0), value: selectedColor)
            
            // Animated background particles
            GeometryReader { geometry in
                ForEach(0..<15, id: \.self) { index in
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    selectedColor.opacity(0.3),
                                    selectedColor.opacity(0.05)
                                ],
                                center: .center,
                                startRadius: 5,
                                endRadius: 20
                            )
                        )
                        .frame(width: CGFloat.random(in: 20...60))
                        .position(
                            x: particlePositions[safe: index]?.x ?? CGFloat.random(in: 0...geometry.size.width),
                            y: particlePositions[safe: index]?.y ?? CGFloat.random(in: 0...geometry.size.height)
                        )
                        .opacity(0.6)
                        .animation(
                            Animation.easeInOut(duration: Double.random(in: 4...8))
                                .repeatForever(autoreverses: true),
                            value: animationPhase
                        )
                        .scaleEffect(animationPhase)
                }
            }
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    Button(action: {
                        showArtistMode = false
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
                        .background(
                            LinearGradient(
                                colors: [selectedColor.opacity(0.7), selectedColor.opacity(0.5)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(25)
                    }
                    
                    Spacer()
                    
                    // Mode Selector
                    HStack(spacing: 15) {
                        ForEach(ArtMode.allCases, id: \.self) { mode in
                            Button(action: {
                                withAnimation(.spring()) {
                                    selectedMode = mode
                                    if mode == .guidedTherapy {
                                        startTherapySession()
                                    }
                                }
                            }) {
                                VStack(spacing: 5) {
                                    Image(systemName: mode.icon)
                                        .font(.title2)
                                    Text(mode.rawValue)
                                        .font(.caption)
                                }
                                .foregroundColor(selectedMode == mode ? .white : .primary)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 10)
                                .background(
                                    selectedMode == mode ?
                                    LinearGradient(
                                        colors: [selectedColor, selectedColor.opacity(0.7)],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    ) :
                                    LinearGradient(
                                        colors: [Color.white.opacity(0.9), Color.white.opacity(0.7)],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .cornerRadius(15)
                                .shadow(radius: selectedMode == mode ? 5 : 2)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.horizontal, 40)
                .padding(.top, 20)
                
                // Main Content Area
                HStack(spacing: 30) {
                    // Tools Panel
                    VStack(spacing: 20) {
                        // Color Palette
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Colors")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], spacing: 10) {
                                ForEach(colorPalette, id: \.self) { color in
                                    Button(action: {
                                        withAnimation(.spring()) {
                                            selectedColor = color
                                        }
                                    }) {
                                        Circle()
                                            .fill(color)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.white, lineWidth: selectedColor == color ? 3 : 0)
                                            )
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(selectedColor == color ? 1.1 : 1.0)
                                            .shadow(radius: selectedColor == color ? 5 : 2)
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(20)
                        
                        // Brush Controls
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Brush Size")
                                .font(.headline)
                            
                            Slider(value: $brushSize, in: 5...50)
                                .accentColor(selectedColor)
                            
                            // Preview
                            Circle()
                                .fill(selectedColor)
                                .frame(width: brushSize, height: brushSize)
                                .animation(.easeInOut, value: brushSize)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(20)
                        
                        // Shape Tools
                        if selectedMode == .shapeMatching {
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Shapes")
                                    .font(.headline)
                                
                                ForEach(ShapeType.allCases, id: \.self) { shape in
                                    Button(action: {
                                        withAnimation {
                                            selectedShape = shape
                                        }
                                    }) {
                                        HStack {
                                            Image(systemName: shape.systemImage)
                                                .font(.title2)
                                            Text(shape.rawValue)
                                                .font(.caption)
                                        }
                                        .foregroundColor(selectedShape == shape ? .white : .primary)
                                        .frame(maxWidth: .infinity)
                                        .padding(10)
                                        .background(
                                            selectedShape == shape ?
                                            selectedColor : Color.gray.opacity(0.2)
                                        )
                                        .cornerRadius(10)
                                    }
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(20)
                        }
                        
                        Spacer()
                    }
                    .frame(width: 250)
                    
                    // Canvas Area
                    ZStack {
                        // Canvas Background
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.white)
                            .shadow(radius: 10)
                        
                        // Drawing Canvas
                        Canvas { context, size in
                            // Draw all paths
                            for path in drawingPaths {
                                context.stroke(
                                    path.path,
                                    with: .color(path.color),
                                    lineWidth: path.lineWidth
                                )
                            }
                            
                            // Draw current path
                            if let currentPath = currentPath {
                                context.stroke(
                                    currentPath.path,
                                    with: .color(currentPath.color),
                                    lineWidth: currentPath.lineWidth
                                )
                            }
                            
                            // Draw shapes for shape matching mode
                            for shape in capturedShapes {
                                drawShape(shape, in: context, size: size)
                            }
                        }
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    if currentPath == nil {
                                        currentPath = DrawingPath(
                                            color: selectedColor,
                                            lineWidth: brushSize
                                        )
                                    }
                                    currentPath?.path.addLine(to: value.location)
                                }
                                .onEnded { _ in
                                    if let path = currentPath {
                                        drawingPaths.append(path)
                                        currentPath = nil
                                        
                                        // Check therapy task completion
                                        if selectedMode == .guidedTherapy {
                                            checkTherapyProgress()
                                        }
                                    }
                                }
                        )
                        .rotation3DEffect(
                            .degrees(canvasRotation),
                            axis: (x: 0, y: 1, z: 0)
                        )
                        
                        // Therapy Mode Overlay
                        if selectedMode == .guidedTherapy, let task = currentTherapyTask {
                            VStack {
                                Spacer()
                                
                                VStack(spacing: 10) {
                                    Text("Task: \(task.instruction)")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    if task.showBreathing {
                                        BreathingGuide(phase: $breathingPhase)
                                            .frame(height: 60)
                                    }
                                    
                                    HStack {
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(.red)
                                        Text("Therapy Score: \(therapyScore)")
                                            .font(.subheadline)
                                    }
                                }
                                .padding()
                                .background(Color.white.opacity(0.95))
                                .cornerRadius(20)
                                .padding()
                            }
                        }
                        
                        // Success Animation
                        if taskCompleted {
                            VStack {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 80))
                                    .foregroundColor(.yellow)
                                    .symbolEffect(.bounce)
                                
                                Text("Great Job!")
                                    .font(.title.bold())
                                    .foregroundColor(.primary)
                            }
                            .padding(40)
                            .background(Color.white.opacity(0.95))
                            .cornerRadius(30)
                            .transition(.scale.combined(with: .opacity))
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    // Right Panel - Therapy Tools
                    if selectedMode == .colorTherapy {
                        VStack(spacing: 20) {
                            Text("Therapeutic Colors")
                                .font(.headline)
                            
                            ForEach(therapeuticColors.sorted(by: { $0.key < $1.key }), id: \.key) { name, color in
                                Button(action: {
                                    withAnimation(.spring()) {
                                        selectedColor = color
                                        therapyScore += 5
                                    }
                                }) {
                                    VStack(spacing: 8) {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(
                                                LinearGradient(
                                                    colors: [color, color.opacity(0.7)],
                                                    startPoint: .top,
                                                    endPoint: .bottom
                                                )
                                            )
                                            .frame(height: 60)
                                        
                                        Text(name)
                                            .font(.caption)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                                .frame(width: 120)
                            }
                            
                            Spacer()
                            
                            // Mood Tracker
                            VStack(spacing: 15) {
                                Text("How are you feeling?")
                                    .font(.headline)
                                
                                HStack(spacing: 15) {
                                    ForEach(["😊", "😌", "😔", "😴", "🤗"], id: \.self) { emoji in
                                        Button(action: {
                                            therapyScore += 10
                                            withAnimation {
                                                taskCompleted = true
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                withAnimation {
                                                    taskCompleted = false
                                                }
                                            }
                                        }) {
                                            Text(emoji)
                                                .font(.system(size: 40))
                                                .scaleEffect(1.0)
                                                .animation(.spring(), value: taskCompleted)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(20)
                        }
                        .frame(width: 200)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(25)
                    }
                }
                .padding(.horizontal, 40)
                
                // Bottom Controls
                HStack(spacing: 30) {
                    Button(action: { clearCanvas() }) {
                        Label("Clear Canvas", systemImage: "trash")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 15)
                            .background(
                                LinearGradient(
                                    colors: [.red.opacity(0.7), .orange.opacity(0.7)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(25)
                    }
                    
                    Button(action: { saveArtwork() }) {
                        Label("Save Artwork", systemImage: "square.and.arrow.down")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 15)
                            .background(
                                LinearGradient(
                                    colors: [.green, .mint],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(25)
                    }
                    
                    if selectedMode == .guidedTherapy {
                        Button(action: { startTherapySession() }) {
                            Label("New Task", systemImage: "arrow.clockwise")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 25)
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
                    }
                }
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            setupAnimations()
        }
    }
    
    // MARK: - Helper Functions
    
    func setupAnimations() {
        // Setup particle positions
        // Using fixed size for visionOS compatibility
        particlePositions = (0..<15).map { _ in
            CGPoint(
                x: CGFloat.random(in: 0...1200),
                y: CGFloat.random(in: 0...800)
            )
        }
        
        // Animate particles
        withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
            animationPhase = 1.2
        }
        
        // Breathing animation for therapy
        withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
            breathingPhase = 2.0
        }
    }
    
    func clearCanvas() {
        withAnimation {
            drawingPaths.removeAll()
            capturedShapes.removeAll()
            currentPath = nil
        }
    }
    
    func saveArtwork() {
        // Implement save functionality
        therapyScore += 20
        withAnimation {
            taskCompleted = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                taskCompleted = false
            }
        }
    }
    
    func startTherapySession() {
        let tasks = [
            TherapyTask(
                instruction: "Draw a circle using calming blue",
                targetColor: .blue,
                targetShape: .circle,
                showBreathing: true
            ),
            TherapyTask(
                instruction: "Create wavy lines while breathing deeply",
                targetColor: .green,
                targetShape: nil,
                showBreathing: true
            ),
            TherapyTask(
                instruction: "Draw a happy sun with warm colors",
                targetColor: .yellow,
                targetShape: .star,
                showBreathing: false
            ),
            TherapyTask(
                instruction: "Paint your current mood using any color",
                targetColor: nil,
                targetShape: nil,
                showBreathing: true
            )
        ]
        
        currentTherapyTask = tasks.randomElement()
        showTherapyInstructions = true
    }
    
    func checkTherapyProgress() {
        if let task = currentTherapyTask {
            // Simple validation
            if drawingPaths.count > 0 {
                therapyScore += 15
                withAnimation {
                    taskCompleted = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        taskCompleted = false
                    }
                    startTherapySession()
                }
            }
        }
    }
    
    func drawShape(_ shape: CapturedShape, in context: GraphicsContext, size: CGSize) {
        let path = Path { p in
            switch shape.type {
            case .circle:
                p.addEllipse(in: CGRect(
                    x: shape.position.x - shape.size/2,
                    y: shape.position.y - shape.size/2,
                    width: shape.size,
                    height: shape.size
                ))
            case .square:
                p.addRect(CGRect(
                    x: shape.position.x - shape.size/2,
                    y: shape.position.y - shape.size/2,
                    width: shape.size,
                    height: shape.size
                ))
            case .triangle:
                p.move(to: CGPoint(x: shape.position.x, y: shape.position.y - shape.size/2))
                p.addLine(to: CGPoint(x: shape.position.x - shape.size/2, y: shape.position.y + shape.size/2))
                p.addLine(to: CGPoint(x: shape.position.x + shape.size/2, y: shape.position.y + shape.size/2))
                p.closeSubpath()
            case .star:
                // Simplified star
                for i in 0..<5 {
                    let angle = (CGFloat(i) * .pi * 2 / 5) - .pi / 2
                    let point = CGPoint(
                        x: shape.position.x + cos(angle) * shape.size/2,
                        y: shape.position.y + sin(angle) * shape.size/2
                    )
                    if i == 0 {
                        p.move(to: point)
                    } else {
                        p.addLine(to: point)
                    }
                }
                p.closeSubpath()
            case .heart:
                // Simplified heart shape
                p.move(to: CGPoint(x: shape.position.x, y: shape.position.y + shape.size/4))
                p.addCurve(
                    to: CGPoint(x: shape.position.x - shape.size/2, y: shape.position.y - shape.size/4),
                    control1: CGPoint(x: shape.position.x, y: shape.position.y),
                    control2: CGPoint(x: shape.position.x - shape.size/2, y: shape.position.y - shape.size/2)
                )
                p.addCurve(
                    to: CGPoint(x: shape.position.x, y: shape.position.y + shape.size/2),
                    control1: CGPoint(x: shape.position.x - shape.size/2, y: shape.position.y),
                    control2: CGPoint(x: shape.position.x, y: shape.position.y + shape.size/4)
                )
            }
        }
        
        context.fill(path, with: .color(shape.color.opacity(0.5)))
        context.stroke(path, with: .color(shape.color), lineWidth: 2)
    }
}

// MARK: - Supporting Views

struct BreathingGuide: View {
    @Binding var phase: CGFloat
    
    var body: some View {
        HStack(spacing: 20) {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [.blue.opacity(0.6), .blue.opacity(0.2)],
                        center: .center,
                        startRadius: 5,
                        endRadius: 30
                    )
                )
                .frame(width: 40 * phase, height: 40 * phase)
                .overlay(
                    Text("Breathe")
                        .font(.caption)
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading, spacing: 5) {
                Text(phase < 1.5 ? "Inhale slowly..." : "Exhale gently...")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                ProgressView(value: phase, total: 2.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
            }
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(15)
    }
}

// MARK: - Data Models

struct DrawingPath: Identifiable {
    let id = UUID()
    var path = Path()
    let color: Color
    let lineWidth: CGFloat
}

struct CapturedShape: Identifiable {
    let id = UUID()
    let type: ArtisticModeView.ShapeType
    let position: CGPoint
    let size: CGFloat
    let color: Color
}

struct TherapyTask {
    let instruction: String
    let targetColor: Color?
    let targetShape: ArtisticModeView.ShapeType?
    let showBreathing: Bool
}

// Safe array subscript
extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}

#Preview {
    ArtisticModeView(showArtistMode : .constant(true))
}

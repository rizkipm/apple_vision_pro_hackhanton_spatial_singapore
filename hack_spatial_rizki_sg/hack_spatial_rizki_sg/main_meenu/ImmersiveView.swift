import SwiftUI
import RealityKit

struct BallData {
    let entity: Entity
    let id: UUID
    var isFrozen: Bool = false
}

struct ImmersiveView: View {
    @Environment(AppModel.self) private var appModel
    @State private var throwTimer: Timer?
    @State private var rootEntity = Entity()
    @State private var activeBalls: [BallData] = []
    @State private var ballTimers: [UUID: Timer] = [:]
    @State private var targetDistance: Int = [6, 7, 8, 9, 10].randomElement() ?? 8
    @State private var showPrompt: Bool = true
    @State private var showScore: Bool = false
    @State private var lastResultDistance: Float = 0.0
    @State private var lastScore: Int = 0

    var body: some View {
        ZStack {
            RealityView { content in
                content.add(rootEntity)
                
                // Setup lighting
                let ambientLight = Entity()
                ambientLight.components[DirectionalLightComponent.self] = DirectionalLightComponent(
                    color: .white,
                    intensity: 500
                )
                ambientLight.look(at: [0, 3, 3], from: [0, 5, 5], relativeTo: nil)
                rootEntity.addChild(ambientLight)
                
                // Create distance markers
                let lineLength: Float = 6.0
                let lineY: Float = 0.20
                for distance in 1...15 {
                    let markerEntity = Entity()
                    
                    let lineColor: UIColor
                    if distance <= 5 {
                        lineColor = .systemGreen
                    } else if distance <= 10 {
                        lineColor = .systemOrange
                    } else {
                        lineColor = .systemRed
                    }
                    
                    let lineEntity = ModelEntity(
                        mesh: .generateCylinder(height: lineLength, radius: 0.008),
                        materials: [SimpleMaterial(
                            color: lineColor,
                            roughness: 0.3,
                            isMetallic: false
                        )]
                    )
                    lineEntity.orientation = simd_quatf(angle: .pi/2, axis: SIMD3<Float>(0,0,1))
                    lineEntity.position = SIMD3<Float>(0, lineY, -Float(distance))
                    markerEntity.addChild(lineEntity)
                    
                    let textMesh = MeshResource.generateText(
                        "\(distance)m",
                        extrusionDepth: 0.008,
                        font: .systemFont(ofSize: 0.13, weight: .bold)
                    )
                    let textEntity = ModelEntity(
                        mesh: textMesh,
                        materials: [SimpleMaterial(color: .white, isMetallic: false)]
                    )
                    textEntity.position = SIMD3<Float>(0, lineY + 0.08, -Float(distance))
                    markerEntity.addChild(textEntity)
                    
                    rootEntity.addChild(markerEntity)
                }
                
                // Danger zone
                let dangerMarker = Entity()
                let dangerLine = ModelEntity(
                    mesh: .generateCylinder(height: lineLength, radius: 0.010),
                    materials: [SimpleMaterial(color: .systemRed, roughness: 0.3, isMetallic: false)]
                )
                dangerLine.orientation = simd_quatf(angle: .pi/2, axis: SIMD3<Float>(0,0,1))
                dangerLine.position = SIMD3<Float>(0, lineY, -0.5)
                dangerMarker.addChild(dangerLine)
                
                let dangerTextMesh = MeshResource.generateText(
                    "DANGER! 0.5m",
                    extrusionDepth: 0.01,
                    font: .systemFont(ofSize: 0.13, weight: .bold)
                )
                let dangerText = ModelEntity(
                    mesh: dangerTextMesh,
                    materials: [SimpleMaterial(color: .systemRed, isMetallic: false)]
                )
                dangerText.position = SIMD3<Float>(0, lineY + 0.08, -0.5)
                dangerMarker.addChild(dangerText)
                rootEntity.addChild(dangerMarker)
                
                // Create 3D challenge text positioned at 8m back, 3m high
                let challengeEntity = Entity()
                challengeEntity.name = "challengeText"
                
                let instructionMesh = MeshResource.generateText(
                    "🎯 Try to stop the ball as close as possible to",
                    extrusionDepth: 0.01,
                    font: .systemFont(ofSize: 0.15, weight: .bold)
                )
                
                let instructionTextEntity = ModelEntity(
                    mesh: instructionMesh,
                    materials: [SimpleMaterial(color: .white, isMetallic: false)]
                )
                
                instructionTextEntity.position = SIMD3<Float>(0, 3.0, -8.0)
                challengeEntity.addChild(instructionTextEntity)
                
                let targetMesh = MeshResource.generateText(
                    "\(targetDistance)m",
                    extrusionDepth: 0.015,
                    font: .systemFont(ofSize: 0.3, weight: .heavy)
                )
                
                let targetTextEntity = ModelEntity(
                    mesh: targetMesh,
                    materials: [SimpleMaterial(color: .systemCyan, isMetallic: false)]
                )
                
                targetTextEntity.name = "targetNumber"
                targetTextEntity.position = SIMD3<Float>(0, 2.5, -8.0)
                challengeEntity.addChild(targetTextEntity)
                
                rootEntity.addChild(challengeEntity)
                
                // Start the ball throwing
                let interval = Double.random(in: 5.0...8.0)
                throwTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
                    self.throwBall()
                    self.scheduleNextThrow()
                }
                
            } update: { content in
                if let idToFreeze = appModel.freezeRequestBallID {
                    let resultDistance = freezeBall(withID: idToFreeze)
                    appModel.freezeBall(id: idToFreeze)
                    if let resultDistance = resultDistance {
                        scoreUser(distance: resultDistance)
                    }
                }
            }
            .gesture(
                SpatialTapGesture()
                    .onEnded { _ in
                        print("👁️ Vision Pro spatial tap detected - freezing oldest ball!")
                        if let first = oldestUnfrozenBall() {
                            let resultDistance = freezeBall(withID: first.id)
                            appModel.freezeBall(id: first.id)
                            if let resultDistance = resultDistance {
                                scoreUser(distance: resultDistance)
                            }
                        }
                    }
            )
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        print("📱 Regular tap detected - freezing oldest ball!")
                        if let first = oldestUnfrozenBall() {
                            let resultDistance = freezeBall(withID: first.id)
                            appModel.freezeBall(id: first.id)
                            if let resultDistance = resultDistance {
                                scoreUser(distance: resultDistance)
                            }
                        }
                    }
            )
            .onAppear {
                appModel.immersiveSpaceState = .open
            }
            .onDisappear {
                stopThrowingBalls()
                appModel.immersiveSpaceState = .closed
            }
            
            // --- Score display only ---
            VStack {
                Spacer()
                if showScore {
                    VStack(spacing: 8) {
                        Text("You stopped the ball at")
                            .font(.headline)
                        Text(String(format: "%.2f m", lastResultDistance))
                            .font(.system(size: 38, weight: .heavy, design: .rounded))
                            .foregroundColor(.green)
                        Text("Score: \(lastScore)")
                            .font(.title2)
                            .foregroundColor(lastScore == 100 ? .green : (lastScore >= 75 ? .orange : .red))
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .padding(.bottom, 50)
                }
            }
            .animation(.spring, value: showScore)
            .padding()
        }
    }

    func oldestUnfrozenBall() -> BallData? {
        activeBalls.first { !$0.isFrozen }
    }

    func scheduleNextThrow() {
        let interval = Double.random(in: 5.0...8.0)
        throwTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
            self.throwBall()
            self.scheduleNextThrow()
        }
    }

    func stopThrowingBalls() {
        throwTimer?.invalidate()
        throwTimer = nil
        for timer in ballTimers.values {
            timer.invalidate()
        }
        ballTimers.removeAll()
        for ball in activeBalls {
            ball.entity.removeFromParent()
        }
        activeBalls.removeAll()
    }

    func throwBall() {
        let id = UUID()
        let ballEntity = ModelEntity(
            mesh: .generateSphere(radius: 0.15),
            materials: [SimpleMaterial(
                color: UIColor.white,
                roughness: 0.9,
                isMetallic: false
            )]
        )
        ballEntity.name = "ball_\(id.uuidString)"
        let angle = Float.random(in: -Float.pi/6...Float.pi/6)
        let distance: Float = 15.0
        let startX = sin(angle) * distance
        let startY = Float.random(in: 1.2...2.2)
        let startZ = -cos(angle) * distance
        ballEntity.position = SIMD3<Float>(startX, startY, startZ)
        rootEntity.addChild(ballEntity)

        appModel.activeBallIDs.append(id)
        activeBalls.append(BallData(entity: ballEntity, id: id, isFrozen: false))
        
        // Start ball movement
        let totalTime: Float = 10.0
        let startTime = CFAbsoluteTimeGetCurrent()
        let startPos = SIMD3<Float>(startX, startY, startZ)
        let endPos = SIMD3<Float>(0, 1.65, 0.2)
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { timer in
            DispatchQueue.main.async {
                guard let idx = activeBalls.firstIndex(where: { $0.id == id }) else {
                    timer.invalidate()
                    ballTimers[id] = nil
                    return
                }
                if activeBalls[idx].isFrozen {
                    timer.invalidate()
                    ballTimers[id] = nil
                    return
                }
                let currentTime = CFAbsoluteTimeGetCurrent()
                let elapsedTime = Float(currentTime - startTime)
                let progress = min(elapsedTime / totalTime, 1.0)
                let currentPosition = SIMD3<Float>(
                    startPos.x + (endPos.x - startPos.x) * progress,
                    startPos.y + (endPos.y - startPos.y) * progress,
                    startPos.z + (endPos.z - startPos.z) * progress
                )
                ballEntity.position = currentPosition

                if currentPosition.z > 0.1 {
                    ballEntity.removeFromParent()
                    timer.invalidate()
                    ballTimers[id] = nil
                    activeBalls.removeAll { $0.id == id }
                    if let modelIdx = appModel.activeBallIDs.firstIndex(of: id) {
                        appModel.activeBallIDs.remove(at: modelIdx)
                    }
                    return
                }

                if progress >= 1.0 {
                    timer.invalidate()
                    ballTimers[id] = nil
                }
            }
        }
        ballTimers[id] = timer
    }

    func freezeBall(withID id: UUID) -> Float? {
        guard let idx = activeBalls.firstIndex(where: { $0.id == id }),
              !activeBalls[idx].isFrozen else { return nil }
        var ballData = activeBalls[idx]
        ballData.isFrozen = true
        if let timer = ballTimers[id] {
            timer.invalidate()
            ballTimers[id] = nil
        }
        if var model = ballData.entity.components[ModelComponent.self] {
            model.materials = [SimpleMaterial(
                color: .systemBlue,
                roughness: 0.9,
                isMetallic: false
            )]
            ballData.entity.components[ModelComponent.self] = model
        }
        let zDistance = abs(ballData.entity.position.z)
        
        // Add distance label directly here
        let distanceText = String(format: "%.2fm", zDistance)
        let textMesh = MeshResource.generateText(
            distanceText,
            extrusionDepth: 0.008,
            font: .systemFont(ofSize: 0.17, weight: .bold)
        )
        let textEntity = ModelEntity(
            mesh: textMesh,
            materials: [SimpleMaterial(color: .white, isMetallic: false)]
        )
        textEntity.position = SIMD3<Float>(0, 0.25, 0)
        ballData.entity.addChild(textEntity)
        
        activeBalls[idx] = ballData
        return zDistance
    }

    func scoreUser(distance: Float) {
        let target = Float(targetDistance)
        let error = abs(distance - target)
        let maxError: Float = 1.5
        let score = max(0, Int((1.0 - min(error, maxError) / maxError) * 100))
        lastResultDistance = distance
        lastScore = score
        showPrompt = false
        showScore = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.targetDistance = [6, 7, 8, 9, 10].randomElement() ?? 8
            self.showPrompt = true
            self.showScore = false
            
            // Update 3D target text inline
            if let challengeEntity = self.rootEntity.children.first(where: { $0.name == "challengeText" }),
               let oldTarget = challengeEntity.children.first(where: { $0.name == "targetNumber" }) {
                oldTarget.removeFromParent()
                
                let newTargetMesh = MeshResource.generateText(
                    "\(self.targetDistance)m",
                    extrusionDepth: 0.015,
                    font: .systemFont(ofSize: 0.3, weight: .heavy)
                )
                
                let newTargetText = ModelEntity(
                    mesh: newTargetMesh,
                    materials: [SimpleMaterial(color: .systemCyan, isMetallic: false)]
                )
                
                newTargetText.name = "targetNumber"
                newTargetText.position = SIMD3<Float>(0, 2.5, -8.0)
                challengeEntity.addChild(newTargetText)
            }
        }
    }
}

#Preview {
    ImmersiveView()
        .environment(AppModel())
}

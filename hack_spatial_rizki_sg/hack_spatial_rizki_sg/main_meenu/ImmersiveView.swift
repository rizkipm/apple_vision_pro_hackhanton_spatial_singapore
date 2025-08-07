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
    @State private var targetDistance: Int = [3, 4, 5, 6, 7].randomElement() ?? 5
    @State private var showPrompt: Bool = true
    @State private var showScore: Bool = false
    @State private var lastResultDistance: Float = 0.0
    @State private var lastScore: Int = 0

    var body: some View {
        ZStack {
            RealityView { content in
                content.add(rootEntity)
                setupScene()
                startThrowingBalls()
            } update: { content in
                if let idToFreeze = appModel.freezeRequestBallID {
                    let resultDistance = freezeBall(withID: idToFreeze)
                    appModel.freezeBall(id: idToFreeze)
                    if let resultDistance = resultDistance {
                        scoreUser(distance: resultDistance)
                    }
                }
            }
            .onTapGesture {
                if let first = oldestUnfrozenBall() {
                    let resultDistance = freezeBall(withID: first.id)
                    appModel.freezeBall(id: first.id)
                    if let resultDistance = resultDistance {
                        scoreUser(distance: resultDistance)
                    }
                }
            }
            .onAppear {
                appModel.immersiveSpaceState = .open
            }
            .onDisappear {
                stopThrowingBalls()
                appModel.immersiveSpaceState = .closed
            }
            
            // --- HUD overlay (prompt & score) ---
            VStack {
                if showPrompt {
                    Text("🎯 Try to stop the ball as close as possible to")
                        .font(.title3).bold()
                        .padding(.top, 60)
                    Text("\(targetDistance)m")
                        .font(.system(size: 48, weight: .heavy, design: .rounded))
                        .foregroundColor(.cyan)
                        .shadow(color: .cyan.opacity(0.4), radius: 6)
                    Text("Tap the FREEZE button at the right moment!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
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
                }
                Spacer()
            }
            .animation(.spring, value: showScore)
            .padding()
        }
    }

    private func oldestUnfrozenBall() -> BallData? {
        activeBalls.first { !$0.isFrozen }
    }

    // --- Distance Markers + Lighting (Low, Upright Labels, No Overlap) ---
    private func setupScene() {
        // Ambient lighting
        let ambientLight = Entity()
        ambientLight.components[DirectionalLightComponent.self] = DirectionalLightComponent(
            color: .white,
            intensity: 500
        )
        ambientLight.look(at: [0, 3, 3], from: [0, 5, 5], relativeTo: nil)
        rootEntity.addChild(ambientLight)
        
        // Markers low (e.g. y = 0.2) for floor reference, labels directly above each sphere
        for distance in 1...10 {
            let markerEntity = Entity()
            let sphereEntity = ModelEntity(
                mesh: .generateSphere(radius: 0.045),
                materials: [SimpleMaterial(
                    color: distance <= 5 ? UIColor.systemGreen : UIColor.systemOrange,
                    roughness: 0.6,
                    isMetallic: false
                )]
            )
            sphereEntity.position = SIMD3<Float>(0, 0.20, -Float(distance))
            markerEntity.addChild(sphereEntity)
            
            let textMesh = MeshResource.generateText(
                "\(distance)m",
                extrusionDepth: 0.008,
                font: .systemFont(ofSize: 0.13, weight: .heavy)
            )
            let textEntity = ModelEntity(
                mesh: textMesh,
                materials: [SimpleMaterial(
                    color: .white,
                    isMetallic: false
                )]
            )
            // Place directly above marker sphere, slight Z forward to prevent overlap
            textEntity.position = SIMD3<Float>(0, 0.09, 0.02)
            markerEntity.addChild(textEntity)
            rootEntity.addChild(markerEntity)
        }
        
        // "DANGER ZONE" marker at 0.5m
        let dangerMarker = Entity()
        let dangerSphere = ModelEntity(
            mesh: .generateSphere(radius: 0.055),
            materials: [SimpleMaterial(
                color: UIColor.systemRed,
                roughness: 0.3,
                isMetallic: false
            )]
        )
        dangerSphere.position = SIMD3<Float>(0, 0.20, -0.5)
        dangerMarker.addChild(dangerSphere)
        
        let dangerTextMesh = MeshResource.generateText(
            "DANGER! 0.5m",
            extrusionDepth: 0.01,
            font: .systemFont(ofSize: 0.13, weight: .bold)
        )
        let dangerText = ModelEntity(
            mesh: dangerTextMesh,
            materials: [SimpleMaterial(
                color: UIColor.systemRed,
                isMetallic: false
            )]
        )
        dangerText.position = SIMD3<Float>(0, 0.13, 0.02)
        dangerMarker.addChild(dangerText)
        rootEntity.addChild(dangerMarker)
    }

    // --- Ball Throwing Logic ---
    private func startThrowingBalls() {
        let interval = Double.random(in: 5.0...8.0)
        throwTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
            self.throwBall()
            self.scheduleNextThrow()
        }
    }

    private func scheduleNextThrow() {
        let interval = Double.random(in: 5.0...8.0)
        throwTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
            self.throwBall()
            self.scheduleNextThrow()
        }
    }

    private func stopThrowingBalls() {
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

    private func throwBall() {
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
        moveBallStraightLine(ballEntity: ballEntity, id: id, from: SIMD3<Float>(startX, startY, startZ), to: SIMD3<Float>(0, 1.65, 0.2))
    }

    private func moveBallStraightLine(ballEntity: Entity, id: UUID, from startPos: SIMD3<Float>, to endPos: SIMD3<Float>) {
        let totalTime: Float = 10.0
        let startTime = CFAbsoluteTimeGetCurrent()
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

                // Despawn if ball passes user (z > 0.1)
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

    /// Freezes ball and returns the ground distance to user (Z, positive)
    private func freezeBall(withID id: UUID) -> Float? {
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
        addDistanceLabel(to: ballData.entity, distance: zDistance)
        activeBalls[idx] = ballData
        return zDistance
    }

    private func addDistanceLabel(to ball: Entity, distance: Float) {
        let distanceText = String(format: "%.2fm", distance)
        let textMesh = MeshResource.generateText(
            distanceText,
            extrusionDepth: 0.008,
            font: .systemFont(ofSize: 0.17, weight: .bold)
        )
        let textEntity = ModelEntity(
            mesh: textMesh,
            materials: [SimpleMaterial(color: .white, isMetallic: false)]
        )
        // Above the ball
        textEntity.position = SIMD3<Float>(0, 0.25, 0)
        ball.addChild(textEntity)
    }

    /// Calculate score, show overlay, randomize next prompt
    private func scoreUser(distance: Float) {
        let target = Float(targetDistance)
        let error = abs(distance - target)
        let maxError: Float = 1.2
        let score = max(0, Int((1.0 - min(error, maxError) / maxError) * 100))
        lastResultDistance = distance
        lastScore = score
        showPrompt = false
        showScore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.targetDistance = [3, 4, 5, 6, 7].randomElement() ?? 5
            self.showPrompt = true
            self.showScore = false
        }
    }
}

#Preview {
    ImmersiveView()
        .environment(AppModel())
}

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
    @State private var targetDistance: Int = [3, 4, 5, 6, 7].randomElement() ?? 8
    @State private var showPrompt: Bool = true
    @State private var showScore: Bool = false
    @State private var lastResultDistance: Float = 0.0
    @State private var lastScore: Int = 0

    var body: some View {
        ZStack {
            RealityView { content, attachments in
                content.add(rootEntity)

                // --- Lighting ---
                let ambientLight = Entity()
                ambientLight.components[DirectionalLightComponent.self] = DirectionalLightComponent(
                    color: .white,
                    intensity: 500
                )
                ambientLight.look(at: [0, 3, 3], from: [0, 5, 5], relativeTo: nil)
                rootEntity.addChild(ambientLight)

                // --- Distance markers (LEFT↔RIGHT lines, original correct orientation) ---
                let lineLength: Float = 6.0
                let lineY: Float = 0.20
                for distance in 1...15 {
                    let marker = Entity()

                    let lineColor: UIColor =
                        distance <= 5 ? .systemGreen :
                        distance <= 10 ? .systemOrange : .systemRed

                    let line = ModelEntity(
                        mesh: .generateCylinder(height: lineLength, radius: 0.008),
                        materials: [SimpleMaterial(color: lineColor, roughness: 0.3, isMetallic: false)]
                    )
                    // Rotate around Z so cylinder runs along X (left↔right)
                    line.orientation = simd_quatf(angle: .pi/2, axis: SIMD3<Float>(0, 0, 1))
                    line.position = SIMD3<Float>(0, lineY, -Float(distance))
                    marker.addChild(line)

                    let textMesh = MeshResource.generateText(
                        "\(distance)m",
                        extrusionDepth: 0.008,
                        font: .systemFont(ofSize: 0.13, weight: .bold)
                    )
                    let text = ModelEntity(
                        mesh: textMesh,
                        materials: [SimpleMaterial(color: .white, isMetallic: false)]
                    )
                    // Centered above the line
                    text.position = SIMD3<Float>(0, lineY + 0.08, -Float(distance))
                    marker.addChild(text)

                    rootEntity.addChild(marker)
                }

                // --- Danger line at 0.5m (same orientation) ---
                let danger = Entity()
                let dangerLine = ModelEntity(
                    mesh: .generateCylinder(height: lineLength, radius: 0.010),
                    materials: [SimpleMaterial(color: .systemRed, roughness: 0.3, isMetallic: false)]
                )
                dangerLine.orientation = simd_quatf(angle: .pi/2, axis: SIMD3<Float>(0, 0, 1))
                dangerLine.position = SIMD3<Float>(0, lineY, -0.5)
                danger.addChild(dangerLine)

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
                danger.addChild(dangerText)
                rootEntity.addChild(danger)

                // --- Attachments (prompt & score) ---
                if let challengeAttachment = attachments.entity(for: "challengeText") {
                    challengeAttachment.position = SIMD3<Float>(0, 2.0, -2.0)
                    challengeAttachment.name = "challengeAttachment"
                    rootEntity.addChild(challengeAttachment)
                }
                if let scoreAttachment = attachments.entity(for: "scoreText") {
                    scoreAttachment.position = SIMD3<Float>(0, 1.5, -6.0)
                    scoreAttachment.name = "scoreAttachment"
                    rootEntity.addChild(scoreAttachment)
                }

                // --- Start throwing ---
                scheduleNextThrow()

            } update: { _, attachments in
                // Keep attachments put (optional)
                if let challenge = attachments.entity(for: "challengeText") {
                    challenge.position = SIMD3<Float>(0, 2.0, -2.0)
                }
                if let score = attachments.entity(for: "scoreText") {
                    score.position = SIMD3<Float>(0, 1.5, -6.0)
                }

                // 🔹 Consume freeze request from AppModel (button OR pinch/tap)
                if let idToFreeze = appModel.freezeRequestBallID {
                    if let resultDistance = freezeBall(withID: idToFreeze) {
                        appModel.freezeBall(id: idToFreeze)
                        scoreUser(distance: resultDistance)
                    } else {
                        // No-op but clear the request so we don't loop forever
                        appModel.freezeBall(id: idToFreeze)
                    }
                }
            } attachments: {
                // Prompt overlay
                Attachment(id: "challengeText") {
                    if showPrompt {
                        VStack(spacing: 16) {
                            Text("🎯 Try to stop the ball as close as possible to")
                                .font(.title2).fontWeight(.semibold).foregroundColor(.white)
                            Text("\(targetDistance)m")
                                .font(.system(size: 72, weight: .heavy, design: .rounded))
                                .foregroundColor(.cyan)
                                .shadow(color: .cyan.opacity(0.8), radius: 12)
                            Text("✋ Pinch (Vision Pro) or tap/click (Simulator) to freeze")
                                .font(.headline).foregroundColor(.white.opacity(0.9))
                        }
                        .padding(.horizontal, 40).padding(.vertical, 32)
                        .background {
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.black.opacity(0.85))
                                .stroke(.cyan.opacity(0.6), lineWidth: 2)
                                .shadow(color: .cyan.opacity(0.3), radius: 16)
                        }
                    }
                }
                // Score overlay
                Attachment(id: "scoreText") {
                    if showScore {
                        let tint: Color = (lastScore == 100 ? .green : (lastScore >= 75 ? .orange : .red))
                        VStack(spacing: 16) {
                            Text("🎯 You stopped the ball at")
                                .font(.title2).fontWeight(.semibold).foregroundColor(.white)
                            Text(String(format: "%.2f m", lastResultDistance))
                                .font(.system(size: 72, weight: .heavy, design: .rounded))
                                .foregroundColor(.green)
                                .shadow(color: .green.opacity(0.8), radius: 12)
                            Text("Score: \(lastScore)")
                                .font(.headline).fontWeight(.bold).foregroundColor(tint)
                        }
                        .padding(.horizontal, 40).padding(.vertical, 32)
                        .background {
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.black.opacity(0.85))
                                .stroke(tint.opacity(0.6), lineWidth: 2)
                                .shadow(color: tint.opacity(0.3), radius: 16)
                        }
                    }
                }
            }
            // ✅ Add pinch/tap gestures -> request freeze in AppModel
            .simultaneousGesture(
                SpatialTapGesture().onEnded { _ in
                    print("👆 SpatialTap (pinch) detected")
                    appModel.requestFreezeOldestBall()
                }
            )
            .simultaneousGesture(
                TapGesture().onEnded {
                    print("👆 Tap detected")
                    appModel.requestFreezeOldestBall()
                }
            )
            .onAppear { appModel.immersiveSpaceState = .open }
            .onDisappear {
                stopThrowingBalls()
                appModel.immersiveSpaceState = .closed
            }

            // Subtle background dimming (optional)
            Rectangle().fill(.black.opacity(0.15)).ignoresSafeArea().allowsHitTesting(false)
        }
    }

    // MARK: - Throwing
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
        for t in ballTimers.values { t.invalidate() }
        ballTimers.removeAll()
        for b in activeBalls { b.entity.removeFromParent() }
        activeBalls.removeAll()
    }

    func throwBall() {
        let id = UUID()
        let ball = ModelEntity(
            mesh: .generateSphere(radius: 0.15),
            materials: [SimpleMaterial(color: UIColor.white, roughness: 0.9, isMetallic: false)]
        )
        // Spawn somewhere in front
        let angle = Float.random(in: -Float.pi/6...Float.pi/6)
        let dist: Float = 15.0
        let startX = sin(angle) * dist
        let startY = Float.random(in: 1.2...2.2)
        let startZ = -cos(angle) * dist
        ball.position = SIMD3<Float>(startX, startY, startZ)
        rootEntity.addChild(ball)

        appModel.activeBallIDs.append(id)
        activeBalls.append(BallData(entity: ball, id: id, isFrozen: false))

        // Move toward the user
        let totalTime: Float = 10.0
        let startTime = CFAbsoluteTimeGetCurrent()
        let startPos = SIMD3<Float>(startX, startY, startZ)
        let endPos = SIMD3<Float>(0, 1.65, 0.2)

        let t = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { timer in
            DispatchQueue.main.async {
                guard let idx = activeBalls.firstIndex(where: { $0.id == id }) else {
                    timer.invalidate(); ballTimers[id] = nil; return
                }
                if activeBalls[idx].isFrozen {
                    timer.invalidate(); ballTimers[id] = nil; return
                }
                let elapsed = Float(CFAbsoluteTimeGetCurrent() - startTime)
                let progress = min(elapsed / totalTime, 1.0)
                let pos = startPos + (endPos - startPos) * progress
                ball.position = pos

                // Despawn after passing the user
                if pos.z > 0.1 {
                    ball.removeFromParent()
                    timer.invalidate()
                    ballTimers[id] = nil
                    activeBalls.removeAll { $0.id == id }
                    appModel.activeBallIDs.removeAll { $0 == id }
                }

                if progress >= 1.0 {
                    timer.invalidate()
                    ballTimers[id] = nil
                }
            }
        }
        ballTimers[id] = t
    }

    // MARK: - Freeze & score
    func freezeBall(withID id: UUID) -> Float? {
        guard let idx = activeBalls.firstIndex(where: { $0.id == id }),
              !activeBalls[idx].isFrozen else { return nil }

        var ballData = activeBalls[idx]
        ballData.isFrozen = true

        // Stop movement
        if let timer = ballTimers[id] { timer.invalidate(); ballTimers[id] = nil }

        // Turn blue
        if var model = ballData.entity.components[ModelComponent.self] {
            model.materials = [SimpleMaterial(color: .systemBlue, roughness: 0.9, isMetallic: false)]
            ballData.entity.components[ModelComponent.self] = model
        }

        // Add distance label
        let z = abs(ballData.entity.position.z)
        let labelMesh = MeshResource.generateText(
            String(format: "%.2fm", z),
            extrusionDepth: 0.008,
            font: .systemFont(ofSize: 0.12, weight: .bold)
        )
        let label = ModelEntity(mesh: labelMesh, materials: [SimpleMaterial(color: .yellow, isMetallic: false)])
        label.position = SIMD3<Float>(0, 0.2, 0)
        ballData.entity.addChild(label)

        activeBalls[idx] = ballData
        return z
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
        }
    }
}

#Preview {
    ImmersiveView()
        .environment(AppModel())
}

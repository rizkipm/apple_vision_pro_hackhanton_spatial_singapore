////
////  ImmersiveView.swift
////  hack_spatial_rizki_sg
////
////  Created by rizki aimar on 07/08/25.
////
//
//import SwiftUI
//import RealityKit
//
//struct ImmersiveView: View {
//    @State private var environmentStyle: EnvironmentStyle = .gradient
//    
//    enum EnvironmentStyle: CaseIterable {
//        case gradient, space, forest, ocean
//        
//        var name: String {
//            switch self {
//            case .gradient: return "Gradient"
//            case .space: return "Space"
//            case .forest: return "Forest"
//            case .ocean: return "Ocean"
//            }
//        }
//    }
//    
//    var body: some View {
//        RealityView { content in
//            setupImmersiveEnvironment(content: content, style: environmentStyle)
//        } update: { content in
//            updateEnvironment(content: content, style: environmentStyle)
//        }
//        .toolbar {
//            ToolbarItem(placement: .bottomOrnament) {
//                EnvironmentControlView(selectedStyle: $environmentStyle)
//            }
//        }
//    }
//    
//    private func setupImmersiveEnvironment(content: RealityViewContent, style: EnvironmentStyle) {
//        // Clear existing content
//        content.entities.removeAll()
//        
//        switch style {
//        case .gradient:
//            setupGradientEnvironment(content: content)
//        case .space:
//            setupSpaceEnvironment(content: content)
//        case .forest:
//            setupForestEnvironment(content: content)
//        case .ocean:
//            setupOceanEnvironment(content: content)
//        }
//        
//        // Add ambient particles
//        addParticleSystem(to: content, style: style)
//    }
//    
//    private func updateEnvironment(content: RealityViewContent, style: EnvironmentStyle) {
//        setupImmersiveEnvironment(content: content, style: style)
//    }
//    
//    private func setupGradientEnvironment(content: RealityViewContent) {
//        // Create large sphere for skybox
//        let skyboxEntity = createSkyboxEntity(colors: [
//            UIColor(red: 0.4, green: 0.8, blue: 1.0, alpha: 1.0), // Sky blue
//            UIColor(red: 1.0, green: 0.6, blue: 0.4, alpha: 1.0), // Orange
//            UIColor(red: 1.0, green: 0.4, blue: 0.6, alpha: 1.0)  // Pink
//        ])
//        content.add(skyboxEntity)
//        
//        // Add floating geometric shapes
//        addFloatingGeometry(to: content, count: 20)
//    }
//    
//    private func setupSpaceEnvironment(content: RealityViewContent) {
//        // Dark space background
//        let skyboxEntity = createSkyboxEntity(colors: [
//            UIColor(red: 0.05, green: 0.05, blue: 0.2, alpha: 1.0),
//            UIColor(red: 0.1, green: 0.1, blue: 0.3, alpha: 1.0),
//            UIColor(red: 0.0, green: 0.0, blue: 0.1, alpha: 1.0)
//        ])
//        content.add(skyboxEntity)
//        
//        // Add stars
//        addStars(to: content, count: 100)
//        
//        // Add floating planets
//        addPlanets(to: content, count: 5)
//    }
//    
//    private func setupForestEnvironment(content: RealityViewContent) {
//        // Forest background
//        let skyboxEntity = createSkyboxEntity(colors: [
//            UIColor(red: 0.2, green: 0.6, blue: 0.3, alpha: 1.0),
//            UIColor(red: 0.3, green: 0.7, blue: 0.2, alpha: 1.0),
//            UIColor(red: 0.1, green: 0.4, blue: 0.2, alpha: 1.0)
//        ])
//        content.add(skyboxEntity)
//        
//        // Add trees
//        addTrees(to: content, count: 15)
//    }
//    
//    private func setupOceanEnvironment(content: RealityViewContent) {
//        // Ocean background
//        let skyboxEntity = createSkyboxEntity(colors: [
//            UIColor(red: 0.0, green: 0.4, blue: 0.8, alpha: 1.0),
//            UIColor(red: 0.0, green: 0.6, blue: 1.0, alpha: 1.0),
//            UIColor(red: 0.2, green: 0.8, blue: 1.0, alpha: 1.0)
//        ])
//        content.add(skyboxEntity)
//        
//        // Add floating bubbles
//        addBubbles(to: content, count: 30)
//        
//        // Add fish
//        addFish(to: content, count: 10)
//    }
//    
//    private func createSkyboxEntity(colors: [UIColor]) -> Entity {
//        let sphere = MeshResource.generateSphere(radius: 100.0)
//        
//        var material = UnlitMaterial()
//        material.color = .init(tint: colors.first!)
//        
//        let entity = ModelEntity(mesh: sphere, materials: [material])
//        entity.scale = SIMD3<Float>(-1, 1, 1) // Invert for skybox
//        entity.name = "skybox"
//        
//        return entity
//    }
//    
//    private func addFloatingGeometry(to content: RealityViewContent, count: Int) {
//        for i in 0..<count {
//            let shape = createRandomGeometry()
//            let x = Float.random(in: -20...20)
//            let y = Float.random(in: -10...10)
//            let z = Float.random(in: -20...20)
//            
//            shape.transform.translation = [x, y, z]
//            shape.name = "geometry_\(i)"
//            
//            content.add(shape)
//            
//            // Add rotation animation
//            addRotationAnimation(to: shape)
//        }
//    }
//    
//    private func createRandomGeometry() -> ModelEntity {
//        let shapes = [
//            MeshResource.generateSphere(radius: 0.5),
//            MeshResource.generateBox(size: 1.0),
//            MeshResource.generateCylinder(height: 1.0, radius: 0.5)
//        ]
//        
//        let colors: [UIColor] = [.systemPink, .systemBlue, .systemGreen, .systemOrange, .systemPurple]
//        
//        let mesh = shapes.randomElement()!
//        var material = SimpleMaterial()
//        material.color = .init(tint: colors.randomElement()!)
//        material.metallic = 0.8
//        material.roughness = 0.2
//        
//        return ModelEntity(mesh: mesh, materials: [material])
//    }
//    
//    private func addStars(to content: RealityViewContent, count: Int) {
//        for i in 0..<count {
//            let star = createStar()
//            let distance = Float.random(in: 30...80)
//            let theta = Float.random(in: 0...(2 * .pi))
//            let phi = Float.random(in: 0...(2 * .pi))
//            
//            let x = distance * cos(theta) * sin(phi)
//            let y = distance * sin(theta)
//            let z = distance * cos(theta) * cos(phi)
//            
//            star.transform.translation = [x, y, z]
//            star.name = "star_\(i)"
//            
//            content.add(star)
//        }
//    }
//    
//    private func createStar() -> ModelEntity {
//        let sphere = MeshResource.generateSphere(radius: 0.1)
//        var material = UnlitMaterial()
//        material.color = .init(tint: .white)
//        
//        return ModelEntity(mesh: sphere, materials: [material])
//    }
//    
//    private func addPlanets(to content: RealityViewContent, count: Int) {
//        let planetColors: [UIColor] = [.systemBlue, .systemRed, .systemGreen, .systemOrange, .systemPurple]
//        
//        for i in 0..<count {
//            let radius = Float.random(in: 1.0...3.0)
//            let planet = MeshResource.generateSphere(radius: radius)
//            
//            var material = SimpleMaterial()
//            material.color = .init(tint: planetColors.randomElement()!)
//            material.metallic = 0.3
//            material.roughness = 0.7
//            
//            let entity = ModelEntity(mesh: planet, materials: [material])
//            
//            let distance = Float.random(in: 15...40)
//            let theta = Float.random(in: 0...(2 * .pi))
//            let phi = Float.random(in: 0...(.pi))
//            
//            let x = distance * cos(theta) * sin(phi)
//            let y = distance * sin(theta) * sin(phi)
//            let z = distance * cos(phi)
//            
//            entity.transform.translation = [x, y, z]
//            entity.name = "planet_\(i)"
//            
//            content.add(entity)
//            addRotationAnimation(to: entity)
//        }
//    }
//    
//    private func addTrees(to content: RealityViewContent, count: Int) {
//        for i in 0..<count {
//            let tree = createTree()
//            let x = Float.random(in: -25...25)
//            let y = -5.0
//            let z = Float.random(in: -25...25)
//            
////            tree.transform.translation = [x, y, z]
//            tree.name = "tree_\(i)"
//            
//            content.add(tree)
//        }
//    }
//    
//    private func createTree() -> Entity {
//        let treeEntity = Entity()
//        
//        // Trunk
//        let trunk = MeshResource.generateCylinder(height: 3.0, radius: 0.3)
//        var trunkMaterial = SimpleMaterial()
//        trunkMaterial.color = .init(tint: UIColor.brown)
//        let trunkEntity = ModelEntity(mesh: trunk, materials: [trunkMaterial])
//        trunkEntity.transform.translation = [0, 1.5, 0]
//        
//        // Leaves
//        let leaves = MeshResource.generateSphere(radius: 1.5)
//        var leavesMaterial = SimpleMaterial()
//        leavesMaterial.color = .init(tint: UIColor.green)
//        let leavesEntity = ModelEntity(mesh: leaves, materials: [leavesMaterial])
//        leavesEntity.transform.translation = [0, 4.0, 0]
//        
//        treeEntity.addChild(trunkEntity)
//        treeEntity.addChild(leavesEntity)
//        
//        return treeEntity
//    }
//    
//    private func addBubbles(to content: RealityViewContent, count: Int) {
//        for i in 0..<count {
//            let bubble = createBubble()
//            let x = Float.random(in: -20...20)
//            let y = Float.random(in: -10...10)
//            let z = Float.random(in: -20...20)
//            
//            bubble.transform.translation = [x, y, z]
//            bubble.name = "bubble_\(i)"
//            
//            content.add(bubble)
//            addFloatingAnimation(to: bubble)
//        }
//    }
//    
//    private func createBubble() -> ModelEntity {
//        let radius = Float.random(in: 0.2...0.8)
//        let sphere = MeshResource.generateSphere(radius: radius)
//        
//        var material = SimpleMaterial()
//        material.color = .init(tint: UIColor.cyan.withAlphaComponent(0.3))
//        material.metallic = 0.9
//        material.roughness = 0.1
//        
//        return ModelEntity(mesh: sphere, materials: [material])
//    }
//    
//    private func addFish(to content: RealityViewContent, count: Int) {
//        for i in 0..<count {
//            let fish = createFish()
//            let x = Float.random(in: -15...15)
//            let y = Float.random(in: -8...8)
//            let z = Float.random(in: -15...15)
//            
//            fish.transform.translation = [x, y, z]
//            fish.name = "fish_\(i)"
//            
//            content.add(fish)
//            addSwimmingAnimation(to: fish)
//        }
//    }
//    
//    private func createFish() -> ModelEntity {
//        // Simple fish shape using a stretched sphere
//        let fishBody = MeshResource.generateSphere(radius: 0.5)
//        
//        var material = SimpleMaterial()
//        material.color = .init(tint: [UIColor.orange, UIColor.yellow, UIColor.red].randomElement()!)
//        
//        let fish = ModelEntity(mesh: fishBody, materials: [material])
//        fish.scale = [1.5, 0.8, 0.6] // Make it fish-like
//        
//        return fish
//    }
//    
//    private func addParticleSystem(to content: RealityViewContent, style: EnvironmentStyle) {
//        // Create particle effects based on environment style
//        switch style {
//        case .gradient:
//            addSparkleParticles(to: content)
//        case .space:
//            addStardustParticles(to: content)
//        case .forest:
//            addLeafParticles(to: content)
//        case .ocean:
//            addWaterParticles(to: content)
//        }
//    }
//    
//    private func addSparkleParticles(to content: RealityViewContent) {
//        // Add floating sparkle particles
//        for i in 0..<50 {
//            let sparkle = createSparkle()
//            let x = Float.random(in: -30...30)
//            let y = Float.random(in: -15...15)
//            let z = Float.random(in: -30...30)
//            
//            sparkle.transform.translation = [x, y, z]
//            sparkle.name = "sparkle_\(i)"
//            
//            content.add(sparkle)
////            addTwinkleAnimation(to: sparkle)
//        }
//    }
//    
//    private func createSparkle() -> ModelEntity {
//        let sparkle = MeshResource.generateSphere(radius: 0.05)
//        var material = UnlitMaterial()
//        material.color = .init(tint: UIColor.white)
//        
//        return ModelEntity(mesh: sparkle, materials: [material])
//    }
//    
//    private func addStardustParticles(to content: RealityViewContent) {
//        // Similar to sparkles but with cosmic colors
//        for i in 0..<80 {
//            let dust = createStardust()
//            let x = Float.random(in: -40...40)
//            let y = Float.random(in: -20...20)
//            let z = Float.random(in: -40...40)
//            
//            dust.transform.translation = [x, y, z]
//            dust.name = "stardust_\(i)"
//            
//            content.add(dust)
//            addDriftAnimation(to: dust)
//        }
//    }
//    
//    private func createStardust() -> ModelEntity {
//        let dust = MeshResource.generateSphere(radius: 0.03)
//        var material = UnlitMaterial()
//        let colors: [UIColor] = [.systemPurple, .systemBlue, .white, .systemPink]
//        material.color = .init(tint: colors.randomElement()!)
//        
//        return ModelEntity(mesh: dust, materials: [material])
//    }
//    
//    private func addLeafParticles(to content: RealityViewContent) {
//        for i in 0..<30 {
//            let leaf = createLeaf()
//            let x = Float.random(in: -25...25)
//            let y = Float.random(in: 5...15)
//            let z = Float.random(in: -25...25)
//            
//            leaf.transform.translation = [x, y, z]
//            leaf.name = "leaf_\(i)"
//            
//            content.add(leaf)
//            addFallingAnimation(to: leaf)
//        }
//    }
//    
//    private func createLeaf() -> ModelEntity {
//        let leaf = MeshResource.generateBox(size: [0.3, 0.1, 0.2])
//        var material = SimpleMaterial()
//        let colors: [UIColor] = [.systemGreen, .systemYellow, .systemOrange, .systemBrown]
//        material.color = .init(tint: colors.randomElement()!)
//        
//        return ModelEntity(mesh: leaf, materials: [material])
//    }
//    
//    private func addWaterParticles(to content: RealityViewContent) {
//        for i in 0..<40 {
//            let droplet = createWaterDroplet()
//            let x = Float.random(in: -20...20)
//            let y = Float.random(in: -10...10)
//            let z = Float.random(in: -20...20)
//            
//            droplet.transform.translation = [x, y, z]
//            droplet.name = "droplet_\(i)"
//            
//            content.add(droplet)
//            addBubbleAnimation(to: droplet)
//        }
//    }
//    
//    private func createWaterDroplet() -> ModelEntity {
//        let droplet = MeshResource.generateSphere(radius: 0.1)
//        var material = SimpleMaterial()
//        material.color = .init(tint: UIColor.cyan.withAlphaComponent(0.6))
//        material.metallic = 0.9
//        material.roughness = 0.1
//        
//        return ModelEntity(mesh: droplet, materials: [material])
//    }
//    
//    // Animation methods
//    private func addRotationAnimation(to entity: Entity) {
//        let rotationSpeed = Float.random(in: 0.5...2.0)
//        let rotationAxis = SIMD3<Float>(Float.random(in: -1...1), Float.random(in: -1...1), Float.random(in: -1...1))
//        
//        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: <#Bool#>) { timer in
//            guard entity.parent != nil else {
//                timer.invalidate()
//                return
//            }
//            
//            let currentRotation = entity.transform.rotation
//            let deltaRotation = simd_quatf(angle: rotationSpeed * 0.016, axis: normalize(rotationAxis))
//            entity.transform.rotation = currentRotation * deltaRotation
//        }
//    }
//    
//    private func addFloatingAnimation(to entity: Entity) {
//        let initialY = entity.transform.translation.y
//        let amplitude = Float.random(in: 0.5...2.0)
//        let frequency = Float.random(in: 0.5...1.5)
//        var time: Float = 0
//        
//        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: <#Bool#>) { timer in
//            guard entity.parent != nil else {
//                timer.invalidate()
//                return
//            }
//            
//            time += 0.016
//            let newY = initialY + amplitude * sin(frequency * time)
//            entity.transform.translation.y = newY
//        }
//    }
//    
//    private func addSwimmingAnimation(to entity: Entity) {
//        let speed = Float.random(in: 0.5...1.5)
//        let radius = Float.random(in: 5...15)
//        let centerX = entity.transform.translation.x
//        let centerZ = entity.transform.translation.z
//        var angle: Float = 0
//        
//        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: <#Bool#>) { timer in
//            guard entity.parent != nil else {
//                timer.invalidate()
//                return
//            }
//            
//            angle += speed * 0.016
//            let newX = centerX + radius * cos(angle)
//            let newZ = centerZ + radius * sin(angle)
//            
//            entity.transform.translation.x = newX
//            entity.transform.translation.z = newZ
//            
//            // Orient fish to swimming direction
//            let direction = normalize(SIMD3<Float>(cos(angle + .pi/2), 0, sin(angle + .pi/2)))
//            entity.transform.rotation = simd_quatf(from: [0, 0, 1], to: direction)
//        }
//    }
//    
////    private func addTwinkleAnimation(to entity: Entity) {
////        let frequency = Float.random(in: 1.0...3.0)
////        var time: Float = 0
////        let originalScale = entity.scale
////        
//////        Timer.scheduledTimer(withTimeInterval: 0.016) { timer in
//////            guard entity.parent != nil else {
//////                timer.invalidate()
//////                return
//////            }
//////            
//////            time += 0.016
//////            let scaleFactor = 0.5 + 0.5 * (sin(frequency * time) + 1)
//////            entity.scale = originalScale * scaleFactor
//////        }
////    }
//    
//    private func addDriftAnimation(to entity: Entity) {
//        let driftSpeed = SIMD3<Float>(
//            Float.random(in: -0.5...0.5),
//            Float.random(in: -0.3...0.3),
//            Float.random(in: -0.5...0.5)
//        )
//        
//        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: <#Bool#>) { timer in
//            guard entity.parent != nil else {
//                timer.invalidate()
//                return
//            }
//            
//            entity.transform.translation += driftSpeed * 0.016
//            
//            // Reset position if too far
//            if length(entity.transform.translation) > 50 {
//                entity.transform.translation = SIMD3<Float>(
//                    Float.random(in: -40...40),
//                    Float.random(in: -20...20),
//                    Float.random(in: -40...40)
//                )
//            }
//        }
//    }
//    
//    private func addFallingAnimation(to entity: Entity) {
//        let fallSpeed = Float.random(in: 1.0...3.0)
//        let swayAmplitude = Float.random(in: 0.5...2.0)
//        let swayFrequency = Float.random(in: 0.5...2.0)
//        let initialX = entity.transform.translation.x
//        var time: Float = 0
//        
//        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: <#Bool#>) { timer in
//            guard entity.parent != nil else {
//                timer.invalidate()
//                return
//            }
//            
//            time += 0.016
//            entity.transform.translation.y -= fallSpeed * 0.016
//            entity.transform.translation.x = initialX + swayAmplitude * sin(swayFrequency * time)
//            
//            // Reset position if fallen too far
//            if entity.transform.translation.y < -15 {
//                entity.transform.translation.y = Float.random(in: 10...15)
//                entity.transform.translation.x = Float.random(in: -25...25)
//                entity.transform.translation.z = Float.random(in: -25...25)
//            }
//        }
//    }
//    
//    private func addBubbleAnimation(to entity: Entity) {
//        let riseSpeed = Float.random(in: 0.5...2.0)
//        let wobbleAmplitude = Float.random(in: 0.3...1.0)
//        let wobbleFrequency = Float.random(in: 1.0...3.0)
//        let initialX = entity.transform.translation.x
//        let initialZ = entity.transform.translation.z
//        var time: Float = 0
//        
//        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: Bool.random()) { timer in
//            guard entity.parent != nil else {
//                timer.invalidate()
//                return
//            }
//            
//            time += 0.016
//            entity.transform.translation.y += riseSpeed * 0.016
//            entity.transform.translation.x = initialX + wobbleAmplitude * sin(wobbleFrequency * time)
//            entity.transform.translation.z = initialZ + wobbleAmplitude * cos(wobbleFrequency * time * 0.7)
//            
//            // Reset position if risen too far
//            if entity.transform.translation.y > 15 {
//                entity.transform.translation.y = Float.random(in: -15...(-10))
//                entity.transform.translation.x = Float.random(in: -20...20)
//                entity.transform.translation.z = Float.random(in: -20...20)
//            }
//        }
//    }
//}
//
//struct EnvironmentControlView: View {
//    @Binding var selectedStyle: ImmersiveView.EnvironmentStyle
//    
//    var body: some View {
//        HStack(spacing: 16) {
//            ForEach(ImmersiveView.EnvironmentStyle.allCases, id: \.self) { style in
//                Button(action: {
//                    selectedStyle = style
//                }) {
//                    VStack(spacing: 4) {
//                        Image(systemName: iconForStyle(style))
//                            .font(.title2)
//                            .foregroundColor(selectedStyle == style ? .white : .white.opacity(0.6))
//                        
//                        Text(style.name)
//                            .font(.caption)
//                            .foregroundColor(selectedStyle == style ? .white : .white.opacity(0.6))
//                    }
//                    .padding(.horizontal, 12)
//                    .padding(.vertical, 8)
//                    .background(
//                        RoundedRectangle(cornerRadius: 12)
//                            .fill(selectedStyle == style ? Color.white.opacity(0.2) : Color.clear)
//                    )
//                }
//                .buttonStyle(.plain)
//                .hoverEffect(.lift)
//            }
//        }
//        .padding(.horizontal, 20)
//        .padding(.vertical, 12)
//        .background(
//            RoundedRectangle(cornerRadius: 20)
//                .fill(.regularMaterial)
//                .opacity(0.8)
//        )
//    }
//    
//    private func iconForStyle(_ style: ImmersiveView.EnvironmentStyle) -> String {
//        switch style {
//        case .gradient: return "paintbrush.fill"
//        case .space: return "moon.stars.fill"
//        case .forest: return "tree.fill"
//        case .ocean: return "drop.fill"
//        }
//    }
//}
//
//#Preview {
//    ImmersiveView()
//}

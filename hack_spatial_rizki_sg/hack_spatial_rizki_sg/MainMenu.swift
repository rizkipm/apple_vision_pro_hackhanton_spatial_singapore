//
//  MainMenu.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 06/08/25.
//

//import SwiftUI
//import RealityKit
//import RealityKitContent
//import ARKit
//
//import SwiftUI
//import RealityKit
//import RealityKitContent
//
//struct MainMenu: View {
//    @State private var selectedWorld: WorldType? = nil
//
//    var body: some View {
//        RealityView { content in
//            // Add world buttons
//            addWorldOptions(to: content)
//
//            // Optional: add light
//            let light = DirectionalLight()
//            light.position = SIMD3(0, 2, 0)
//            content.add(light)
//            
////            if let texture = try? TextureResource.load(named: "background") {
////                            var material = SimpleMaterial(color: .white, isMetallic: false)
////                MaterialColorParameter.texture = MaterialParameters.Texture(texture)
////
////                            let plane = ModelEntity(
////                                mesh: MeshResource.generatePlane(width: 6, height: 4),
////                                materials: [material]
////                            )
////                            plane.position = SIMD3(0, 2, -3) // Di belakang kamera
////                            content.add(plane)
////                        }
//        }
//        .gesture(
//            TapGesture()
//                .targetedToAnyEntity()
//                .onEnded { value in
//                    let tapped = value.entity
//                    if let world = WorldType.allCases.first(where: { $0.rawValue == tapped.name }) {
//                        selectedWorld = world
//                        print("Tapped world: \(world.rawValue)")
//                    }
//                }
//        )
//        .overlay {
//            if let world = selectedWorld {
//                Text("Entering \(world.rawValue)...")
//                    .font(.largeTitle)
//                    .foregroundStyle(.white)
//            }
//        }
//        
//        
//    }
//
//    func addWorldOptions(to content: RealityViewContent) {
//        let spacing: Float = 0.35
//        let startX = -spacing * 2
//
//        for (index, world) in WorldType.allCases.enumerated() {
//            let button = WorldButton(world: world)
//            let x = startX + Float(index) * spacing
//            button.entity.position = SIMD3(x, 1.5, -1.5) // Near eye level & in front
//            content.add(button.entity)
//        }
//    }
//    
//   
//
//}


import SwiftUI
import RealityKit
import RealityKitContent
import ARKit

struct MainMenu: View {
    @State private var selectedWorld: WorldType? = nil
    
    var body: some View {
        ZStack {
            // Custom background image
            RealityView { content in
                addCustomBackground(to: content)
                addWorldOptions(to: content)
            }
            .gesture(
                TapGesture()
                    .targetedToAnyEntity()
                    .onEnded { value in
                        let tapped = value.entity
                        print("Tapped entity: \(tapped.name)")
                        
                        // Check if tapped entity or its parent has WorldType name
                        var entityToCheck: Entity? = tapped
                        while entityToCheck != nil {
                            if let world = WorldType.allCases.first(where: { $0.rawValue == entityToCheck!.name }) {
                                selectedWorld = world
                                print("Selected world: \(world.rawValue)")
                                return
                            }
                            entityToCheck = entityToCheck?.parent
                        }
                    }
            )
            
            // Overlay untuk menampilkan selection
            if let world = selectedWorld {
                VStack {
                    Spacer()
                    Text("Entering \(world.rawValue)...")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        .padding()
                    Spacer()
                }
            }
        }
    }
    
    func addCustomBackground(to content: RealityViewContent) {
        // Mengganti background default dengan gambar custom
        guard let backgroundTexture = try? TextureResource.load(named: "background") else {
            print("Failed to load background texture")
            return
        }
        
        // Create sphere untuk 360° background
        let backgroundSphere = MeshResource.generateSphere(radius: 50)
        var backgroundMaterial = UnlitMaterial()
        backgroundMaterial.color = .init(texture: .init(backgroundTexture))
        
        let backgroundEntity = ModelEntity(mesh: backgroundSphere, materials: [backgroundMaterial])
        backgroundEntity.scale = SIMD3(-1, 1, 1) // Flip untuk inside view
        backgroundEntity.position = SIMD3(0, 0, 0)
        
        content.add(backgroundEntity)
    }
    
    func addWorldOptions(to content: RealityViewContent) {
        let spacing: Float = 0.4
        let worlds: [WorldType] = [.candyPlanet, .zenGarden, .spaceCatcher, .memoryBubbles, .artisticMode]

        for (index, world) in worlds.enumerated() {
            let button = WorldButton(world: world) {
                print("Button callback triggered for: \(world.rawValue)")
                self.selectedWorld = world
            }
            
            let x = Float(index - 2) * spacing
            button.entity.position = SIMD3(x, 0, -1.5)
            
            // Add hover effect
            addHoverEffect(to: button.entity)
            
            content.add(button.entity)
        }
    }
    
    func addHoverEffect(to entity: ModelEntity) {
        // Tambahkan hover effect untuk better UX
        entity.components.set(HoverEffectComponent())
    }
}

#Preview(windowStyle: .automatic) {
    MainMenu()
}

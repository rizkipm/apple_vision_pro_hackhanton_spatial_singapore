//
//  MainMenu.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 06/08/25.
//

import SwiftUI
import RealityKit
import RealityKitContent
import ARKit

import SwiftUI
import RealityKit
import RealityKitContent

struct MainMenu: View {
    @State private var selectedWorld: WorldType? = nil

    var body: some View {
        RealityView { content in
            // Add world buttons
            addWorldOptions(to: content)

            // Optional: add light
            let light = DirectionalLight()
            light.position = SIMD3(0, 2, 0)
            content.add(light)
            
//            if let texture = try? TextureResource.load(named: "background") {
//                            var material = SimpleMaterial(color: .white, isMetallic: false)
//                MaterialColorParameter.texture = MaterialParameters.Texture(texture)
//
//                            let plane = ModelEntity(
//                                mesh: MeshResource.generatePlane(width: 6, height: 4),
//                                materials: [material]
//                            )
//                            plane.position = SIMD3(0, 2, -3) // Di belakang kamera
//                            content.add(plane)
//                        }
        }
        .gesture(
            TapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    let tapped = value.entity
                    if let world = WorldType.allCases.first(where: { $0.rawValue == tapped.name }) {
                        selectedWorld = world
                        print("Tapped world: \(world.rawValue)")
                    }
                }
        )
        .overlay {
            if let world = selectedWorld {
                Text("Entering \(world.rawValue)...")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
            }
        }
        
        
    }

    func addWorldOptions(to content: RealityViewContent) {
        let spacing: Float = 0.35
        let startX = -spacing * 2

        for (index, world) in WorldType.allCases.enumerated() {
            let button = WorldButton(world: world)
            let x = startX + Float(index) * spacing
            button.entity.position = SIMD3(x, 1.5, -1.5) // Near eye level & in front
            content.add(button.entity)
        }
    }
    
   

}



#Preview(windowStyle: .automatic) {
    MainMenu()
}

//
//  WorldButton.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 06/08/25.
//

import Foundation
import RealityKit
import UIKit

struct WorldButton {
    let world: WorldType
    let entity: ModelEntity

    init(world: WorldType) {
        self.world = world

        // Main button (sphere)
        let sphere = MeshResource.generateSphere(radius: 0.1)
        let material = SimpleMaterial(color: world.color, isMetallic: false)
        self.entity = ModelEntity(mesh: sphere, materials: [material])
        entity.name = world.rawValue

        // Text label
        let textMesh = MeshResource.generateText(
            "\(world.icon)\n\(world.rawValue)",
            extrusionDepth: 0.01,
            font: .systemFont(ofSize: 0.03),
            containerFrame: .zero,
            alignment: .center,
            lineBreakMode: .byWordWrapping
        )
        let textEntity = ModelEntity(mesh: textMesh)
        textEntity.position = SIMD3(0, 0.15, 0)
        entity.addChild(textEntity)

        // Collision and gesture readiness
        entity.generateCollisionShapes(recursive: true)
        entity.components.set(InputTargetComponent())
    }
}


//import Foundation
//import RealityKit
//import UIKit
//
//struct WorldButton {
//    let world: WorldType
//    let onTap: () -> Void
//    let entity: ModelEntity
//
//    init(world: WorldType, onTap: @escaping () -> Void) {
//        self.world = world
//        self.onTap = onTap
//
//        // 1. Create ModelEntity directly
//        let sphereMesh = MeshResource.generateSphere(radius: 0.1)
//        let material = SimpleMaterial(color: world.color, isMetallic: false)
//        self.entity = ModelEntity(mesh: sphereMesh, materials: [material])
//        entity.name = world.rawValue
//
//        // 2. Create and add Text Label
//        let textMesh = MeshResource.generateText(
//            "\(world.icon)\n\(world.rawValue)",
//            extrusionDepth: 0.01,
//            font: .systemFont(ofSize: 0.04),
//            containerFrame: .zero,
//            alignment: .center,
//            lineBreakMode: .byWordWrapping
//        )
//        let textEntity = ModelEntity(mesh: textMesh)
//        textEntity.position = SIMD3(0, 0.15, 0)
//        entity.addChild(textEntity)
//
//        // 3. Enable collision & input interaction
//        entity.generateCollisionShapes(recursive: true)
//        entity.components.set(InputTargetComponent())
//
////        // 4. Handle tap gesture
////        entity.onInput(.touchUpInside) { _ in
////            onTap()
////        }
//    }
//}




//
//  BackgroundEnvirontment.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 07/08/25.
//

//import SwiftUI
//
//struct BackgroundEnvirontment: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    BackgroundEnvirontment()
//}

import SwiftUI
import RealityKit
import RealityKitContent
import Foundation

struct BackgroundEnvironmentView: View {
    @State private var rotationAngle: Float = 0.0
    
    var body: some View {
        RealityView { content in
            // Create environment sphere
            let environmentEntity = createEnvironmentSphere()
            content.add(environmentEntity)
            
            // Add ambient lighting
            let ambientLight = createAmbientLight()
            content.add(ambientLight)
            
            // Add directional light
            let directionalLight = createDirectionalLight()
            content.add(directionalLight)
            
        } update: { content in
            // Update rotation animation
            if let environmentEntity = content.entities.first(where: { $0.name == "environment" }) {
                environmentEntity.transform.rotation = simd_quatf(angle: rotationAngle, axis: [0, 1, 0])
            }
        }
        .onAppear {
            startRotationAnimation()
        }
    }
    
    private func createEnvironmentSphere() -> Entity {
        let sphere = MeshResource.generateSphere(radius: 50.0)
        
        // Create gradient material
        let material = UnlitMaterial()
//        material.color = .init(tint: .white.opacity(0.1))
        
        let entity = ModelEntity(mesh: sphere, materials: [material])
        entity.name = "environment"
        entity.transform.translation = [0, 0, 0]
        
        // Add gradient texture programmatically
        _ = createGradientTexture()
        let gradientMaterial = UnlitMaterial()
//        gradientMaterial.color = .init(texture: .init(gradientTexture))
        entity.model?.materials = [gradientMaterial]
        
        return entity
    }
    
    private func createGradientTexture() -> CGImage {
        let size = CGSize(width: 512, height: 512)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: nil,
                               width: Int(size.width),
                               height: Int(size.height),
                               bitsPerComponent: 8,
                               bytesPerRow: 0,
                               space: colorSpace,
                               bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        // Create gradient colors (sky blue to orange/pink)
        let colors = [
            CGColor(red: 0.4, green: 0.8, blue: 1.0, alpha: 1.0), // Sky blue
            CGColor(red: 1.0, green: 0.6, blue: 0.4, alpha: 1.0), // Orange
            CGColor(red: 1.0, green: 0.4, blue: 0.6, alpha: 1.0)  // Pink
        ]
        
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: [0.0, 0.5, 1.0])!
        
        context.drawRadialGradient(gradient,
                                 startCenter: CGPoint(x: size.width/2, y: size.height/2),
                                 startRadius: 0,
                                 endCenter: CGPoint(x: size.width/2, y: size.height/2),
                                 endRadius: size.width/2,
                                 options: [])
        
        return context.makeImage()!
    }
    
    private func createAmbientLight() -> Entity {
        let light = DirectionalLight()
        light.light.color = .white
        light.light.intensity = 500
        light.transform.rotation = simd_quatf(angle: .pi/4, axis: [1, 0, 0])
        return light
    }
    
    private func createDirectionalLight() -> Entity {
        let light = DirectionalLight()
//        light.light.color = .init(red: 1.0, green: 0.9, blue: 0.8, alpha: CGFloat)
        light.light.intensity = 1000
        light.transform.rotation = simd_quatf(angle: -.pi/3, axis: [1, 1, 0])
        return light
    }
    
    private func startRotationAnimation() {
//        Timer.scheduledTimer(withTimeInterval: 0.016) { _ in
//            rotationAngle += 0.001
//        }
    }
}

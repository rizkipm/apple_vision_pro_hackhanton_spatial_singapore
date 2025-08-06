//
//  CubeModel3DView.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 06/08/25.
//

//import SwiftUI
//import _RealityKit_SwiftUI
//
//struct CubeModel3DView: View {
//    @State private var rotationY: Double = 0.0
//    
//    
//    var body: some View {
//        Model3D(named: "Cube")
//            .padding3D(.back, 80)
//        
//            .gesture(
//                DragGesture(minimumDistance: 0)
//                    .onChanged { value in
//                        rotationY += Double(value.translation.width / 100)
//                        rotationY = rotationY.truncatingRemainder(dividingBy: 360)
//                    }
//            )
//        
//        Model3D(named: "Cube") { model in
//            model
//                .rotation3DEffect(
//                    .degrees(rotationY),
//                    axis: (x: 0, y: 1, z: 0)
//                )
//        } placeholder: {
//            ProgressView()
//        }
//        
//        ornament(attachmentAnchor: .scene(.bottom)) {
//            Text("Rotation: \(rotationY, specifier: "%.2f")º")
//                .padding()
//                .glassBackgroundEffect()
//        }
//    }
//    
//}

import SwiftUI
import RealityKit

struct CubeModel3DView: View {
    @State private var rotationY: Double = 0.0
    
    var body: some View {
        VStack {
            Model3D(named: "Cube") { model in
                model
                    .rotation3DEffect(
                        .degrees(rotationY),
                        axis: (x: 0, y: 1, z: 0)
                    )
            } placeholder: {
                ProgressView("Loading Cube...")
                    .frame(width: 200, height: 200)
            }
            .frame(width: 300, height: 300)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        rotationY += Double(value.translation.width / 100)
                        rotationY = rotationY.truncatingRemainder(dividingBy: 360)
                    }
            )
            
            Text("Rotation: \(rotationY, specifier: "%.2f")°")
                .padding()
                .background(.regularMaterial)
                .cornerRadius(10)
        }
        .padding()
    }
}

#Preview {
    CubeModel3DView()
}

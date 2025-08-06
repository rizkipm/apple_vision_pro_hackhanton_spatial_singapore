//
//  hack_spatial_rizki_sgApp.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 05/08/25.
//

import SwiftUI

@main
struct hack_spatial_rizki_sgApp: App {
    var body: some Scene {
            WindowGroup {
                ContentView()
                   .background(.black.opacity(0.8))
            }
        
            WindowGroup(id: "CubeWindow") {
                CubeModel3DView()
            }
            .defaultSize(width: 500, height: 500)
            .windowStyle(.volumetric)
                    .defaultSize(width: 0.6, height: 0.6, depth: 0.6, in: .meters)


            ImmersiveSpace(id: "Immersive") {
                ContentView()
            }
        }
}

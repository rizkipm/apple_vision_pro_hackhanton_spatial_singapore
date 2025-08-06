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


            ImmersiveSpace(id: "Immersive") {
                ImmersiveView()
            }
        }
}

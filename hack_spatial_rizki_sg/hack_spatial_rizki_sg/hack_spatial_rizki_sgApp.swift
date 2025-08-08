//
//  hack_spatial_rizki_sgApp.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 05/08/25.
//

import SwiftUI


@main
struct hack_spatial_rizki_sgApp: App {
    @State private var appModel = AppModel()
    var body: some Scene {
        WindowGroup {
            MainContent()
                .environment(appModel)
        }
//        .windowStyle(.volumetric)
//        .defaultSize(width: 2, height: 2, depth: 2, in: .meters)
        
        ImmersiveSpace(id: "CandyWorld") {
                    CandyWorldView()
        }
    }
}
//@main
//struct hack_spatial_rizki_sgApp: App {
//    @State private var appModel = AppModel()
//    var body: some Scene {
//        
//        
//        WindowGroup {
////            PlayCandyContentView()
////            MainContent()
//            PlayPlanetMainView()
//                .environment(appModel)
//                
//        }
//        .windowStyle(.volumetric)
//        .defaultSize(width: 2, height: 2, depth: 2, in: .meters)
//        ImmersiveSpace(id: appModel.immersiveSpaceID) {
//            ImmersiveView()
//                .environment(appModel)
//        }
//        ImmersiveSpace(id: "CandyWorld") {
//            CandyWorldView()
//        }
//        .immersionStyle(selection: .constant(.mixed), in: .mixed)
//    }
//    
//}

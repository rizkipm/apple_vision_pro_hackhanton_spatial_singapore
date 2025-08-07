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
        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
    }
    
}

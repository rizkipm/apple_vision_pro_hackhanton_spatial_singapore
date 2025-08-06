//
//  MainContent.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 07/08/25.
//


import SwiftUI
import RealityKit

struct MainContent: View {
    @State private var selectedTab = "Home"
    @State private var searchText = ""
    @State private var showSidebar = true
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background Environment
//                BackgroundEnvironmentView()
                
                HStack(spacing: 0) {
                    // Sidebar
                    if showSidebar {
                        SidebarView(selectedTab: $selectedTab)
                            .frame(width: 280)
                            .transition(.move(edge: .leading))
                    }
                    
                    // Main Content
                    MainContentView(selectedTab: selectedTab, searchText: $searchText)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: showSidebar)
    }
}

#Preview {
    MainContent()
}

//
//  MainContent.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 07/08/25.
//


//import SwiftUI
//
//// MARK: - Main Content View
//struct MainContent: View {
//    @State private var selectedTab = "Home"
//    @State private var searchText = ""
//    @State private var showFullPageGame = false
//    @State private var selectedGameType: GameType = .candy
//    
//    var body: some View {
//        GeometryReader { geometry in
//            if showFullPageGame {
//                // Full page game mode
//                FullPageGameView(
//                    gameType: selectedGameType,
//                    showFullPage: $showFullPageGame
//                )
//                .transition(.opacity)
//            } else {
//                // Normal mode with sidebar
//                HStack(spacing: 0) {
//                    // Sidebar
//                    SidebarView(selectedTab: $selectedTab)
//                        .frame(width: 280)
//                    
//                    // Main content area
//                    MainContentView(
//                        selectedTab: selectedTab,
//                        searchText: $searchText,
//                        showFullPageGame: $showFullPageGame,
//                        selectedGameType: $selectedGameType
//                    )
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                }
//            }
//        }
//        .background {
//            // Background gradient
//            LinearGradient(
//                gradient: Gradient(colors: [
//                    Color.black.opacity(0.9),
//                    Color.purple.opacity(0.3),
//                    Color.blue.opacity(0.2)
//                ]),
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//            .ignoresSafeArea()
//        }
//        .animation(.easeInOut(duration: 0.5), value: showFullPageGame)
//    }
//}
//
//#Preview {
//    MainContentView(selectedTab: <#String#>, searchText: <#Binding<String>#>)
//}
import SwiftUI
import RealityKit

struct MainContent: View {
    @State private var selectedTab = "Home"
    @State private var searchText = ""
    @State private var showSidebar = true
    @State private var showFullPageGame = false
    @State private var selectedGameType: GameType = .candy
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background Environment
                // BackgroundEnvironmentView()
                
                HStack(spacing: 0) {
                    // Sidebar
                    if showSidebar {
                        SidebarView(selectedTab: $selectedTab)
                            .frame(width: 280)
                            .transition(.move(edge: .leading))
                    }
                    
                    // Main Content with all required parameters
                    MainContentView(
                        selectedTab: selectedTab,
                        searchText: $searchText,
                        showFullPageGame: $showFullPageGame,
                        selectedGameType: $selectedGameType
                    )
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

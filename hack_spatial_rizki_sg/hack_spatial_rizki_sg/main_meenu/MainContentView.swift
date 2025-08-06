//
//  MainContentView.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 07/08/25.
//

import SwiftUI

struct MainContentView: View {
    let selectedTab: String
    @Binding var searchText: String
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HeaderView(searchText: $searchText)
            
            // Content based on selected tab
            ScrollView {
                switch selectedTab {
                case "Home":
                    HomeContentView()
                case "Games":
                    GamesContentView()
                case "About":
                    AboutContentView()
                case "Songs":
                    SongsContentView()
                case "MadeForYou":
                    MadeForYouContentView()
                default:
                    HomeContentView()
                }
            }
            .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct HeaderView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Text("Home")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "line.3.horizontal")
                    .font(.title2)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 40)
        .padding(.top, 30)
        .padding(.bottom, 20)
        
        // Search Bar
        HStack {
            Image(systemName: "mic.fill")
                .foregroundColor(.white.opacity(0.6))
            
            TextField("Voice Search", text: $searchText)
                .textFieldStyle(.plain)
                .font(.system(size: 16))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(.ultraThinMaterial)
                .opacity(0.3)
        )
        .padding(.horizontal, 40)
        .padding(.bottom, 30)
    }
}
//
//struct HomeContentView: View {
//    let games = [
//        GameItem(title: "Candy Planet", color: .pink, icon: "magnifyingglass"),
//        GameItem(title: "Zen Garden", color: .green, icon: "leaf.fill"),
//        GameItem(title: "Space Catcher", color: .blue, icon: "rocket.fill"),
//        GameItem(title: "Memory Bubbles", color: .orange, icon: "circle.grid.3x3"),
//        GameItem(title: "Artist Mode", color: .brown, icon: "paintbrush.fill"),
//        GameItem(title: "About Neuroscope", color: .blue, icon: "brain.head.profile")
//    ]
//    
//    var body: some View {
//        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
//            ForEach(games) { game in
//                GameCardView(game: game)
//            }
//        }
//        .padding(.bottom, 40)
//    }
//}
//
//struct GameItem: Identifiable {
//    let id = UUID()
//    let title: String
//    let color: Color
//    let icon: String
//}
//
//struct GameCardView: View {
//    let game: GameItem
//    @State private var isHovered = false
//    
//    var body: some View {
//        VStack(spacing: 16) {
//            // Icon container
//            RoundedRectangle(cornerRadius: 20)
//                .fill(game.color.gradient)
//                .frame(height: 120)
//                .overlay(
//                    Image(systemName: game.icon)
//                        .font(.system(size: 40, weight: .semibold))
//                        .foregroundColor(.white)
//                        .scaleEffect(isHovered ? 1.1 : 1.0)
//                        .animation(.easeInOut(duration: 0.2), value: isHovered)
//                )
//            
//            // Title
//            Text(game.title)
//                .font(.system(size: 16, weight: .semibold))
//                .foregroundColor(.white)
//                .multilineTextAlignment(.center)
//        }
//        .padding(16)
//        .frame(height: 200)
//        .background(
//            RoundedRectangle(cornerRadius: 20)
//                .fill(.ultraThinMaterial)
//                .opacity(0.6)
//        )
//        .scaleEffect(isHovered ? 1.05 : 1.0)
//        .animation(.easeInOut(duration: 0.2), value: isHovered)
//        .onHover { hovering in
//            isHovered = hovering
//        }
//        .hoverEffect(.lift)
//        .onTapGesture {
//            // Handle tap action
//            print("Tapped on \(game.title)")
//        }
//    }
//}


struct HomeContentView: View {
    let games = [
        GameItem(title: "Candy Planet", color: .pink, imageName: "candies"),
        GameItem(title: "Zen Garden", color: .green, imageName: "garden"),
        GameItem(title: "Space Catcher", color: .blue, imageName: "space"),
        GameItem(title: "Memory Bubbles", color: .orange, imageName: "memories"),
        GameItem(title: "Artist Mode", color: .brown, imageName: "paint"),
        GameItem(title: "About Neuroscope", color: .blue, imageName: "about_us")
    ]
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3),
                  spacing: 20) {
            ForEach(games) { game in
                GameCardView(game: game)
            }
        }
        .padding(.bottom, 40)
    }
}

struct GameItem: Identifiable {
    let id = UUID()
    let title: String
    let color: Color
    let imageName: String   // nama file image di Assets
}

struct GameCardView: View {
    let game: GameItem
    @State private var isHovered = false
    
    var body: some View {
        VStack(spacing: 16) {
            // Image container
            RoundedRectangle(cornerRadius: 20)
                .fill(game.color.gradient)
                .frame(height: 120)
                .overlay(
                    Image(game.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .opacity(isHovered ? 1.0 : 0.9)
                        .scaleEffect(isHovered ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 0.2), value: isHovered)
                )
            
            // Title
            Text(game.title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .padding(16)
        .frame(height: 200)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .opacity(0.6)
        )
        .scaleEffect(isHovered ? 1.05 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isHovered)
        .onHover { hovering in
            isHovered = hovering
        }
        .hoverEffect(.lift)
        .onTapGesture {
            print("Tapped on \(game.title)")
        }
    }
}

// Placeholder views for other tabs
struct GamesContentView: View {
    var body: some View {
        Text("Games Content")
            .font(.title)
            .foregroundColor(.white)
            .padding()
    }
}

struct AboutContentView: View {
    var body: some View {
        Text("About Content")
            .font(.title)
            .foregroundColor(.white)
            .padding()
    }
}

struct SongsContentView: View {
    var body: some View {
        Text("Songs Content")
            .font(.title)
            .foregroundColor(.white)
            .padding()
    }
}

struct MadeForYouContentView: View {
    var body: some View {
        Text("Made For You Content")
            .font(.title)
            .foregroundColor(.white)
            .padding()
    }
}

#Preview {
    MainContentView(selectedTab: "Home", searchText: .constant(""))
}

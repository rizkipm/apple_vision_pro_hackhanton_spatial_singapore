//
//  MainContentView.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 07/08/25.

import SwiftUI

// MARK: - Game Type Enum
enum GameType: CaseIterable {
    case candy, puzzle, memory, ballThrowing
    
    
    var title: String {
        switch self {
        case .ballThrowing: return "Catch The Ball"
        case .candy: return "Candy Rush"
        case .puzzle: return "Mind Puzzle"
        case .memory: return "Memory Game"
       
        }
    }
    
    var description: String {
        switch self {
        case .ballThrowing: return "Test your accuracy with ball throwing challenges"
        case .candy: return "Match colorful candies in this sweet adventure"
        case .puzzle: return "Solve challenging puzzles to unlock new levels"
        case .memory: return "Test and improve your memory skills"
       
        }
    }
    
    var icon: String {
        switch self {
        case .ballThrowing: return "basketball"
        case .candy: return "circle.hexagongrid.fill"
        case .puzzle: return "puzzlepiece.fill"
        case .memory: return "brain.head.profile"
        
        }
    }
    
    var color: Color {
        switch self {
        case .ballThrowing: return .orange
        case .candy: return .pink
        case .puzzle: return .blue
        case .memory: return .green
        
        }
    }
}

// MARK: - Main Content View
struct MainContentView: View {
    let selectedTab: String
    @Binding var searchText: String
    @Binding var showFullPageGame: Bool
    @Binding var selectedGameType: GameType
    @State private var showCandyPlanet = false
    @State private var showZenGarden = false
    @State private var showSpaceCatcher = false
    @State private var showMemoriesBuble = false
    @State private var showArtistMode = false
    @State private var showAbout = false
    @State private var showBallThrowingContent = false
    
    
    
    var body: some View {
        ZStack {
            if showCandyPlanet {
                // Full screen Candy Planet page - replaces everything
                CandyPlanetView(showCandyPlanet: $showCandyPlanet)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
                    .zIndex(7)
            } else if showZenGarden {
                // Full screen Zen Garden page - replaces everything
                ZenGardenView(showZenGarden: $showZenGarden)
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom).combined(with: .opacity),
                        removal: .move(edge: .top).combined(with: .opacity)
                    ))
                    .zIndex(7)
            }else if showSpaceCatcher {
                // Full screen Space Catcher page - replaces everything
                SpaceCatcherView(showSpaceCatcher: $showSpaceCatcher)
                    .transition(.asymmetric(
                        insertion: .move(edge: .top).combined(with: .opacity),
                        removal: .move(edge: .bottom).combined(with: .opacity)
                    ))
                    .zIndex(7)
            }else if showMemoriesBuble {
                // Full screen Space Catcher page - replaces everything
                MemoryBubblesView(showMemoriesBuble: $showMemoriesBuble)
                    .transition(.asymmetric(
                        insertion: .move(edge: .top).combined(with: .opacity),
                        removal: .move(edge: .bottom).combined(with: .opacity)
                    ))
                    .zIndex(7)
            }else if showArtistMode {
                // Full screen Space Catcher page - replaces everything
                ArtisticModeView(showArtistMode: $showArtistMode)
                    .transition(.asymmetric(
                        insertion: .move(edge: .top).combined(with: .opacity),
                        removal: .move(edge: .bottom).combined(with: .opacity)
                    ))
                    .zIndex(7)
            }else if showAbout {
                // Full screen Space Catcher page - replaces everything
                AboutUsView(showAbout: $showAbout)
                    .transition(.asymmetric(
                        insertion: .move(edge: .top).combined(with: .opacity),
                        removal: .move(edge: .bottom).combined(with: .opacity)
                    ))
                    .zIndex(7)
            }else if showBallThrowingContent {
                // Full screen Space Catcher page - replaces everything
                
                BallContentView(showBallThrowingContent: $showBallThrowingContent)
                                    .transition(.asymmetric(
                                        insertion: .move(edge: .bottom).combined(with: .opacity),
                                        removal: .move(edge: .top).combined(with: .opacity)
                                    ))
                                    .zIndex(7)
               
            } else {
                // Normal content with header and tabs
                VStack(spacing: 0) {
                    // Header
                    HeaderView(selectedTab: selectedTab, searchText: $searchText)
                    
                    // Content based on selected tab
                    ScrollView(.vertical, showsIndicators: false) {
                        switch selectedTab {
                        case "Home":
                            HomeContentView(showCandyPlanet: $showCandyPlanet, showZenGarden: $showZenGarden, showSpaceCatcher: $showSpaceCatcher, showMemoriesBubble: $showMemoriesBuble,
                                            showArtistMode: $showArtistMode, showAbout: $showAbout, )
                        case "Games":
                            GamesContentView(
                                showFullPageGame: $showFullPageGame,
                                selectedGameType: $selectedGameType,  showBallThrowing: $showBallThrowingContent
                            )
                        case "About":
                            AboutContentView()
                        case "Songs":
                            SongsContentView()
                        case "MadeForYou":
                            MadeForYouContentView()
                        default:
                            HomeContentView(showCandyPlanet: $showCandyPlanet, showZenGarden: $showZenGarden, showSpaceCatcher: $showSpaceCatcher, showMemoriesBubble: $showMemoriesBuble,
                                            showArtistMode: $showArtistMode, showAbout: $showAbout
                            )
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal, 40)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.asymmetric(
                    insertion: .move(edge: .leading).combined(with: .opacity),
                    removal: .move(edge: .trailing).combined(with: .opacity)
                ))
                .zIndex(1)
            }
        }
        .animation(.easeInOut(duration: 0.6), value: showCandyPlanet)
        .animation(.easeInOut(duration: 0.6), value: showZenGarden)
        .animation(.easeInOut(duration: 0.6), value: showSpaceCatcher)
        .animation(.easeInOut(duration: 0.6), value: showMemoriesBuble)
        .animation(.easeInOut(duration: 0.6), value: showArtistMode)
        .animation(.easeInOut(duration: 0.6), value: showAbout)
        .animation(.easeInOut(duration: 0.6), value: showBallThrowingContent)

    }
}

// MARK: - Header View (Updated)
struct HeaderView: View {
    let selectedTab: String
    @Binding var searchText: String
    
    var body: some View {
        VStack(spacing: 20) {
            // Top header with title and menu
            HStack {
                Text(selectedTab)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Spacer()
                
                HStack(spacing: 16) {
                    // Notifications
                    Button {
                        // Notifications action
                    } label: {
                        Image(systemName: "bell.fill")
                            .font(.title3)
                            .foregroundStyle(.white.opacity(0.8))
                    }
                    .buttonStyle(.borderless)
                    .hoverEffect(.lift)
                    
                    // Settings menu
                    Button {
                        // Menu action
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.borderless)
                    .hoverEffect(.lift)
                }
            }
            .padding(.horizontal, 40)
            .padding(.top, 30)
            
            // Search Bar
            HStack(spacing: 12) {
                Image(systemName: "mic.fill")
                    .font(.title3)
                    .foregroundStyle(.white.opacity(0.6))
                
                TextField("Voice Search or type to find games...", text: $searchText)
                    .textFieldStyle(.plain)
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                    .placeholder(when: searchText.isEmpty) {
                        Text("Voice Search or type to find games...")
                            .foregroundStyle(.white.opacity(0.5))
                    }
                
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.white.opacity(0.6))
                    }
                    .buttonStyle(.borderless)
                }
                
                Button {
                    // Search action
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white.opacity(0.6))
                }
                .buttonStyle(.borderless)
                .hoverEffect(.lift)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.ultraThinMaterial.opacity(0.3))
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(.white.opacity(0.1), lineWidth: 1)
                    }
            }
            .padding(.horizontal, 40)
        }
        .padding(.bottom, 30)
    }
}

// MARK: - Home Content View (Updated)
struct HomeContentView: View {
    @Binding var showCandyPlanet: Bool
    @Binding var showZenGarden: Bool
    @Binding var showSpaceCatcher: Bool
    @Binding var showMemoriesBubble: Bool
    @Binding var showArtistMode: Bool
    @Binding var showAbout: Bool
    
    let games = [
            GameItem(title: "Candy Planet", color: .pink, imageName: "candies"),
            GameItem(title: "Zen Garden", color: .green, imageName: "garden"),
            GameItem(title: "Space Catcher", color: .blue, imageName: "space"),
            GameItem(title: "Memory Bubbles", color: .orange, imageName: "memories"),
            GameItem(title: "Artist Mode", color: .brown, imageName: "paint"),
            GameItem(title: "About Neuroscope", color: .blue, imageName: "about_us")
        ]
    
    var body: some View {
        VStack(spacing: 32) {
            // Welcome section for Home tab
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome back!")
                            .font(.title2)
                            .foregroundStyle(.white.opacity(0.8))
                        
                        Text("Ready for your next challenge?")
                            .font(.headline)
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                    
                    // Quick stats
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Level 12")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.yellow)
                        
                        Text("2,450 XP")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                }
            }
            .padding(.top, 20)
            
            // Games grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
                ForEach(games) { game in
                    GameCardView(
                        game: game,
                        onTap: {
                            handleGameTap(game: game)
                        }
                    )
                }
            }
            
            
            
            Spacer(minLength: 40)
        }
        .padding(.bottom, 40)
    }
    
    private func handleGameTap(game: GameItem) {
        print("Tapped on \(game.title)")
        
        // Navigate to specific game based on title
        switch game.title {
        case "Candy Planet":
            withAnimation(.easeInOut(duration: 0.6)) {
                showCandyPlanet = true
            }
        case "Zen Garden":
            
            withAnimation(.easeInOut(duration: 0.6)) {
                showZenGarden = true
            }
            print("Navigate to Zen Garden")
        case "Space Catcher":
            withAnimation(.easeInOut(duration: 0.6)) {
                            showSpaceCatcher = true
            }
            print("Navigate to Space Catcher")
        case "Memory Bubbles":
            withAnimation(.easeInOut(duration: 0.6)) {
                showMemoriesBubble = true
            }
            print("Navigate to Memory Bubbles")
        case "Artist Mode":
            withAnimation(.easeInOut(duration: 0.6)) {
                showArtistMode = true
            }
            print("Navigate to Artist Mode")
        case "About Neuroscope":
            withAnimation(.easeInOut(duration: 0.6)) {
                showAbout = true
            }
            print("Navigate to About Neuroscope")
        default:
            print("Unknown game: \(game.title)")
        }
    }
}

// MARK: - Game Item Model
struct GameItem: Identifiable {
    let id = UUID()
    let title: String
    let color: Color
    let imageName: String   // nama file image di Assets
}

// MARK: - Game Card View
struct GameCardView: View {
    let game: GameItem
    let onTap: () -> Void
    @State private var isHovered = false
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 16) {
                // Image container
                RoundedRectangle(cornerRadius: 20)
                    .fill(game.color.gradient)
                    .frame(height: 120)
                    .overlay(
                        ZStack {
                            // Fallback icon if image not available
//                            Image(systemName: gameIcon(for: game.title))
//                                .font(.system(size: 40))
//                                .foregroundStyle(.white.opacity(0.8))
                            
//                             Custom image (uncomment when assets are available)
                             Image(game.imageName)
                                 .resizable()
                                 .scaledToFit()
                                 .frame(width: 100, height: 100)
                        }
                        .opacity(isHovered ? 1.0 : 0.9)
                        .scaleEffect(isHovered ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 0.2), value: isHovered)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                    }
                
                // Title with special indicator for Candy Planet
                HStack {
                    Text(game.title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    if game.title == "Candy Planet" {
                        Image(systemName: "sparkles")
                            .font(.caption)
                            .foregroundColor(.yellow)
                    }else if game.title == "Zen Garden" {
                        Image(systemName: "leaf.fill")
                            .font(.caption)
                            .foregroundColor(.green)
                    }else if game.title == "Space Catcher" {
                        Image(systemName: "globe")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }else if game.title == "Memory Bubbles" {
                        Image(systemName: "brain.head.profile")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }else if game.title == "Artist Mode" {
                        Image(systemName: "paintbrush.fill")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }else if game.title == "About Neuroscope" {
                        Image(systemName: "info.circle.fill")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(16)
            .frame(height: 200)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .opacity(0.6)
                    .overlay {
                        if game.title == "Candy Planet" {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.pink, .orange]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                        }else if game.title == "Zen Garden" {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.green, .blue]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                        }else if game.title == "Space Catcher" {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.blue, .purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                        }else if game.title == "Memory Bubbles" {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.blue, .purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                        }else if game.title == "Artist Mode" {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.blue, .purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                        }else if game.title == "About Neuroscope" {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.blue, .purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                        }
                    }
            )
            .scaleEffect(isHovered ? 1.05 : 1.0)
            .shadow(color: game.color.opacity(0.3), radius: isHovered ? 15 : 8)
        }
        .buttonStyle(.borderless)
        .hoverEffect(.lift)
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovered = hovering
            }
        }
    }
    
    private func gameIcon(for title: String) -> String {
        switch title {
        case "Candy Planet": return "circle.hexagongrid.fill"
        case "Zen Garden": return "leaf.fill"
        case "Space Catcher": return "globe"
        case "Memory Bubbles": return "brain.head.profile"
        case "Artist Mode": return "paintbrush.fill"
        case "About Neuroscope": return "info.circle.fill"
        default: return "gamecontroller.fill"
        }
    }
}

// MARK: - Navigation State
class NavigationState: ObservableObject {
    @Published var selectedGame: GameType? = nil
    @Published var showingBallThrowing = false
    
    func selectGame(_ gameType: GameType) {
        selectedGame = gameType
        if gameType == .ballThrowing {
            showingBallThrowing = true
        }
    }
}


// MARK: - Enhanced Content Views for Other Tabs
//struct GamesContentView: View {
//    @Binding var showFullPageGame: Bool
//    @Binding var selectedGameType: GameType
//    @Binding var showBallThrowing: Bool
//    
//    var body: some View {
//        VStack(spacing: 24) {
//            Text("All Games Collection")
//                .font(.title2)
//                .fontWeight(.bold)
//                .foregroundStyle(.white)
//                .padding(.top, 20)
//            
//            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 4), spacing: 20) {
//                ForEach(GameType.allCases, id: \.self) { gameType in
//                    GameTypeCardView(
//                        gameType: gameType,
//                        action: {
//                            selectedGameType = gameType
//                            showFullPageGame = true
//                        }
//                    )
//                }
//            }
//            
//            Spacer()
//        }
//        .padding(.bottom, 40)
//    }
//}

// MARK: - Enhanced Content Views for Other Tabs
struct GamesContentView: View {
    @Binding var showFullPageGame: Bool
    @Binding var selectedGameType: GameType
    @Binding var showBallThrowing: Bool  // Added Ball Throwing binding
    
    
    var body: some View {
        VStack(spacing: 24) {
            Text("All Games Collection")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 4), spacing: 20) {
                ForEach(GameType.allCases, id: \.self) { gameType in
                    GameTypeCardView(
                        gameType: gameType,
                        action: {
                            selectedGameType = gameType
                            
                            // Check if it's Ball Throwing game
                            if gameType == .ballThrowing {
                                withAnimation(.easeInOut(duration: 0.6)) {
                                                                   showBallThrowing = true  // Ubah ini
                                                    }
                                        print("Navigate to Ball Content View")
//                                withAnimation(.easeInOut(duration: 0.6)) {
//                                    showPlayBall = true
//                                    
//                                    BallContentView(showBallThrowingContent: true)
//                                    print("Ini page ball")
////                                    BallContentView(showBallThrowing: true)
//                                ?}
                            } else {
                                showFullPageGame = true
                            }
                        }
                    )
                }
            }
            
            Spacer()
        }
        .padding(.bottom, 40)
    }
}


struct GameTypeCardView: View {
    let gameType: GameType
    let action: () -> Void
    @State private var isHovered = false
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: gameType.icon)
                    .font(.system(size: 32))
                    .foregroundStyle(gameType.color)
                
                Text(gameType.title)
                    .font(.headline)
                    .foregroundStyle(.white)
                
                Text(gameType.description)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
            }
            .padding(20)
            .frame(height: 160)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial.opacity(0.3))
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(gameType.color.opacity(0.3), lineWidth: 1)
                    }
            }
            .scaleEffect(isHovered ? 1.05 : 1.0)
        }
        .buttonStyle(.borderless)
        .hoverEffect(.lift)
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovered = hovering
            }
        }
    }
}

struct AboutContentView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("About Catchiverse")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)
            
            Text("Train your eyes and challenge your brain with our collection of engaging games designed to improve cognitive abilities.")
                .font(.body)
                .foregroundStyle(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct SongsContentView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("Game Soundtracks")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)
            
            Text("Immersive audio experiences for enhanced gaming.")
                .font(.body)
                .foregroundStyle(.white.opacity(0.8))
                .multilineTextAlignment(.center)
            
            Spacer()
        }
    }
}

struct MadeForYouContentView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("Personalized Experience")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)
            
            Text("Games and challenges tailored specifically for your skill level and preferences.")
                .font(.body)
                .foregroundStyle(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

// MARK: - TextField Placeholder Extension
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}



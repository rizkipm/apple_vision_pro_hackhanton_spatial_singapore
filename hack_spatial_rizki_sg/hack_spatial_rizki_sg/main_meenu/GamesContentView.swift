////
////  GamesContentView.swift
////  hack_spatial_rizki_sg
////
////  Created by NUS on 7/8/25.
////
//
//import SwiftUI
//
//// MARK: - Games Content View
//struct GamesContentView: View {
//    @Binding var showFullPageGame: Bool
//    @Binding var selectedGameType: GameType
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
//
//// MARK: - Game Type Card View
//struct GameTypeCardView: View {
//    let gameType: GameType
//    let action: () -> Void
//    @State private var isHovered = false
//    
//    var body: some View {
//        Button(action: action) {
//            VStack(spacing: 12) {
//                Image(systemName: gameType.icon)
//                    .font(.system(size: 32))
//                    .foregroundStyle(gameType.color)
//                
//                Text(gameType.title)
//                    .font(.headline)
//                    .foregroundStyle(.white)
//                
//                Text(gameType.description)
//                    .font(.caption)
//                    .foregroundStyle(.white.opacity(0.7))
//                    .multilineTextAlignment(.center)
//                    .lineLimit(3)
//            }
//            .padding(20)
//            .frame(height: 160)
//            .background {
//                RoundedRectangle(cornerRadius: 16)
//                    .fill(.ultraThinMaterial.opacity(0.3))
//                    .overlay {
//                        RoundedRectangle(cornerRadius: 16)
//                            .stroke(gameType.color.opacity(0.3), lineWidth: 1)
//                    }
//            }
//            .scaleEffect(isHovered ? 1.05 : 1.0)
//        }
//        .buttonStyle(.borderless)
//        .hoverEffect(.lift)
//        .onHover { hovering in
//            withAnimation(.easeInOut(duration: 0.2)) {
//                isHovered = hovering
//            }
//        }
//    }
//}
//
//// MARK: - About Content View
//struct AboutContentView: View {
//    var body: some View {
//        VStack(spacing: 24) {
//            Text("About Catchiverse")
//                .font(.title)
//                .fontWeight(.bold)
//                .foregroundStyle(.white)
//                .padding(.top, 20)
//            
//            Text("Train your eyes and challenge your brain with our collection of engaging games designed to improve cognitive abilities.")
//                .font(.body)
//                .foregroundStyle(.white.opacity(0.8))
//                .multilineTextAlignment(.center)
//                .padding(.horizontal, 40)
//            
//            // Feature highlights
//            VStack(spacing: 16) {
//                FeatureRow(
//                    icon: "eye.fill",
//                    title: "Visual Training",
//                    description: "Enhance visual perception and focus"
//                )
//                
//                FeatureRow(
//                    icon: "brain.head.profile",
//                    title: "Cognitive Enhancement",
//                    description: "Improve memory, attention, and processing speed"
//                )
//                
//                FeatureRow(
//                    icon: "chart.line.uptrend.xyaxis",
//                    title: "Progress Tracking",
//                    description: "Monitor your improvement over time"
//                )
//            }
//            .padding(.top, 40)
//            
//            Spacer()
//        }
//    }
//}
//
//// MARK: - Feature Row
//struct FeatureRow: View {
//    let icon: String
//    let title: String
//    let description: String
//    
//    var body: some View {
//        HStack(spacing: 16) {
//            Image(systemName: icon)
//                .font(.title2)
//                .foregroundStyle(.blue)
//                .frame(width: 40)
//            
//            VStack(alignment: .leading, spacing: 4) {
//                Text(title)
//                    .font(.headline)
//                    .foregroundStyle(.white)
//                
//                Text(description)
//                    .font(.body)
//                    .foregroundStyle(.white.opacity(0.7))
//            }
//            
//            Spacer()
//        }
//        .padding(.horizontal, 40)
//    }
//}
//
//// MARK: - Songs Content View
//struct SongsContentView: View {
//    var body: some View {
//        VStack(spacing: 24) {
//            Text("Game Soundtracks")
//                .font(.title)
//                .fontWeight(.bold)
//                .foregroundStyle(.white)
//                .padding(.top, 20)
//            
//            Text("Immersive audio experiences for enhanced gaming.")
//                .font(.body)
//                .foregroundStyle(.white.opacity(0.8))
//                .multilineTextAlignment(.center)
//            
//            // Music categories
//            VStack(spacing: 16) {
//                MusicCategoryRow(
//                    title: "Focus & Concentration",
//                    description: "Ambient sounds for better focus",
//                    icon: "brain.head.profile",
//                    color: .blue
//                )
//                
//                MusicCategoryRow(
//                    title: "Energy Boost",
//                    description: "Upbeat tracks for active games",
//                    icon: "bolt.fill",
//                    color: .orange
//                )
//                
//                MusicCategoryRow(
//                    title: "Relaxation",
//                    description: "Calming melodies for stress relief",
//                    icon: "leaf.fill",
//                    color: .green
//                )
//            }
//            .padding(.top, 40)
//            
//            Spacer()
//        }
//    }
//}
//
//// MARK: - Music Category Row
//struct MusicCategoryRow: View {
//    let title: String
//    let description: String
//    let icon: String
//    let color: Color
//    
//    var body: some View {
//        HStack(spacing: 16) {
//            Image(systemName: icon)
//                .font(.title2)
//                .foregroundStyle(color)
//                .frame(width: 40)
//            
//            VStack(alignment: .leading, spacing: 4) {
//                Text(title)
//                    .font(.headline)
//                    .foregroundStyle(.white)
//                
//                Text(description)
//                    .font(.body)
//                    .foregroundStyle(.white.opacity(0.7))
//            }
//            
//            Spacer()
//            
//            Button {
//                // Play action
//            } label: {
//                Image(systemName: "play.circle.fill")
//                    .font(.title)
//                    .foregroundStyle(color)
//            }
//            .buttonStyle(.borderless)
//            .hoverEffect(.lift)
//        }
//        .padding(.horizontal, 40)
//    }
//}
//
//// MARK: - Made For You Content View
//struct MadeForYouContentView: View {
//    var body: some View {
//        VStack(spacing: 24) {
//            Text("Personalized Experience")
//                .font(.title)
//                .fontWeight(.bold)
//                .foregroundStyle(.white)
//                .padding(.top, 20)
//            
//            Text("Games and challenges tailored specifically for your skill level and preferences.")
//                .font(.body)
//                .foregroundStyle(.white.opacity(0.8))
//                .multilineTextAlignment(.center)
//                .padding(.horizontal, 40)
//            
//            // Personalization features
//            VStack(spacing: 20) {
//                PersonalizationCard(
//                    title: "Adaptive Difficulty",
//                    description: "Game difficulty adjusts based on your performance",
//                    icon: "slider.horizontal.3",
//                    color: .purple
//                )
//                
//                PersonalizationCard(
//                    title: "Custom Challenges",
//                    description: "Receive challenges based on your weak areas",
//                    icon: "target",
//                    color: .red
//                )
//                
//                PersonalizationCard(
//                    title: "Learning Path",
//                    description: "Follow a personalized curriculum designed for you",
//                    icon: "map.fill",
//                    color: .green
//                )
//            }
//            .padding(.top, 30)
//            
//            Spacer()
//        }
//    }
//}
//
//// MARK: - Personalization Card
//struct PersonalizationCard: View {
//    let title: String
//    let description: String
//    let icon: String
//    let color: Color
//    
//    @State private var isHovered = false
//    
//    var body: some View {
//        HStack(spacing: 16) {
//            Image(systemName: icon)
//                .font(.title)
//                .foregroundStyle(color)
//                .frame(width: 50, height: 50)
//                .background {
//                    Circle()
//                        .fill(color.opacity(0.2))
//                }
//            
//            VStack(alignment: .leading, spacing: 6) {
//                Text(title)
//                    .font(.headline)
//                    .foregroundStyle(.white)
//                
//                Text(description)
//                    .font(.body)
//                    .foregroundStyle(.white.opacity(0.7))
//                    .fixedSize(horizontal: false, vertical: true)
//            }
//            
//            Spacer()
//        }
//        .padding(20)
//        .background {
//            RoundedRectangle(cornerRadius: 16)
//                .fill(.ultraThinMaterial.opacity(0.2))
//                .overlay {
//                    RoundedRectangle(cornerRadius: 16)
//                        .stroke(color.opacity(0.3), lineWidth: 1)
//                }
//        }
//        .scaleEffect(isHovered ? 1.02 : 1.0)
//        .onHover { hovering in
//            withAnimation(.easeInOut(duration: 0.15)) {
//                isHovered = hovering
//            }
//        }
//        .padding(.horizontal, 40)
//    }
//}
//
//#Preview("Games") {
//    GamesContentView
//    .background(Color.black)
//}
//
//#Preview("About") {
//    AboutContentView()
//        .background(Color.black)
//}

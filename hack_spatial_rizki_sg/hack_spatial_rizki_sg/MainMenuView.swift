//
//  MainMenuView.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 06/08/25.
//
//import SwiftUI
//
//// MARK: - Page Enum
//
//enum Page {
//    case menu, candy, zen, space, memory, artistic
//}
//
//
//
//// MARK: - MainMenuView
//
//struct MainMenuView: View {
//    @State private var currentPage: Page = .menu
//
//    var body: some View {
//        ZStack {
//            Color.black.opacity(0.8).ignoresSafeArea()
//
//            switch currentPage {
//            case .menu:
//                MenuPage { page in
//                    withAnimation { currentPage = page }
//                }
//            case .candy:
//                LandingPageView(
//                    title: "🧁 Candy Planet",
//                    description: """
//A colorful candy-themed world set in a fantasy landscape. Balls are replaced with oversized \
//sweets like lollipops and donuts. Ideal for attention therapy for kids with ADHD or sensory needs.
//""",
//                    ideas: [
//                        "Catch candy flying from different angles",
//                        "Bonus for catching “golden candy”",
//                        "Improve focus and coordination in a joyful, playful setting"
//                    ],
//                    onBack: { withAnimation { currentPage = .menu } }
//                )
//            case .zen:
//                LandingPageView(
//                    title: "🌳 Zen Garden",
//                    description: """
//A tranquil Japanese-style garden with calming music, bamboo, and flowing water. Slow-paced, \
//mindful exercises for elderly users or post-stroke recovery.
//""",
//                    ideas: [
//                        "Catch falling flower petals in slow motion",
//                        "Breathing/relaxation mini-practice before gameplay",
//                        "Reflex & depth training in a peaceful setting"
//                    ],
//                    onBack: { withAnimation { currentPage = .menu } }
//                )
//            case .space:
//                LandingPageView(
//                    title: "🚀 Space Catcher",
//                    description: """
//A futuristic outer space world. Players catch meteors, satellites, or mini-planets in \
//zero-gravity environments.
//""",
//                    ideas: [
//                        "Catch high-speed meteors",
//                        "Avoid black holes that mislead trajectory",
//                        "Competitive mode for fastest reaction time"
//                    ],
//                    onBack: { withAnimation { currentPage = .menu } }
//                )
//            case .memory:
//                LandingPageView(
//                    title: "🧠 Memory Bubbles",
//                    description: """
//An immersive world filled with floating memory bubbles. Each bubble contains an image or \
//sound cue—focus on spatial and working memory training.
//""",
//                    ideas: [
//                        "Catch bubbles → recall position → repeat",
//                        "Use click sounds as spatial memory guides",
//                        "Light therapy mode for dementia patients"
//                    ],
//                    onBack: { withAnimation { currentPage = .menu } }
//                )
//            case .artistic:
//                LandingPageView(
//                    title: "🎨 Artistic Mode",
//                    description: """
//An abstract world of vibrant shapes and colors. Balls turn into artistic objects and \
//interactive paint splashes—designed for creative expression.
//""",
//                    ideas: [
//                        "Catch color-coded shapes based on instruction",
//                        "Mix captures to create a digital painting",
//                        "Free expression meets sensory-motor control"
//                    ],
//                    onBack: { withAnimation { currentPage = .menu } }
//                )
//            }
//        }
//    }
//}
//
//// MARK: - MenuPage
//
//struct MenuPage: View {
//    let onSelect: (Page) -> Void
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Catchiverse 🌟")
//                .font(.largeTitle.weight(.bold))
//                .foregroundColor(.white)
//
//            Group {
//                Button("🧁 Candy Planet") { onSelect(.candy) }
//                    .menuButtonStyle(color: .pink)
//                Button("🌳 Zen Garden") { onSelect(.zen) }
//                    .menuButtonStyle(color: .green)
//                Button("🚀 Space Catcher") { onSelect(.space) }
//                    .menuButtonStyle(color: .indigo)
//                Button("🧠 Memory Bubbles") { onSelect(.memory) }
//                    .menuButtonStyle(color: .blue)
//                Button("🎨 Artistic Mode") { onSelect(.artistic) }
//                    .menuButtonStyle(color: .orange)
//            }
//        }
//        .padding(40)
//    }
//}
//
//// Reusable button style
//extension View {
//    func menuButtonStyle(color: Color) -> some View {
//        font(.headline)
//        .foregroundColor(.white)
//        .padding()
//        .frame(maxWidth: .infinity)
//        .background(color.opacity(0.8))
//        .cornerRadius(12)
//    }
//}
//
//// MARK: - LandingPageView
//
//struct LandingPageView: View {
//    let title: String
//    let description: String
//    let ideas: [String]
//    let onBack: () -> Void
//
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 24) {
//                // Back button
//                HStack {
//                    Button("← Back", action: onBack)
//                        .foregroundColor(.white)
//                        .padding()
//                    Spacer()
//                }
//
//                // Title
//                Text(title)
//                    .font(.title).bold()
//                    .foregroundColor(.white)
//                    .padding(.horizontal)
//
//                // Description
//                Text(description)
//                    .foregroundColor(.white.opacity(0.9))
//                    .padding(.horizontal)
//
//                // Ideas
//                VStack(alignment: .leading, spacing: 8) {
//                    Text("💡 Ideas:")
//                        .font(.headline)
//                        .foregroundColor(.yellow)
//                    ForEach(ideas, id: \.self) { idea in
//                        HStack(alignment: .top) {
//                            Text("•").foregroundColor(.white)
//                            Text(idea).foregroundColor(.white)
//                        }
//                    }
//                }
//                .padding()
//                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
//
//                // Start button
//                Button("Start Adventure") {
//                    // TODO: Launch game
//                }
//                .font(.headline)
//                .foregroundColor(.white)
//                .padding(.horizontal, 40)
//                .padding(.vertical, 12)
//                .background(Capsule().fill(Color.white.opacity(0.25)))
//            }
//            .padding()
//        }
//        .background(
//            LinearGradient(
//                gradient: Gradient(colors: [.pink, .purple, .blue]),
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//            .ignoresSafeArea()
//        )
//    }
//}
//
//// MARK: - Preview
//
//#Preview {
//    MainMenuView()
//}


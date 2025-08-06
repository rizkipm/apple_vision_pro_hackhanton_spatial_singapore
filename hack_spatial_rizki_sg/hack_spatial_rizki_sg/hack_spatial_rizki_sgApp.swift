//
//  hack_spatial_rizki_sgApp.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 05/08/25.
//

//import SwiftUI

//@main
//struct hack_spatial_rizki_sgApp: App {
////    var body: some Scene {
////            WindowGroup {
////                ContentView()
////                   .background(.black.opacity(0.8))
////            }
////        
////            WindowGroup(id: "CubeWindow") {
////                CubeModel3DView()
////            }
////            .defaultSize(width: 500, height: 500)
////            .windowStyle(.volumetric)
////                    .defaultSize(width: 0.6, height: 0.6, depth: 0.6, in: .meters)
////        
////            WindowGroup(id: "CandyPlanet") {
////                CandyPlanetLandingView()
////            }
////            
////
////
////            ImmersiveSpace(id: "Immersive") {
////                ContentView()
////            }
////        }
//    
//    var body: some Scene {
//            WindowGroup {
//                MainMenuView()
//                    .background(.black.opacity(0.8))
//            }
//            .windowStyle(.volumetric)
//            .defaultSize(width: 0.6, height: 0.6, depth: 0.6, in: .meters)
//        }
//}


import SwiftUI

// MARK: - Page Enum

enum Page {
    case menu, candy, zen, space, memory, artistic, about
}

// MARK: - App Entry Point

@main
struct hack_spatial_rizki_sgApp: App {
    var body: some Scene {
        WindowGroup {
            MainMenuView()
                .background(.black.opacity(0.8))
        }
        
        WindowGroup(id: "CandyPlanet") {
                        CandyPlanetLandingView()
        }
        
        ImmersiveSpace(id: "Immersive") {
                        MainMenuView()
        }
    }
}

// MARK: - MainMenuView

struct MainMenuView: View {
    
    @Environment(/*\<#Root#>.closeWindow) private var closeWindow: ()*/
    @State private var currentPage: Page = .menu
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @State private var isWindowOpen: Bool = false
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow

//

    var body: some View {
        ZStack {
            Color.white.opacity(0.8).ignoresSafeArea()

            // Pilih halaman berdasarkan state
            switch currentPage {
            case .menu:
                MenuPage { page in
                    withAnimation { currentPage = page }
                }
            case .candy:
                
                // buka window CandyPlanet
                               Color.clear.onAppear {
                                   openWindow(id: "CandyPlanet")
                                   currentPage = .menu
                                   dismissWindow()
                               }
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
            case .zen:
                
                LandingPageView(
                    title: "🌳 Zen Garden",
                    description: """
A tranquil Japanese-style garden with calming music, bamboo, and flowing water. Slow-paced, \
mindful exercises for elderly users or post-stroke recovery.
""",
                    ideas: [
                        "Catch falling flower petals in slow motion",
                        "Breathing/relaxation mini-practice before gameplay",
                        "Reflex & depth training in a peaceful setting"
                    ],
                    onBack: { withAnimation { currentPage = .menu } }
                )
            case .space:
                LandingPageView(
                    title: "🚀 Space Catcher",
                    description: """
A futuristic outer space world. Players catch meteors, satellites, or mini-planets in \
zero-gravity environments.
""",
                    ideas: [
                        "Catch high-speed meteors",
                        "Avoid black holes that mislead trajectory",
                        "Competitive mode for fastest reaction time"
                    ],
                    onBack: { withAnimation { currentPage = .menu } }
                )
            case .memory:
                LandingPageView(
                    title: "🧠 Memory Bubbles",
                    description: """
An immersive world filled with floating memory bubbles. Each bubble contains an image or \
sound cue—focus on spatial and working memory training.
""",
                    ideas: [
                        "Catch bubbles → recall position → repeat",
                        "Use click sounds as spatial memory guides",
                        "Light therapy mode for dementia patients"
                    ],
                    onBack: { withAnimation { currentPage = .menu } }
                )
            case .artistic:
                LandingPageView(
                    title: "🎨 Artistic Mode",
                    description: """
An abstract world of vibrant shapes and colors. Balls turn into artistic objects and \
interactive paint splashes—designed for creative expression.
""",
                    ideas: [
                        "Catch color-coded shapes based on instruction",
                        "Mix captures to create a digital painting",
                        "Free expression meets sensory-motor control"
                    ],
                    onBack: { withAnimation { currentPage = .menu } }
                )
            case .about:
                LandingPageView(
                    title: "🎨 About Us",
                    description: """
An abstract world of vibrant shapes and colors. Balls turn into artistic objects and \
interactive paint splashes—designed for creative expression.
""",
                    ideas: [
                        "Catch color-coded shapes based on instruction",
                        "Mix captures to create a digital painting",
                        "Free expression meets sensory-motor control"
                    ],
                    onBack: { withAnimation { currentPage = .menu } }
                )
            }
        }
    }
}

// MARK: - MenuPage

struct MenuPage: View {
    let onSelect: (Page) -> Void
    
    // 3 kolom fleksibel
//    private let columns = [
//        GridItem(.flexible(), spacing: 5),
//        GridItem(.flexible(), spacing: 5),
//        GridItem(.flexible(), spacing: 5),
//    ]
    
    private let columns = Array(
            repeating: GridItem(.flexible(), spacing: 12),
            count: 3
        )
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Catchiverse 🌟")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                LazyVGrid(columns: columns, alignment: .center, spacing: 12) {
                    MenuItem(icon: "🧁", title: "Candy\nPlanet", bgColor: .pink) {
                        onSelect(.candy)
                    }
                    MenuItem(icon: "🌳", title: "Zen\nGarden", bgColor: .green) {
                        onSelect(.zen)
                    }
                    MenuItem(icon: "🚀", title: "Space\nCatcher", bgColor: .indigo) {
                        onSelect(.space)
                    }
                    MenuItem(icon: "🧠", title: "Memory\nBubbles", bgColor: .blue) {
                        onSelect(.memory)
                    }
                    MenuItem(icon: "🎨", title: "Artistic\nMode", bgColor: .orange) {
                        onSelect(.artistic)
                    }
                    // Kotak baru About Us
                    MenuItem(icon: "ℹ️", title: "About\nUs", bgColor: .gray) {
                        onSelect(.about)
                    }
                }
                .padding(.horizontal, 20)
            }
//            .padding(.top, 10)
            
        }
    }
}

// MARK: - MenuItem

struct MenuItem: View {
    let icon: String
    let title: String
    let bgColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Text(icon)
                    .font(.system(size: 50))
                Text(title)
                    .font(.headline.weight(.semibold))
                    .multilineTextAlignment(.center)
            }
            .foregroundColor(.white)
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(bgColor.opacity(0.85))
            .cornerRadius(20)
            .shadow(color: bgColor.opacity(0.6), radius: 10, x: 0, y: 5)
            .aspectRatio(1, contentMode: .fit)   // Menjaga kotak 1:1
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

struct MenuPage_Previews: PreviewProvider {
    static var previews: some View {
        MenuPage { _ in }
    }
}


// Reusable button style
extension View {
    func menuButtonStyle(color: Color) -> some View {
        self
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color.opacity(0.8))
            .cornerRadius(12)
    }
}

// MARK: - LandingPageView

struct LandingPageView: View {
    let title: String
    let description: String
    let ideas: [String]
    let onBack: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Back button
                HStack {
                    Button("← Back", action: onBack)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }

                // Title
                Text(title)
                    .font(.title).bold()
                    .foregroundColor(.white)
                    .padding(.horizontal)

                // Description
                Text(description)
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.horizontal)

                // Ideas
                VStack(alignment: .leading, spacing: 8) {
                    Text("💡 Ideas:")
                        .font(.headline)
                        .foregroundColor(.yellow)
                    ForEach(ideas, id: \.self) { idea in
                        HStack(alignment: .top) {
                            Text("•").foregroundColor(.white)
                            Text(idea).foregroundColor(.white)
                        }
                    }
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))

                // Start button
                Button("Start Adventure") {
                    // TODO: Launch game
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 40)
                .padding(.vertical, 12)
                .background(Capsule().fill(Color.white.opacity(0.25)))
            }
            .padding()
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.pink, .purple, .blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
    }
}

// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}


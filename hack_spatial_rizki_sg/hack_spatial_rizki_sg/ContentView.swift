//
//  ContentView.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 05/08/25.
//

//import SwiftUI
//import RealityKit
//import RealityKitContent
//
//
//
//struct ContentView: View {
//    
//    @State private var isWindowOpen: Bool = false
//    @Environment(\.openWindow) private var openWindow
//    @Environment(\.dismissWindow) private var dismissWindow
//    
//    var body: some View {
//        
////        VStack{
////            Model3D(named: "DslrCamera", bundle: realityKitContentBundle)
////                .padding(.bottom)
////                
////        }
////        HStack{
////            Image("rizki")
////                .resizable()
////                .frame(width: 200, height: 300)
////                .padding()
////                .background(.gray.opacity(90))
////                .opacity(90)
////                .cornerRadius(10)
////                
////            Image("building")
////                .resizable()
////                .frame(width: 200, height: 300)
////                .padding()
////                .background(.gray.opacity(90))
////                .opacity(90)
////                .cornerRadius(10)
////            
////        }
//        
//        Button(isWindowOpen ? "Close Cube Window" : "Open Cube Window") {
//            if isWindowOpen {
//                dismissWindow(id: "CubeWindow")
//                isWindowOpen = false
//            } else {
//                openWindow(id: "CubeWindow")
//                isWindowOpen = true
//            }
//        }
//        
//    
////        HStack {
////            Text("Hello Everyone!, ")
////            Image(systemName: "hand.wave")
////            Text("I am Rizki Syaputra & I Love Photography")
////        }
////        .padding()
////        .background(.blue)
////        .opacity(50)
//    }
//    
////    var body: some View {
////        HStack {
////            Image(systemName: "face.smiling")
////            Text("Jia Chen")
////        }
////    }
////    var body: some View {
////        VStack {
////            Image(systemName: "face.smiling")
////                .imageScale(.large)
////                .foregroundStyle(.tint)
////            Text("Rizki Syaputra")
////        }
//        
////        VStack {
////            Text("I")
////            Image(systemName: "heart")
////            Text("SwiftUI")
////        }
////
//        
////        HStack {
////            Text("I")
////            Image(systemName: "heart")
////            Text("SwiftUI")
////        }
//        
////        HStack {
////            Text("I")
////            Image(systemName: "heart")
////            Text("SwiftUI")
////        }
//        
////        HStack {
////            Text("I")
////            Image(systemName: "heart")
////            Spacer()
////            Text("SwiftUI")
////        }
//        
////        VStack {
////            Model3D(named: "Scene", bundle: realityKitContentBundle)
////                .padding(.bottom, 50)
////
////            Text("Hello, I am Rizki Syapytra!!")
////        }
//        
//            
//        
////        .padding()
////    }
//}

//
//import SwiftUI
//import RealityKit
//import RealityKitContent
//
//struct ContentView: View {
//    @State private var isWindowOpen: Bool = false
//    @Environment(\.openWindow) private var openWindow
//    @Environment(\.dismissWindow) private var dismissWindow
//    
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 30) {
//                // Header Section
////                VStack(spacing: 10) {
////                    HStack {
////                        Text("Hello Everyone!")
////                        Image(systemName: "hand.wave")
////                        Text("I am Rizki Syaputra")
////                    }
////                    .font(.title2)
////                    .foregroundColor(.primary)
////                    
////                    Text("& I Love Photography")
////                        .font(.headline)
////                        .foregroundColor(.secondary)
////                }
////                .padding()
////                .background(.regularMaterial)
////                .cornerRadius(15)
//                
//                // Colorful Game/App Buttons Section
//                VStack(spacing: 20) {
//                    Text("Healthcare XR Experiences")
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                    
//                    // First row of buttons
//                    HStack(spacing: 15) {
//                        GameButton(
//                            title: "Candy\nPlanet",
//                            icon: "🍭",
//                            gradient: LinearGradient(
//                                colors: [Color.pink, Color.purple],
//                                startPoint: .topLeading,
//                                endPoint: .bottomTrailing
//                            )
//                        ) {
//                            // Action for Candy Planet
//                            print("Candy Planet tapped")
//                        }
//                        
//                        GameButton(
//                            title: "Zen\nGarden",
//                            icon: "🌳",
//                            gradient: LinearGradient(
//                                colors: [Color.green, Color.mint],
//                                startPoint: .topLeading,
//                                endPoint: .bottomTrailing
//                            )
//                        ) {
//                            // Action for Zen Garden
//                            print("Zen Garden tapped")
//                        }
//                        
//                        GameButton(
//                            title: "Space\nCatcher",
//                            icon: "🚀",
//                            gradient: LinearGradient(
//                                colors: [Color.purple, Color.blue],
//                                startPoint: .topLeading,
//                                endPoint: .bottomTrailing
//                            )
//                        ) {
//                            // Action for Space Catcher
//                            print("Space Catcher tapped")
//                        }
//                    }
//                    
//                    // Second row of buttons
//                    HStack(spacing: 15) {
//                        GameButton(
//                            title: "Memory\nBubbles",
//                            icon: "🧠",
//                            gradient: LinearGradient(
//                                colors: [Color.blue, Color.cyan],
//                                startPoint: .topLeading,
//                                endPoint: .bottomTrailing
//                            )
//                        ) {
//                            // Action for Memory Bubbles
//                            print("Memory Bubbles tapped")
//                        }
//                        
//                        GameButton(
//                            title: "Artistic\nMode",
//                            icon: "🎨",
//                            gradient: LinearGradient(
//                                colors: [Color.orange, Color.yellow],
//                                startPoint: .topLeading,
//                                endPoint: .bottomTrailing
//                            )
//                        ) {
//                            // Action for Artistic Mode
//                            print("Artistic Mode tapped")
//                        }
//                        
//                        // Placeholder button to balance the layout
//                        GameButton(
//                            title: "Coming\nSoon",
//                            icon: "✨",
//                            gradient: LinearGradient(
//                                colors: [Color.gray, Color.secondary],
//                                startPoint: .topLeading,
//                                endPoint: .bottomTrailing
//                            )
//                        ) {
//                            // Action for Coming Soon
//                            print("Coming Soon tapped")
//                        }
//                    }
//                }
//                
//                // Interactive Cube Section
////                VStack(spacing: 15) {
////                    Text("Interactive 3D Experience")
////                        .font(.headline)
////                    
////                    Button(action: {
////                        if isWindowOpen {
////                            dismissWindow(id: "CubeWindow")
////                            isWindowOpen = false
////                        } else {
////                            openWindow(id: "CubeWindow")
////                            isWindowOpen = true
////                        }
////                    }) {
////                        HStack {
////                            Image(systemName: isWindowOpen ? "cube.fill" : "cube")
////                            Text(isWindowOpen ? "Close Cube Window" : "Open Interactive Cube")
////                        }
////                        .padding(.horizontal, 20)
////                        .padding(.vertical, 12)
////                        .background(isWindowOpen ? .red : .blue)
////                        .foregroundColor(.white)
////                        .cornerRadius(25)
////                    }
////                    .buttonStyle(.plain)
////                    
////                    if isWindowOpen {
////                        Text("Cube window is now open!")
////                            .font(.caption)
////                            .foregroundColor(.green)
////                    }
////                }
////                
//                Spacer()
//                
//                // Footer
//                HStack {
//                    Image(systemName: "heart.fill")
//                        .foregroundColor(.red)
//                    Text("Made with SwiftUI & RealityKit By Neuroscape Team 8")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                }
//            }
//            .padding()
//            .navigationTitle("Catchiverse XR in Healthcare")
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//    }
//}
//
//struct GameButton: View {
//    let title: String
//    let icon: String
//    let gradient: LinearGradient
//    let action: () -> Void
//    
//    @State private var isPressed = false
//    
//    var body: some View {
//        Button(action: action) {
//            VStack(spacing: 8) {
//                Text(icon)
//                    .font(.system(size: 30))
//                
//                Text(title)
//                    .font(.system(size: 14, weight: .semibold))
//                    .multilineTextAlignment(.center)
//                    .foregroundColor(.white)
//            }
//            .frame(width: 100, height: 100)
//            .background(gradient)
//            .cornerRadius(20)
//            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
//            .scaleEffect(isPressed ? 0.95 : 1.0)
//            .animation(.easeInOut(duration: 0.1), value: isPressed)
//        }
//        .buttonStyle(.plain)
//        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity) { isPressing in
//            isPressed = isPressing
//        } perform: {
//            // Long press action if needed
//        }
//    }
//}
//
//#Preview(windowStyle: .automatic) {
//    ContentView()
//}


import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @State private var isWindowOpen: Bool = false
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    
                    // Main Content - Centered
                    VStack(spacing: 40) {
                        // Title Section
                        VStack(spacing: 12) {
                            Text("Healthcare XR Experiences")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)
                        }
                        
                        // Game Buttons Grid - Perfectly Centered
                        VStack(spacing: 20) {
                            // First row of buttons
                            HStack(spacing: 20) {
                                GameButton(
                                    title: "Candy\nPlanet",
                                    icon: "🍭",
                                    gradient: LinearGradient(
                                        colors: [Color.pink, Color.purple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                ) {
                                    openWindow(id: "CandyPlanet")
                                    print("Candy Planet tapped")
                                }
                                
                                GameButton(
                                    title: "Zen\nGarden",
                                    icon: "🌳",
                                    gradient: LinearGradient(
                                        colors: [Color.green, Color.mint],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                ) {
                                    print("Zen Garden tapped")
                                }
                                
                                GameButton(
                                    title: "Space\nCatcher",
                                    icon: "🚀",
                                    gradient: LinearGradient(
                                        colors: [Color.purple, Color.blue],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                ) {
                                    print("Space Catcher tapped")
                                }
                            }
                            
                            // Second row of buttons
                            HStack(spacing: 20) {
                                GameButton(
                                    title: "Memory\nBubbles",
                                    icon: "🧠",
                                    gradient: LinearGradient(
                                        colors: [Color.blue, Color.cyan],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                ) {
                                    
                                    openWindow(id: "CubeWindow")
//                                    Task {
//                                                await openImmersiveSpace(id: "CubeWindow")
//                                            }
                                    print("Memory Bubbles tapped")
                                }
                                
                                GameButton(
                                    title: "Artistic\nMode",
                                    icon: "🎨",
                                    gradient: LinearGradient(
                                        colors: [Color.orange, Color.yellow],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                ) {
                                    print("Artistic Mode tapped")
                                }
                                
                                GameButton(
                                    title: "About Us\nSoon",
                                    icon: "✨",
                                    gradient: LinearGradient(
                                        colors: [Color.gray, Color.secondary],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                ) {
                                    print("About Us tapped")
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    // Footer - Always at bottom
                    VStack(spacing: 8) {
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                            Text("Made with SwiftUI & RealityKit By Neuroscape Team 8")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.bottom, 20)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .navigationTitle("Catchiverse XR in Healthcare")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct GameButton: View {
    let title: String
    let icon: String
    let gradient: LinearGradient
    let action: () -> Void
    
    @State private var isPressed = false
    @State private var isHovered = false
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Text(icon)
                    .font(.system(size: 35))
                
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .lineLimit(2)
            }
            .frame(width: 120, height: 120)
            .background(gradient)
            .cornerRadius(25)
            .shadow(color: .black.opacity(0.3), radius: isHovered ? 12 : 8, x: 0, y: isHovered ? 6 : 4)
            .scaleEffect(isPressed ? 0.92 : (isHovered ? 1.05 : 1.0))
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isHovered)
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            isHovered = hovering
        }
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity) { isPressing in
            isPressed = isPressing
        } perform: {
            // Long press action if needed
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}

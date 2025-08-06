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


import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var isWindowOpen: Bool = false
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Header Section
                VStack(spacing: 10) {
                    HStack {
                        Text("Hello Everyone!")
                        Image(systemName: "hand.wave")
                        Text("I am Rizki Syaputra")
                    }
                    .font(.title2)
                    .foregroundColor(.primary)
                    
                    Text("& I Love Photography")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(.regularMaterial)
                .cornerRadius(15)
                
                // 3D Model Section (uncomment if you have the model)
                /*
                VStack {
                    Text("DSLR Camera Model")
                        .font(.headline)
                        .padding(.bottom, 10)
                    
                    Model3D(named: "DslrCamera", bundle: realityKitContentBundle)
                        .frame(height: 200)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                }
                */
                
                // Photo Gallery Section (uncomment if you have the images)
                /*
                VStack {
                    Text("Photo Gallery")
                        .font(.headline)
                        .padding(.bottom, 10)
                    
                    HStack(spacing: 15) {
                        Image("rizki")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 5)
                            
                        Image("building")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 5)
                    }
                }
                */
                
                // Interactive Cube Section
                VStack(spacing: 15) {
                    Text("Interactive 3D Experience")
                        .font(.headline)
                    
                    Button(action: {
                        if isWindowOpen {
                            dismissWindow(id: "CubeWindow")
                            isWindowOpen = false
                        } else {
                            openWindow(id: "CubeWindow")
                            isWindowOpen = true
                        }
                    }) {
                        HStack {
                            Image(systemName: isWindowOpen ? "cube.fill" : "cube")
                            Text(isWindowOpen ? "Close Cube Window" : "Open Interactive Cube")
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(isWindowOpen ? .red : .blue)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                    }
                    .buttonStyle(.plain)
                    
                    if isWindowOpen {
                        Text("Cube window is now open!")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }
                
                Spacer()
                
                // Footer
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("Made with SwiftUI & RealityKit")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .navigationTitle("Rizki's Portfolio")
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Untuk compatibility
    }
}
#Preview(windowStyle: .automatic) {
    ContentView()
}

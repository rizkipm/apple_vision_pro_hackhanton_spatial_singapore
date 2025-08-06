//
//  ContentView.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 05/08/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    var body: some View {
        
        VStack{
            Model3D(named: "DslrCamera", bundle: realityKitContentBundle)
                .padding(.bottom)
                
        }
        HStack{
            Image("rizki")
                .resizable()
                .frame(width: 200, height: 300)
                .padding()
                .background(.gray.opacity(90))
                .opacity(90)
                .cornerRadius(10)
                
            Image("building")
                .resizable()
                .frame(width: 200, height: 300)
                .padding()
                .background(.gray.opacity(90))
                .opacity(90)
                .cornerRadius(10)
            
        }
        
    
        HStack {
            Text("Hello Everyone!, ")
            Image(systemName: "hand.wave")
            Text("I am Rizki Syaputra & I Love Photography")
        }
        .padding()
        .background(.blue)
        .opacity(50)
    }
    
//    var body: some View {
//        HStack {
//            Image(systemName: "face.smiling")
//            Text("Jia Chen")
//        }
//    }
//    var body: some View {
//        VStack {
//            Image(systemName: "face.smiling")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Rizki Syaputra")
//        }
        
//        VStack {
//            Text("I")
//            Image(systemName: "heart")
//            Text("SwiftUI")
//        }
//
        
//        HStack {
//            Text("I")
//            Image(systemName: "heart")
//            Text("SwiftUI")
//        }
        
//        HStack {
//            Text("I")
//            Image(systemName: "heart")
//            Text("SwiftUI")
//        }
        
//        HStack {
//            Text("I")
//            Image(systemName: "heart")
//            Spacer()
//            Text("SwiftUI")
//        }
        
//        VStack {
//            Model3D(named: "Scene", bundle: realityKitContentBundle)
//                .padding(.bottom, 50)
//
//            Text("Hello, I am Rizki Syapytra!!")
//        }
        
            
        
//        .padding()
//    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}

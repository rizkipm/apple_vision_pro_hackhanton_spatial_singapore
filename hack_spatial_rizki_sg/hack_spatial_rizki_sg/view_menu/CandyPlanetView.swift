//
//  CandyPlanetView.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 06/08/25.
//
import SwiftUI

struct CandyPlanetLandingView: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            // 1. Background gradient cerah
            LinearGradient(
                gradient: Gradient(colors: [.pink, .purple, .blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // 2. Floating candy icons
            ForEach(0..<8) { i in
                CandyIcon(offset: CGFloat(i) * 50, delay: Double(i) * 0.3)
            }
            
            // 3. Content utama: deskripsi, bullet ideas, title, button
            VStack(spacing: 24) {
                // Deskripsi singkat
                VStack(alignment: .leading, spacing: 8) {
                    Text("🧁 Candy Planet")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    Text("A colorful candy-themed world set in a fantasy landscape. Balls are replaced with oversized sweets like lollipops and donuts. Ideal for attention therapy for kids with ADHD or sensory needs.")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                
                // Bullet ideas
                VStack(alignment: .leading, spacing: 6) {
                    Text("💡 Ideas:")
                        .font(.headline.weight(.semibold))
                        .foregroundColor(.yellow)
                    
                    HStack(alignment: .top) {
                        Text("•").foregroundColor(.white)
                        Text("Catch candy flying from different angles")
                            .foregroundColor(.white)
                    }
                    HStack(alignment: .top) {
                        Text("•").foregroundColor(.white)
                        Text("Bonus for catching “golden candy”")
                            .foregroundColor(.white)
                    }
                    HStack(alignment: .top) {
                        Text("•").foregroundColor(.white)
                        Text("Improve focus and coordination in a joyful, playful setting")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                
                Spacer().frame(height: 20)
                
                // Title & subtitle
                VStack(spacing: 8) {
                    Text("🍭 Candy Planet")
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .shadow(radius: 8)
                    
                    Text("Catch the candies in a magical world!")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.9))
                }
                
                // Start button
                Button(action: {
                    // TODO: navigate to game view
                }) {
                    Text("Start Adventure")
                        .font(.headline.weight(.bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 36)
                        .padding(.vertical, 12)
                        .background(
                            Capsule()
                                .fill(.white.opacity(0.25))
                        )
                }
                .buttonStyle(.plain)
                .shadow(radius: 5)
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 24)
        }
        .onAppear { animate = true }
    }
}

struct CandyIcon: View {
    let offset: CGFloat
    let delay: Double
    @State private var yOffset: CGFloat = 0
    
    var body: some View {
        Text("🍭")
            .font(.system(size: 36))
            .position(x: offset + 80, y: 120)
            .offset(y: yOffset)
            .opacity(0.8)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 2)
                    .repeatForever(autoreverses: true)
                    .delay(delay)
                ) {
                    yOffset = -30
                }
            }
    }
}

#Preview {
    CandyPlanetLandingView()
}




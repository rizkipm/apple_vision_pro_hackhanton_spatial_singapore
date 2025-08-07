//
//  AboutUsContentView.swift
//  hack_spatial_rizki_sg
//
//  Created by NUS on 7/8/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct AboutUsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedMember: TeamMember?
    @State private var cardRotations: [Double] = [0, 0, 0, 0]
    @State private var cardOffsets: [CGFloat] = [0, 0, 0, 0]
    @State private var isAnimating = false
    @State private var floatingPhase: CGFloat = 0
    @State private var particleOpacity: Double = 0.3
    @State private var showDetails = false
    @State private var cardScales: [CGFloat] = [1, 1, 1, 1]
    @Binding var showAbout: Bool
    
    // Team members data
//    let teamMembers = [
//        TeamMember(
//            id: 0,
//            name: "Hui Juan",
//            role: "UX/UI Designer",
//            image: "rizki", // Replace with actual image name
//            color: Color(red: 0.9, green: 0.4, blue: 0.6),
//            bio: "Specializes in creating intuitive interfaces and engaging user experiences for spatial computing platforms.",
//            contribution: "Candy Planet, Sound-Only Zen",
//            skills: ["SwiftUI", "3D Design", "User Research", "Prototyping"]
//        ),
//        TeamMember(
//            id: 1,
//            name: "Kubo",
//            role: "Backend Developer",
//            image: "person.fill", // Replace with actual image name
//            color: Color(red: 0.4, green: 0.6, blue: 0.9),
//            bio: "Expert in building scalable backend systems and integrating therapeutic algorithms.",
//            contribution: "Zen Garden, Arcade Catch",
//            skills: ["Swift", "RealityKit", "CloudKit", "Core ML"]
//        ),
//        TeamMember(
//            id: 2,
//            name: "Rizki",
//            role: "Data Science",
//            image: "rizki", // Replace with actual image name
//            color: Color(red: 0.4, green: 0.8, blue: 0.4),
//            bio: "Passionate about creating accessible technology solutions for healthcare and wellness.",
//            contribution: "Memory Bubbles, Space Catcher",
//            skills: ["visionOS", "ARKit", "HealthKit", "Accessibility"]
//        ),
//        TeamMember(
//            id: 3,
//            name: "Pulkit",
//            role: "AI/ML Engineer",
//            image: "person.fill", // Replace with actual image name
//            color: Color(red: 0.8, green: 0.6, blue: 0.4),
//            bio: "Develops intelligent systems for personalized therapy and progress tracking.",
//            contribution: "Artistic Mode, Time Trial",
//            skills: ["Machine Learning", "Data Science", "Vision Framework", "Analytics"]
//        )
//    ]
//    
//    var body: some View {
//        ZStack {
//            // Animated gradient background
//            LinearGradient(
//                colors: [
//                    Color(red: 0.05, green: 0.05, blue: 0.15),
//                    Color(red: 0.1, green: 0.1, blue: 0.25),
//                    Color(red: 0.15, green: 0.05, blue: 0.2)
//                ],
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//            .ignoresSafeArea()
//            .overlay(
//                // Animated particles
//                GeometryReader { geometry in
//                    ForEach(0..<20, id: \.self) { index in
//                        Circle()
//                            .fill(
//                                RadialGradient(
//                                    colors: [
//                                        Color.white.opacity(0.5),
//                                        Color.blue.opacity(0.2),
//                                        Color.clear
//                                    ],
//                                    center: .center,
//                                    startRadius: 2,
//                                    endRadius: 20
//                                )
//                            )
//                            .frame(width: CGFloat.random(in: 10...40))
//                            .position(
//                                x: CGFloat.random(in: 0...geometry.size.width),
//                                y: CGFloat.random(in: 0...geometry.size.height)
//                            )
//                            .opacity(particleOpacity)
//                            .animation(
//                                Animation.easeInOut(duration: Double.random(in: 3...6))
//                                    .repeatForever(autoreverses: true),
//                                value: particleOpacity
//                            )
//                            .offset(y: floatingPhase * CGFloat.random(in: -20...20))
//                    }
//                }
//            )
//            
//            VStack(spacing: 30) {
//                // Header
//                HStack {
//                    Button(action: {
//                        showAbout = false
//                    }) {
//                        HStack(spacing: 8) {
//                            Image(systemName: "chevron.left.circle.fill")
//                                .font(.title2)
//                            Text("Back")
//                                .font(.headline)
//                        }
//                        .foregroundColor(.white)
//                        .padding(.horizontal, 20)
//                        .padding(.vertical, 12)
//                        .background(
//                            LinearGradient(
//                                colors: [Color.white.opacity(0.2), Color.white.opacity(0.1)],
//                                startPoint: .leading,
//                                endPoint: .trailing
//                            )
//                        )
//                        .cornerRadius(25)
//                    }
//                    
//                    Spacer()
//                    
//                    // Logo/Brand
//                    HStack(spacing: 12) {
//                        Image(systemName: "brain.head.profile")
//                            .font(.title)
//                            .foregroundColor(.white)
//                            .symbolEffect(.pulse)
//                        
//                        Text("Neuroscope XR")
//                            .font(.title2.bold())
//                            .foregroundColor(.white)
//                    }
//                    .padding(.horizontal, 25)
//                    .padding(.vertical, 12)
//                    .background(Color.white.opacity(0.1))
//                    .cornerRadius(20)
//                }
//                .padding(.horizontal, 40)
//                .padding(.top, 20)
//                
//                // Title Section
//                VStack(spacing: 15) {
//                    Text("Team 8 Neuroscope")
//                        .font(.system(size: 56, weight: .bold, design: .rounded))
//                        .foregroundStyle(
//                            LinearGradient(
//                                colors: [.white, .blue.opacity(0.8), .purple.opacity(0.8)],
//                                startPoint: .leading,
//                                endPoint: .trailing
//                            )
//                        )
//                    
//                    Text("Building the Future of Therapeutic Spatial Computing")
//                        .font(.title3)
//                        .foregroundColor(.white.opacity(0.8))
//                        .multilineTextAlignment(.center)
//                }
//                
//                // Team Members Grid
//                HStack(spacing: 40) {
//                    ForEach(Array(teamMembers.enumerated()), id: \.element.id) { index, member in
//                        TeamMemberCard(
//                            member: member,
//                            rotation: $cardRotations[index],
//                            offset: $cardOffsets[index],
//                            scale: $cardScales[index],
//                            onTap: {
//                                withAnimation(.spring()) {
//                                    selectedMember = member
//                                    showDetails = true
//                                }
//                            }
//                        )
//                    }
//                }
//                .padding(.horizontal, 60)
//                
//                // Project Description
//                VStack(alignment: .leading, spacing: 20) {
//                    Text("About Catchiverse XR")
//                        .font(.title2.bold())
//                        .foregroundColor(.white)
//                    
//                    Text("Catchiverse XR delivers high engagement and sustained motivation through five thematic worlds: Candy Planet, Zen Garden, Space Catcher, Memory Bubbles, and Artistic Mode. Combined with five light-training modes such as Arcade Catch and Sound-Only Zen, this variety prevents boredom and boosts replayability, while dynamic feedback including particles, expressive emojis, motivational audio cues, and progress charts provides instant rewards that accelerate learning and recovery.")
//                        .font(.body)
//                        .foregroundColor(.white.opacity(0.9))
//                        .lineSpacing(8)
//                    
//                    Text("More than a mini-game, Catchiverse XR is a multimodal therapeutic platform suitable for all ages: children with ADHD benefit from Candy Planet & Sound-Only Zen, seniors or stroke survivors from Zen Garden & Memory Bubbles, and gamers/athletes from Space Catcher & Time Trial. Its data-driven approach records reaction times, accuracy, and consistency, enabling clinical validation and visual dashboards for therapists and families.")
//                        .font(.body)
//                        .foregroundColor(.white.opacity(0.9))
//                        .lineSpacing(8)
//                }
//                .padding(30)
//                .background(
//                    RoundedRectangle(cornerRadius: 25)
//                        .fill(Color.white.opacity(0.1))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 25)
//                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
//                        )
//                )
//                .padding(.horizontal, 60)
//                
//                Spacer()
//            }
//            
//            // Member Detail Overlay
//            if showDetails, let member = selectedMember {
//                ZStack {
//                    Color.black.opacity(0.7)
//                        .ignoresSafeArea()
//                        .onTapGesture {
//                            withAnimation {
//                                showDetails = false
//                                selectedMember = nil
//                            }
//                        }
//                    
//                    MemberDetailView(member: member, isShowing: $showDetails)
//                        .transition(.scale.combined(with: .opacity))
//                }
//            }
//        }
//        .onAppear {
//            startAnimations()
//        }
//    }
//    
//    func startAnimations() {
//        // Floating animation
//        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
//            floatingPhase = 1
//        }
//        
//        // Particle opacity animation
//        withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
//            particleOpacity = 0.6
//        }
//        
//        // Card animations
//        for index in 0..<4 {
//            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
//                withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) {
//                    cardOffsets[index] = 0
//                }
//                
//                // Continuous rotation animation
//                withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
//                    cardRotations[index] = 360
//                }
//            }
//        }
//    }
//}
//
//// MARK: - Team Member Card
//
//struct TeamMemberCard: View {
//    let member: TeamMember
//    @Binding var rotation: Double
//    @Binding var offset: CGFloat
//    @Binding var scale: CGFloat
//    let onTap: () -> Void
//    
//    @State private var isHovering = false
//    @State private var localRotation: Double = 0
//    
//    var body: some View {
//        VStack(spacing: 15) {
//            // Profile Image Container
//            ZStack {
//                // Animated background circles
//                Circle()
//                    .fill(member.color.opacity(0.3))
//                    .frame(width: 140, height: 140)
//                    .scaleEffect(isHovering ? 1.2 : 1.0)
//                    .animation(.easeInOut(duration: 0.3), value: isHovering)
//                
//                Circle()
//                    .fill(member.color.opacity(0.2))
//                    .frame(width: 160, height: 160)
//                    .scaleEffect(isHovering ? 1.3 : 1.1)
//                    .animation(.easeInOut(duration: 0.4), value: isHovering)
//                
//                // Profile image placeholder
//                ZStack {
//                    Circle()
//                        .fill(
//                            LinearGradient(
//                                colors: [member.color, member.color.opacity(0.7)],
//                                startPoint: .topLeading,
//                                endPoint: .bottomTrailing
//                            )
//                        )
//                        .frame(width: 120, height: 120)
//                    
//                    Image(systemName: member.image)
//                        .font(.system(size: 50))
//                        .foregroundColor(.white)
//                }
//                .overlay(
//                    Circle()
//                        .stroke(Color.white.opacity(0.8), lineWidth: 3)
//                )
//                .shadow(color: member.color.opacity(0.5), radius: 15)
//            }
//            .rotation3DEffect(
//                .degrees(localRotation),
//                axis: (x: 0, y: 1, z: 0)
//            )
//            
//            // Member Info
//            VStack(spacing: 8) {
//                Text(member.name)
//                    .font(.title3.bold())
//                    .foregroundColor(.white)
//                
//                Text(member.role)
//                    .font(.caption)
//                    .foregroundColor(member.color)
//                    .padding(.horizontal, 12)
//                    .padding(.vertical, 6)
//                    .background(member.color.opacity(0.2))
//                    .cornerRadius(12)
//            }
//        }
//        .padding(25)
//        .background(
//            RoundedRectangle(cornerRadius: 25)
//                .fill(
//                    LinearGradient(
//                        colors: [
//                            Color.white.opacity(0.15),
//                            Color.white.opacity(0.05)
//                        ],
//                        startPoint: .top,
//                        endPoint: .bottom
//                    )
//                )
//                .overlay(
//                    RoundedRectangle(cornerRadius: 25)
//                        .stroke(
//                            LinearGradient(
//                                colors: [
//                                    member.color.opacity(0.5),
//                                    member.color.opacity(0.2)
//                                ],
//                                startPoint: .top,
//                                endPoint: .bottom
//                            ),
//                            lineWidth: 2
//                        )
//                )
//        )
//        .scaleEffect(scale * (isHovering ? 1.05 : 1.0))
//        .offset(y: offset + (isHovering ? -10 : 0))
//        .shadow(
//            color: member.color.opacity(isHovering ? 0.4 : 0.2),
//            radius: isHovering ? 20 : 10,
//            y: 10
//        )
//        .onHover { hovering in
//            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
//                isHovering = hovering
//            }
//        }
//        .onTapGesture(perform: onTap)
//        .onAppear {
//            // Individual card floating animation
//            withAnimation(.easeInOut(duration: Double.random(in: 2...4)).repeatForever(autoreverses: true)) {
//                localRotation = Double.random(in: -5...5)
//            }
//        }
//    }
//}
//
//// MARK: - Member Detail View
//
//struct MemberDetailView: View {
//    let member: TeamMember
//    @Binding var isShowing: Bool
//    @State private var animateIn = false
//    
//    var body: some View {
//        VStack(spacing: 25) {
//            // Close button
//            HStack {
//                Spacer()
//                Button(action: {
//                    withAnimation {
//                        isShowing = false
//                    }
//                }) {
//                    Image(systemName: "xmark.circle.fill")
//                        .font(.title)
//                        .foregroundColor(.white.opacity(0.7))
//                }
//            }
//            
//            // Profile section
//            HStack(spacing: 30) {
//                // Large profile image
//                ZStack {
//                    Circle()
//                        .fill(
//                            LinearGradient(
//                                colors: [member.color, member.color.opacity(0.5)],
//                                startPoint: .topLeading,
//                                endPoint: .bottomTrailing
//                            )
//                        )
//                        .frame(width: 150, height: 150)
//                    
//                    Image(systemName: member.image)
//                        .font(.system(size: 70))
//                        .foregroundColor(.white)
//                }
//                .overlay(
//                    Circle()
//                        .stroke(Color.white, lineWidth: 4)
//                )
//                .shadow(color: member.color.opacity(0.5), radius: 20)
//                .scaleEffect(animateIn ? 1 : 0.5)
//                .animation(.spring(response: 0.5, dampingFraction: 0.7).delay(0.1), value: animateIn)
//                
//                // Info
//                VStack(alignment: .leading, spacing: 15) {
//                    Text(member.name)
//                        .font(.system(size: 40, weight: .bold))
//                        .foregroundColor(.white)
//                    
//                    Text(member.role)
//                        .font(.title2)
//                        .foregroundColor(member.color)
//                    
//                    Text(member.bio)
//                        .font(.body)
//                        .foregroundColor(.white.opacity(0.9))
//                        .lineSpacing(5)
//                }
//                .opacity(animateIn ? 1 : 0)
//                .offset(x: animateIn ? 0 : 30)
//                .animation(.easeOut(duration: 0.4).delay(0.2), value: animateIn)
//            }
//            
//            // Contributions
//            VStack(alignment: .leading, spacing: 15) {
//                Text("Contributions")
//                    .font(.title3.bold())
//                    .foregroundColor(.white)
//                
//                Text(member.contribution)
//                    .font(.body)
//                    .foregroundColor(member.color)
//                    .padding()
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .background(member.color.opacity(0.1))
//                    .cornerRadius(15)
//            }
//            .opacity(animateIn ? 1 : 0)
//            .offset(y: animateIn ? 0 : 20)
//            .animation(.easeOut(duration: 0.4).delay(0.3), value: animateIn)
//            
//            // Skills
//            VStack(alignment: .leading, spacing: 15) {
//                Text("Skills")
//                    .font(.title3.bold())
//                    .foregroundColor(.white)
//                
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
//                    ForEach(member.skills, id: \.self) { skill in
//                        Text(skill)
//                            .font(.caption)
//                            .foregroundColor(.white)
//                            .padding(.horizontal, 15)
//                            .padding(.vertical, 8)
//                            .background(
//                                Capsule()
//                                    .fill(member.color.opacity(0.3))
//                                    .overlay(
//                                        Capsule()
//                                            .stroke(member.color.opacity(0.5), lineWidth: 1)
//                                    )
//                            )
//                    }
//                }
//            }
//            .opacity(animateIn ? 1 : 0)
//            .offset(y: animateIn ? 0 : 20)
//            .animation(.easeOut(duration: 0.4).delay(0.4), value: animateIn)
//        }
//        .padding(40)
//        .frame(maxWidth: 700)
//        .background(
//            RoundedRectangle(cornerRadius: 30)
//                .fill(Color.black.opacity(0.9))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 30)
//                        .stroke(member.color.opacity(0.3), lineWidth: 2)
//                )
//        )
//        .scaleEffect(animateIn ? 1 : 0.9)
//        .onAppear {
//            animateIn = true
//        }
//    }
//}
//
//// MARK: - Data Models
//
//struct TeamMember: Identifiable {
//    let id: Int
//    let name: String
//    let role: String
//    let image: String // System image or actual image name
//    let color: Color
//    let bio: String
//    let contribution: String
//    let skills: [String]
//}
    
    let teamMembers = [
            TeamMember(
                id: 0,
                name: "Hui Juan",
                role: "UX/UI Designer",
                image: "person.fill", // Replace with actual image name
                color: Color(red: 0.9, green: 0.4, blue: 0.6),
                bio: "Specializes in creating intuitive interfaces and engaging user experiences for spatial computing platforms.",
                contribution: "Candy Planet, Sound-Only Zen",
                skills: ["SwiftUI", "3D Design", "User Research", "Prototyping"]
            ),
            TeamMember(
                id: 1,
                name: "Kubo",
                role: "Backend Developer",
                image: "person.fill", // Replace with actual image name
                color: Color(red: 0.4, green: 0.6, blue: 0.9),
                bio: "Expert in building scalable backend systems and integrating therapeutic algorithms.",
                contribution: "Zen Garden, Arcade Catch",
                skills: ["Swift", "RealityKit", "CloudKit", "Core ML"]
            ),
            TeamMember(
                id: 2,
                name: "Rizki",
                role: "Lead Developer",
                image: "person.fill", // Replace with actual image name
                color: Color(red: 0.4, green: 0.8, blue: 0.4),
                bio: "Passionate about creating accessible technology solutions for healthcare and wellness.",
                contribution: "Memory Bubbles, Space Catcher",
                skills: ["visionOS", "ARKit", "HealthKit", "Accessibility"]
            ),
            TeamMember(
                id: 3,
                name: "Pulkit",
                role: "AI/ML Engineer",
                image: "person.fill", // Replace with actual image name
                color: Color(red: 0.8, green: 0.6, blue: 0.4),
                bio: "Develops intelligent systems for personalized therapy and progress tracking.",
                contribution: "Artistic Mode, Time Trial",
                skills: ["Machine Learning", "Data Science", "Vision Framework", "Analytics"]
            )
        ]
        
        var body: some View {
            ZStack {
                // Animated gradient background
                LinearGradient(
                    colors: [
                        Color(red: 0.05, green: 0.05, blue: 0.15),
                        Color(red: 0.1, green: 0.1, blue: 0.25),
                        Color(red: 0.15, green: 0.05, blue: 0.2)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                .overlay(
                    // Animated particles
                    GeometryReader { geometry in
                        ForEach(0..<20, id: \.self) { index in
                            Circle()
                                .fill(
                                    RadialGradient(
                                        colors: [
                                            Color.white.opacity(0.5),
                                            Color.blue.opacity(0.2),
                                            Color.clear
                                        ],
                                        center: .center,
                                        startRadius: 2,
                                        endRadius: 20
                                    )
                                )
                                .frame(width: CGFloat.random(in: 10...40))
                                .position(
                                    x: CGFloat.random(in: 0...geometry.size.width),
                                    y: CGFloat.random(in: 0...geometry.size.height)
                                )
                                .opacity(particleOpacity)
                                .animation(
                                    Animation.easeInOut(duration: Double.random(in: 3...6))
                                        .repeatForever(autoreverses: true),
                                    value: particleOpacity
                                )
                                .offset(y: floatingPhase * CGFloat.random(in: -20...20))
                        }
                    }
                )
                
                VStack(spacing: 30) {
                    // Header
                    HStack {
                        Button(action: {
                            showAbout = false
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: "chevron.left.circle.fill")
                                    .font(.title2)
                                Text("Back")
                                    .font(.headline)
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.2), Color.white.opacity(0.1)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(25)
                        }
                        
                        Spacer()
                        
                        // Logo/Brand
                        HStack(spacing: 12) {
                            Image(systemName: "brain.head.profile")
                                .font(.title)
                                .foregroundColor(.white)
                                .symbolEffect(.pulse)
                            
                            Text("Neuroscope XR")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 25)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(20)
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 20)
                    
                    // Title Section
                    VStack(spacing: 15) {
                        Text("Team 8 Neuroscope")
                            .font(.system(size: 56, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.white, .blue.opacity(0.8), .purple.opacity(0.8)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                        Text("Building the Future of Therapeutic Spatial Computing")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                    }
                    
                    // Team Members Grid
                    HStack(spacing: 40) {
                        ForEach(Array(teamMembers.enumerated()), id: \.element.id) { index, member in
                            TeamMemberCard(
                                member: member,
                                rotation: $cardRotations[index],
                                offset: $cardOffsets[index],
                                scale: $cardScales[index],
                                onTap: {
                                    withAnimation(.spring()) {
                                        selectedMember = member
                                        showDetails = true
                                    }
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 60)
                    
                    // Project Description
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("About Catchiverse XR")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                            
                            Text("Catchiverse XR delivers high engagement and sustained motivation through five thematic worlds: Candy Planet, Zen Garden, Space Catcher, Memory Bubbles, and Artistic Mode. Combined with five light-training modes such as Arcade Catch and Sound-Only Zen, this variety prevents boredom and boosts replayability, while dynamic feedback including particles, expressive emojis, motivational audio cues, and progress charts provides instant rewards that accelerate learning and recovery.")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.9))
                                .lineSpacing(8)
                            
                            Text("More than a mini-game, Catchiverse XR is a multimodal therapeutic platform suitable for all ages: children with ADHD benefit from Candy Planet & Sound-Only Zen, seniors or stroke survivors from Zen Garden & Memory Bubbles, and gamers/athletes from Space Catcher & Time Trial. Its data-driven approach records reaction times, accuracy, and consistency, enabling clinical validation and visual dashboards for therapists and families.")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.9))
                                .lineSpacing(8)
                        }
                        .padding(30)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                        )
                    }
                    .frame(maxHeight: 200)
                    .padding(.horizontal, 60)
                    
                    Spacer()
                }
                
                // Member Detail Overlay
                if showDetails, let member = selectedMember {
                    ZStack {
                        Color.black.opacity(0.7)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation {
                                    showDetails = false
                                    selectedMember = nil
                                }
                            }
                        
                        MemberDetailView(member: member, isShowing: $showDetails)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
            }
            .onAppear {
                startAnimations()
            }
        }
        
        func startAnimations() {
            // Floating animation
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                floatingPhase = 1
            }
            
            // Particle opacity animation
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                particleOpacity = 0.6
            }
            
            // Card animations
            for index in 0..<4 {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) {
                        cardOffsets[index] = 0
                    }
                    
                    // Continuous rotation animation
                    withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                        cardRotations[index] = 360
                    }
                }
            }
        }
    }

    // MARK: - Team Member Card

    struct TeamMemberCard: View {
        let member: TeamMember
        @Binding var rotation: Double
        @Binding var offset: CGFloat
        @Binding var scale: CGFloat
        let onTap: () -> Void
        
        @State private var isHovering = false
        @State private var localRotation: Double = 0
        
        var body: some View {
            VStack(spacing: 15) {
                // Profile Image Container
                ZStack {
                    // Animated background circles
                    Circle()
                        .fill(member.color.opacity(0.3))
                        .frame(width: 140, height: 140)
                        .scaleEffect(isHovering ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.3), value: isHovering)
                    
                    Circle()
                        .fill(member.color.opacity(0.2))
                        .frame(width: 160, height: 160)
                        .scaleEffect(isHovering ? 1.3 : 1.1)
                        .animation(.easeInOut(duration: 0.4), value: isHovering)
                    
                    // Profile image placeholder
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [member.color, member.color.opacity(0.7)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 120, height: 120)
                        
                        Image(systemName: member.image)
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                    }
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.8), lineWidth: 3)
                    )
                    .shadow(color: member.color.opacity(0.5), radius: 15)
                }
                .rotation3DEffect(
                    .degrees(localRotation),
                    axis: (x: 0, y: 1, z: 0)
                )
                
                // Member Info
                VStack(spacing: 8) {
                    Text(member.name)
                        .font(.title3.bold())
                        .foregroundColor(.white)
                    
                    Text(member.role)
                        .font(.caption)
                        .foregroundColor(member.color)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(member.color.opacity(0.2))
                        .cornerRadius(12)
                }
            }
            .padding(25)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.15),
                                Color.white.opacity(0.05)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        member.color.opacity(0.5),
                                        member.color.opacity(0.2)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ),
                                lineWidth: 2
                            )
                    )
            )
            .scaleEffect(scale * (isHovering ? 1.05 : 1.0))
            .offset(y: offset + (isHovering ? -10 : 0))
            .shadow(
                color: member.color.opacity(isHovering ? 0.4 : 0.2),
                radius: isHovering ? 20 : 10,
                y: 10
            )
            .onHover { hovering in
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    isHovering = hovering
                }
            }
            .onTapGesture(perform: onTap)
            .onAppear {
                // Individual card floating animation
                withAnimation(.easeInOut(duration: Double.random(in: 2...4)).repeatForever(autoreverses: true)) {
                    localRotation = Double.random(in: -5...5)
                }
            }
        }
    }

    // MARK: - Member Detail View

    struct MemberDetailView: View {
        let member: TeamMember
        @Binding var isShowing: Bool
        @State private var animateIn = false
        
        var body: some View {
            VStack(spacing: 25) {
                // Close button
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isShowing = false
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                
                // Profile section
                HStack(spacing: 30) {
                    // Large profile image
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [member.color, member.color.opacity(0.5)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 150, height: 150)
                        
                        Image(systemName: member.image)
                            .font(.system(size: 70))
                            .foregroundColor(.white)
                    }
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 4)
                    )
                    .shadow(color: member.color.opacity(0.5), radius: 20)
                    .scaleEffect(animateIn ? 1 : 0.5)
                    .animation(.spring(response: 0.5, dampingFraction: 0.7).delay(0.1), value: animateIn)
                    
                    // Info
                    VStack(alignment: .leading, spacing: 15) {
                        Text(member.name)
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text(member.role)
                            .font(.title2)
                            .foregroundColor(member.color)
                        
                        Text(member.bio)
                            .font(.body)
                            .foregroundColor(.white.opacity(0.9))
                            .lineSpacing(5)
                    }
                    .opacity(animateIn ? 1 : 0)
                    .offset(x: animateIn ? 0 : 30)
                    .animation(.easeOut(duration: 0.4).delay(0.2), value: animateIn)
                }
                
                // Contributions
                VStack(alignment: .leading, spacing: 15) {
                    Text("Contributions")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                    
                    Text(member.contribution)
                        .font(.body)
                        .foregroundColor(member.color)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(member.color.opacity(0.1))
                        .cornerRadius(15)
                }
                .opacity(animateIn ? 1 : 0)
                .offset(y: animateIn ? 0 : 20)
                .animation(.easeOut(duration: 0.4).delay(0.3), value: animateIn)
                
                // Skills
                VStack(alignment: .leading, spacing: 15) {
                    Text("Skills")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                        ForEach(member.skills, id: \.self) { skill in
                            Text(skill)
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 8)
                                .background(
                                    Capsule()
                                        .fill(member.color.opacity(0.3))
                                        .overlay(
                                            Capsule()
                                                .stroke(member.color.opacity(0.5), lineWidth: 1)
                                        )
                                )
                        }
                    }
                }
                .opacity(animateIn ? 1 : 0)
                .offset(y: animateIn ? 0 : 20)
                .animation(.easeOut(duration: 0.4).delay(0.4), value: animateIn)
            }
            .padding(40)
            .frame(maxWidth: 700)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.black.opacity(0.9))
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(member.color.opacity(0.3), lineWidth: 2)
                    )
            )
            .scaleEffect(animateIn ? 1 : 0.9)
            .onAppear {
                animateIn = true
            }
        }
    }

    // MARK: - Data Models

    struct TeamMember: Identifiable {
        let id: Int
        let name: String
        let role: String
        let image: String // System image or actual image name
        let color: Color
        let bio: String
        let contribution: String
        let skills: [String]
}


#Preview {
    AboutUsView(showAbout: .constant(true))

}

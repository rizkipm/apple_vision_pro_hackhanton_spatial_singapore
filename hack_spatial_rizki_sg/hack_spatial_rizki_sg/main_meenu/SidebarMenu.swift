//
//  SidebarMenu.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 07/08/25.
//

//import SwiftUI
//
//struct SidebarMenu: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    SidebarMenu()
//}

//
//import SwiftUI
//
//struct SidebarView: View {
//    @Binding var selectedTab: String
//    
//    let menuItems = [
//        MenuItem(icon: "house.fill", title: "Home", id: "Home"),
//        MenuItem(icon: "gamecontroller.fill", title: "Games", id: "Games"),
//        MenuItem(icon: "info.circle.fill", title: "About Us", id: "About"),
//        MenuItem(icon: "music.note", title: "Songs", id: "Songs"),
//        MenuItem(icon: "star.fill", title: "Made for you", id: "MadeForYou")
//    ]
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            // Header
//            VStack(alignment: .leading, spacing: 8) {
//                HStack {
//                    Image(systemName: "circle.hexagongrid.fill")
//                        .font(.title2)
//                        .foregroundColor(.white)
//                    
//                    VStack(alignment: .leading, spacing: 2) {
//                        Text("Catchiverse")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                            .foregroundColor(.white)
//                        
//                        Text("Train Your Eyes, Challenges Your Brain")
//                            .font(.caption)
//                            .foregroundColor(.white.opacity(0.8))
//                    }
//                    
//                    Spacer()
//                    
//                    Button(action: {}) {
//                        Image(systemName: "ellipsis")
//                            .foregroundColor(.white.opacity(0.7))
//                    }
//                }
//            }
//            .padding(.horizontal, 20)
//            .padding(.top, 30)
//            .padding(.bottom, 30)
//            
//            // Menu Items
//            VStack(alignment: .leading, spacing: 8) {
////                ForEach(menuItems) { item in
////                    MenuItemView(
////                        item: item,
//////                        isSelected: selectedTab == item.id,
//////                        action: { selectedTab = item.id }
////                    )
////                }
//            }
//            .padding(.horizontal, 12)
//            
//            Spacer()
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//        .background(
//            RoundedRectangle(cornerRadius: 20)
//                .fill(.ultraThinMaterial)
//                .opacity(0.8)
//        )
//        .padding(.leading, 20)
//        .padding(.vertical, 20)
//    }
//}
//
//struct MenuItem: Identifiable {
//    let id = UUID()
//    let icon: String
//    let title: String
//    let identifier: String
//    
//    init(icon: String, title: String, id: String) {
//        self.icon = icon
//        self.title = title
//        self.identifier = id
//    }
//}
//
//struct MenuItemView: View {
//    let item: MenuItem
//    let isSelected: Bool
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            HStack(spacing: 12) {
//                Image(systemName: item.icon)
//                    .font(.system(size: 18))
//                    .foregroundColor(isSelected ? .white : .white.opacity(0.7))
//                    .frame(width: 20)
//                
//                Text(item.title)
//                    .font(.system(size: 16, weight: isSelected ? .semibold : .medium))
//                    .foregroundColor(isSelected ? .white : .white.opacity(0.8))
//                
//                Spacer()
//            }
//            .padding(.horizontal, 16)
//            .padding(.vertical, 12)
//            .background(
//                RoundedRectangle(cornerRadius: 12)
//                    .fill(isSelected ? Color.white.opacity(0.2) : Color.clear)
//            )
//        }
//        .buttonStyle(.plain)
//        .hoverEffect(.lift)
//    }
//}
//
//#Preview {
//    SidebarView(selectedTab: .constant("Home"))
//}

import SwiftUI

struct SidebarView: View {
    @Binding var selectedTab: String
    
    let menuItems = [
        MenuItem(icon: "house.fill", title: "Home", id: "Home"),
        MenuItem(icon: "gamecontroller.fill", title: "Games", id: "Games"),
        MenuItem(icon: "info.circle.fill", title: "About Us", id: "About"),
        MenuItem(icon: "music.note", title: "Songs", id: "Songs"),
        MenuItem(icon: "star.fill", title: "Made for you", id: "MadeForYou")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header Section
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 12) {
                    // Logo/Icon
                    Image(systemName: "circle.hexagongrid.fill")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Catchiverse")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        Text("Train Your Eyes, Challenges Your Brain")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.8))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    
                    Spacer()
                    
                    // Menu button
                    Button {
                        // Add menu action here
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.title3)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                    .buttonStyle(.borderless)
                    .hoverEffect(.lift)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 40)
            .padding(.bottom, 32)
            
            // Navigation Menu Items
            VStack(alignment: .leading, spacing: 4) {
                ForEach(menuItems) { item in
                    MenuItemView(
                        item: item,
                        isSelected: selectedTab == item.identifier,
                        action: { selectedTab = item.identifier }
                    )
                }
            }
            .padding(.horizontal, 16)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background {
            // Enhanced gradient background matching the design
            RoundedRectangle(cornerRadius: 28)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.blue.opacity(0.8),
                            Color.cyan.opacity(0.6),
                            Color.orange.opacity(0.7),
                            Color.brown.opacity(0.8)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(.ultraThinMaterial.opacity(0.3))
                }
        }
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
        .padding(.leading, 24)
        .padding(.trailing, 8)
        .padding(.vertical, 24)
    }
}

struct MenuItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let identifier: String
    
    init(icon: String, title: String, id: String) {
        self.icon = icon
        self.title = title
        self.identifier = id
    }
}

struct MenuItemView: View {
    let item: MenuItem
    let isSelected: Bool
    let action: () -> Void
    
    @State private var isHovered = false
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 16) {
                Image(systemName: item.icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(iconColor)
                    .frame(width: 24, height: 24)
                
                Text(item.title)
                    .font(.system(size: 16, weight: isSelected ? .semibold : .medium))
                    .foregroundStyle(textColor)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(backgroundColor)
                    .animation(.easeInOut(duration: 0.2), value: isSelected)
                    .animation(.easeInOut(duration: 0.15), value: isHovered)
            }
        }
        .buttonStyle(.borderless)
        .hoverEffect(.lift)
        .onHover { hovering in
            isHovered = hovering
        }
        .scaleEffect(isHovered && !isSelected ? 1.02 : 1.0)
        .animation(.easeInOut(duration: 0.15), value: isHovered)
    }
    
    private var backgroundColor: Color {
        if isSelected {
            return .white.opacity(0.25)
        } else if isHovered {
            return .white.opacity(0.1)
        } else {
            return .clear
        }
    }
    
    private var iconColor: Color {
        isSelected ? .white : .white.opacity(0.85)
    }
    
    private var textColor: Color {
        isSelected ? .white : .white.opacity(0.9)
    }
}

// MARK: - Preview
#Preview("Sidebar") {
    ZStack {
        // Background for context
        Color.black.opacity(0.3)
            .ignoresSafeArea()
        
        HStack {
            SidebarView(selectedTab: .constant("Home"))
                .frame(width: 280)
            
            Spacer()
        }
    }
}

// MARK: - Alternative compact version for smaller screens
struct CompactSidebarView: View {
    @Binding var selectedTab: String
    
    let menuItems = [
        MenuItem(icon: "house.fill", title: "Home", id: "Home"),
        MenuItem(icon: "gamecontroller.fill", title: "Games", id: "Games"),
        MenuItem(icon: "info.circle.fill", title: "About Us", id: "About"),
        MenuItem(icon: "music.note", title: "Songs", id: "Songs"),
        MenuItem(icon: "star.fill", title: "Made for you", id: "MadeForYou")
    ]
    
    var body: some View {
        VStack(spacing: 8) {
            // Compact header
            Image(systemName: "circle.hexagongrid.fill")
                .font(.title)
                .foregroundStyle(.white)
                .padding(.bottom, 16)
            
            // Compact menu items
            ForEach(menuItems) { item in
                Button {
                    selectedTab = item.identifier
                } label: {
                    VStack(spacing: 6) {
                        Image(systemName: item.icon)
                            .font(.system(size: 20))
                            .foregroundStyle(selectedTab == item.identifier ? .white : .white.opacity(0.7))
                        
                        Text(item.title)
                            .font(.caption2)
                            .foregroundStyle(selectedTab == item.identifier ? .white : .white.opacity(0.8))
                            .lineLimit(1)
                    }
                    .frame(width: 64, height: 64)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(selectedTab == item.identifier ? .white.opacity(0.25) : .clear)
                    }
                }
                .buttonStyle(.borderless)
                .hoverEffect(.lift)
            }
            
            Spacer()
        }
        .padding(.vertical, 20)
        .frame(width: 80)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.blue.opacity(0.8),
                            Color.cyan.opacity(0.6),
                            Color.orange.opacity(0.7),
                            Color.brown.opacity(0.8)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial.opacity(0.3))
                }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 8)
    }
}

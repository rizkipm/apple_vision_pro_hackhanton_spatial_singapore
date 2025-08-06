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
            // Header
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "circle.hexagongrid.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Catchiverse")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Train Your Eyes, Challenges Your Brain")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 30)
            .padding(.bottom, 30)
            
            // Menu Items
            VStack(alignment: .leading, spacing: 8) {
//                ForEach(menuItems) { item in
//                    MenuItemView(
//                        item: item,
////                        isSelected: selectedTab == item.id,
////                        action: { selectedTab = item.id }
//                    )
//                }
            }
            .padding(.horizontal, 12)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .opacity(0.8)
        )
        .padding(.leading, 20)
        .padding(.vertical, 20)
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
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: item.icon)
                    .font(.system(size: 18))
                    .foregroundColor(isSelected ? .white : .white.opacity(0.7))
                    .frame(width: 20)
                
                Text(item.title)
                    .font(.system(size: 16, weight: isSelected ? .semibold : .medium))
                    .foregroundColor(isSelected ? .white : .white.opacity(0.8))
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.white.opacity(0.2) : Color.clear)
            )
        }
        .buttonStyle(.plain)
        .hoverEffect(.lift)
    }
}

#Preview {
    SidebarView(selectedTab: .constant("Home"))
}

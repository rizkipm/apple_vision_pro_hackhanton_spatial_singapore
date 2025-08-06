//
//  WorldType.swift
//  hack_spatial_rizki_sg
//
//  Created by rizki aimar on 06/08/25.
//
import Foundation
import RealityKit
import UIKit


enum WorldType: String, CaseIterable {
    case candyPlanet = "Candy Planet"
    case zenGarden = "Zen Garden"
    case spaceCatcher = "Space Catcher"
    case memoryBubbles = "Memory Bubbles"
    case artisticMode = "Artistic Mode"

    var color: UIColor {
        switch self {
        case .candyPlanet: return .systemPink
        case .zenGarden: return .systemGreen
        case .spaceCatcher: return .systemBlue
        case .memoryBubbles: return .systemTeal
        case .artisticMode: return .systemOrange
        }
    }

    var icon: String {
        switch self {
        case .candyPlanet: return "🍬"
        case .zenGarden: return "🌸"
        case .spaceCatcher: return "🚀"
        case .memoryBubbles: return "💭"
        case .artisticMode: return "🎨"
        }
    }
}


//
//enum WorldType: String {
//    case candyPlanet = "Candy Planet"
//    case zenGarden = "Zen Garden"
//    case spaceCatcher = "Space Catcher"
//    case memoryBubbles = "Memory Bubbles"
//    case artisticMode = "Artistic Mode"
//
//    var icon: String {
//        switch self {
//        case .candyPlanet: return "🍭"
//        case .zenGarden: return "🌳"
//        case .spaceCatcher: return "🚀"
//        case .memoryBubbles: return "🧠"
//        case .artisticMode: return "🎨"
//        }
//    }
//
//    var color: UIColor {
//        switch self {
//        case .candyPlanet: return .systemPink
//        case .zenGarden: return .systemGreen
//        case .spaceCatcher: return .systemIndigo
//        case .memoryBubbles: return .systemBlue
//        case .artisticMode: return .systemOrange
//        }
//    }
//}


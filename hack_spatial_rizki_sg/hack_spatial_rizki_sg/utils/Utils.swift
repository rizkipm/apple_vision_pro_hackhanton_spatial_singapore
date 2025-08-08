//
//  Utils.swift
//  hack_spatial_rizki_sg
//
//  Created by NUS on 8/8/25.
//

import Foundation


// Safe array subscript
extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}

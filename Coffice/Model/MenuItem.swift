//
//  MenuItem.swift
//  Coffice
//
//  Created by Angel on 09/05/25.
//

import Foundation
struct MenuItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let imageName: String
    let type: String
}

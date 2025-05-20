//
//  NavigationManager.swift
//  Coffice
//
//  Created by Angel on 17/05/25.
//


import Foundation
import SwiftUI

class NavigationManager: ObservableObject {
    static let shared = NavigationManager()
    @Published var navigateToSearch = false
}

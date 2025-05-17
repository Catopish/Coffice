//
//  PreferencesManager.swift
//  Coffice
//
//  Created by Al Amin Dwiesta on 16/05/25.
//

import Foundation
import SwiftUI

class PreferencesManager: ObservableObject {
    @AppStorage("userPreferences") private var storedPreferences: String = ""

    @Published var preferences: UserPreferences = UserPreferences(likedTags: [])

    init() {
        load()
    }

    func load() {
        if let data = storedPreferences.data(using: .utf8),
           let decoded = try? JSONDecoder().decode(UserPreferences.self, from: data) {
            preferences = decoded
        }
    }

    func save() {
        if let data = try? JSONEncoder().encode(preferences),
           let json = String(data: data, encoding: .utf8) {
            storedPreferences = json
        }
    }

    func addTag(_ tag: CoffeeTag) {
        if !preferences.likedTags.contains(tag) {
            preferences.likedTags.append(tag)
            save()
        }
    }
    
    func getRandomPreferredTags(count: Int = 2) -> [CoffeeTag] {
        return Array(preferences.likedTags.shuffled().prefix(count))
    }
    
}

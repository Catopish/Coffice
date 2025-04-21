//
//  CoffeeShops.swift
//  Coffice
//
//  Created by Hafi on 21/04/25.
//

import Foundation

struct CoffeeShops: Codable ,Identifiable {
    var id = UUID()
    var name: String
    var location: String
    var description: String
    var distance: Double
    var steps: Int
    var calories: Int
    var latitude: Double
    var longitude: Double
    var logo: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case location
        case description
        case distance
        case steps
        case calories
        case latitude
        case longitude
        case logo
    }
}

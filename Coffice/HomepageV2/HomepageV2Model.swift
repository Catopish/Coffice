//
//  HomepageV2Model.swift
//  Coffice
//
//  Created by Al Amin Dwiesta on 12/05/25.
//

import Foundation

struct CoffeeShopStruct: Identifiable {
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
}

let coffeeShopV2: [CoffeeShopStruct] = [
    CoffeeShopStruct(name: "Starbucks", location: "The Breeze", description: "lorem", distance: 127, steps: 123, calories: 123, latitude: -6.30191, longitude: 106.65438, logo: "sbux"),
    CoffeeShopStruct(name: "Fore", location: "The Breeze", description: "lorem", distance: 45, steps: 54, calories: 134, latitude: -6.302514, longitude: 106.654299, logo: "forelogo"),
    CoffeeShopStruct(name: "36 Grams", location: "Lorem Ipsum", description: "lorem", distance: 45, steps: 54, calories: 134, latitude: -6.301446, longitude: 106.650023, logo: "36grams"),
    CoffeeShopStruct(name: "Tamper", location: "The Breeze", description: "lorem", distance: 431, steps: 887, calories: 1223, latitude: -6.301870, longitude: 106.654210, logo: "tamperlogo"),
    CoffeeShopStruct(name: "% Arabica", location: "Lorem Ipsum", description: "lorem", distance: 431, steps: 887, calories: 1223, latitude: -6.30179, longitude: 106.65321, logo: "arabica"),
    CoffeeShopStruct(name: "Kenangan Signature", location: "The Breeze", description: "lorem", distance: 134, steps: 412, calories: 531, latitude: -6.301535, longitude: 106.653458, logo: "kenangan"),
    CoffeeShopStruct(name: "Tabemori", location: "GOP 6", description: "lorem", distance: 256, steps: 102, calories: 45, latitude: -6.302768, longitude: 106.653470, logo: "tabemorilogo"),
    CoffeeShopStruct(name: "Dummy", location: "Lorem Ipsum", description: "lorem", distance: 0, steps: 123, calories: 123, latitude: -6.289458814825691, longitude: 106.62684104712467, logo: "sbux"),
    CoffeeShopStruct(name: "Lawson", location: "GOP 6", description: "lorem", distance: 256, steps: 102, calories: 45, latitude: -6.302592, longitude: 106.653380, logo: "lawsonlogo")
]

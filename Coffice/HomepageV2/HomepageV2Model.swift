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
    var menu: [CoffeeMenuStruct]
}

enum CoffeeTag: String, Codable,CaseIterable {
    case sweet
    case strong
    case creamy
    case iced
    case hot
    case bitter
}

struct UserPreferences: Codable {
    var likedTags: [CoffeeTag]
}


struct CoffeeMenuStruct: Identifiable {
    var id = UUID()
    var name: String
    var tag1: CoffeeTag
    var tag2: CoffeeTag
    var tag3: CoffeeTag
    var image: String
}

let coffeeShopV2: [CoffeeShopStruct] = [
    CoffeeShopStruct(
        name: "Starbucks",
        location: "The Breeze",
        description: "lorem",
        distance: 127,
        steps: 123,
        calories: 123,
        latitude: -6.30191,
        longitude: 106.65438,
        logo: "sbux",
        menu: [
            CoffeeMenuStruct(name: "Dark Mocha", tag1: .strong, tag2: .sweet, tag3: .creamy, image: "AmericanoPlaceholder"),
            CoffeeMenuStruct(name: "Iced Shaken Espresso", tag1: .iced, tag2: .bitter, tag3: .strong, image: "EspressoPlaceholder"),
            CoffeeMenuStruct(name: "Caramel Macchiato", tag1: .hot, tag2: .creamy, tag3: .sweet, image: "KenanganChocoOrange")
        ]
    ),
    CoffeeShopStruct(
        name: "Fore",
        location: "The Breeze",
        description: "lorem",
        distance: 45,
        steps: 54,
        calories: 134,
        latitude: -6.302514,
        longitude: 106.654299,
        logo: "forelogo",
        menu: [
            CoffeeMenuStruct(name: "Fore Matcha", tag1: .sweet, tag2: .creamy, tag3: .iced, image: "KenanganChocoOrange"),
            CoffeeMenuStruct(name: "Iced Americano", tag1: .iced, tag2: .bitter, tag3: .strong, image: "AmericanoPlaceholder")
        ]
    ),
    CoffeeShopStruct(
        name: "36 Grams",
        location: "Lorem Ipsum",
        description: "lorem",
        distance: 45,
        steps: 54,
        calories: 134,
        latitude: -6.301446,
        longitude: 106.650023,
        logo: "36grams",
        menu: [
            CoffeeMenuStruct(name: "Hazelnut Latte", tag1: .sweet, tag2: .creamy, tag3: .hot, image: "LattePlaceholder"),
            CoffeeMenuStruct(name: "Espresso Shot", tag1: .bitter, tag2: .strong, tag3: .hot, image: "EspressoPlaceholder")
        ]
    ),
    CoffeeShopStruct(
        name: "Tamper",
        location: "The Breeze",
        description: "lorem",
        distance: 431,
        steps: 887,
        calories: 1223,
        latitude: -6.301870,
        longitude: 106.654210,
        logo: "tamperlogo",
        menu: [
            CoffeeMenuStruct(name: "Cold Brew", tag1: .iced, tag2: .bitter, tag3: .strong, image: "KenanganChocoOrange"),
            CoffeeMenuStruct(name: "Sweet Cream Latte", tag1: .creamy, tag2: .sweet, tag3: .hot, image: "LattePlaceholder"),
            CoffeeMenuStruct(name: "Vanilla Cold Foam", tag1: .iced, tag2: .creamy, tag3: .sweet, image: "KenanganChocoOrange")
        ]
    ),
    CoffeeShopStruct(
        name: "% Arabica",
        location: "Lorem Ipsum",
        description: "lorem",
        distance: 431,
        steps: 887,
        calories: 1223,
        latitude: -6.30179,
        longitude: 106.65321,
        logo: "arabica",
        menu: [
            CoffeeMenuStruct(name: "Flat White", tag1: .hot, tag2: .creamy, tag3: .strong, image: "KenanganChocoOrange"),
            CoffeeMenuStruct(name: "Iced Lemon Espresso", tag1: .iced, tag2: .bitter, tag3: .sweet, image: "EspressoPlaceholder")
        ]
    ),
    CoffeeShopStruct(
        name: "Kenangan Signature",
        location: "The Breeze",
        description: "lorem",
        distance: 134,
        steps: 412,
        calories: 531,
        latitude: -6.301535,
        longitude: 106.653458,
        logo: "kenangan",
        menu: [
            CoffeeMenuStruct(name: "Kenangan Choco", tag1: .sweet, tag2: .creamy, tag3: .hot, image: "KenanganChocoOrange"),
            CoffeeMenuStruct(name: "Iced Avocado Coffee", tag1: .iced, tag2: .creamy, tag3: .strong, image: "AmericanoPlaceholder"),
            CoffeeMenuStruct(name: "Hot Kopi Susu", tag1: .hot, tag2: .sweet, tag3: .creamy, image: "KenanganChocoOrange")
        ]
    ),
    CoffeeShopStruct(
        name: "Tabemori",
        location: "GOP 6",
        description: "lorem",
        distance: 256,
        steps: 102,
        calories: 45,
        latitude: -6.302768,
        longitude: 106.653470,
        logo: "tabemorilogo",
        menu: [
            CoffeeMenuStruct(name: "Japanese Drip", tag1: .bitter, tag2: .hot, tag3: .strong, image: "AmericanoPlaceholder"),
            CoffeeMenuStruct(name: "Sweet Cafe au Lait", tag1: .sweet, tag2: .creamy, tag3: .hot, image: "KenanganChocoOrange")
        ]
    ),
//    CoffeeShopStruct(
//        name: "Dummy",
//        location: "Lorem Ipsum",
//        description: "lorem",
//        distance: 0,
//        steps: 123,
//        calories: 123,
//        latitude: -6.289458814825691,
//        longitude: 106.62684104712467,
//        logo: "sbux",
//        menu: [
//            CoffeeMenuStruct(name: "Dummy Espresso", tag1: .strong, tag2: .bitter, tag3: .hot, image: "EspressoPlaceholder"),
//            CoffeeMenuStruct(name: "Dummy Milk Ice", tag1: .sweet, tag2: .creamy, tag3: .iced, image: "AmericanoPlaceholder")
//        ]
//    ),
    CoffeeShopStruct(
        name: "Lawson",
        location: "GOP 6",
        description: "lorem",
        distance: 256,
        steps: 102,
        calories: 45,
        latitude: -6.302592,
        longitude: 106.653380,
        logo: "lawsonlogo",
        menu: [
            CoffeeMenuStruct(name: "Lawson Milk Coffee", tag1: .sweet, tag2: .creamy, tag3: .iced, image: "AmericanoPlaceholder"),
            CoffeeMenuStruct(name: "Black Cold Brew", tag1: .bitter, tag2: .strong, tag3: .iced, image: "LattePlaceholder")
        ]
    )
]

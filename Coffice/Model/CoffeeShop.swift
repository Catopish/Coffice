//
//  CoffeeShop.swift
//  Coffice
//
//  Created by Angel on 09/05/25.
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
    let menu: [MenuItem]
}

let coffeeShop: [CoffeeShopStruct] = [
    CoffeeShopStruct(name: "Starbucks", location: "The Breeze", description: "Global coffeehouse chain serving handcrafted espresso drinks, brewed coffee, and light bites in a cozy and work-friendly setting.", distance: 0, steps: 0, calories: 0, latitude: -6.30191, longitude: 106.65438, logo: "sbux", menu: [
        MenuItem(name: "Americano", price: 34, imageName: "espresso", type: "Americano"),
        MenuItem(name: "Caffe Latte", price: 52, imageName: "latte", type: "Latte"),
        MenuItem(name: "Caramel Macchiato", price: 60, imageName: "latte", type: "Latte"),
        MenuItem(name: "Cappuccino", price: 46, imageName: "cappuccino", type: "Cappuccino"),
        MenuItem(name: "Double Shot Ice Shaken Espresso", price: 45, imageName: "espresso", type: "Espresso"),
        MenuItem(name: "Vanilla Latte", price: 52, imageName: "latte", type: "Latte"),
        MenuItem(name: "Cold Brew", price: 45, imageName: "espresso", type: "Cold Brew"),
        MenuItem(name: "Caffe Mocha", price: 54, imageName: "espresso", type: "Mocha"),
        MenuItem(name: "Java Chip Frappuccino", price: 57, imageName: "espresso", type: "Frappuccino"),
        MenuItem(name: "Vanilla Cream Frappuccino", price: 57, imageName: "espresso", type: "Frappuccino"),
        MenuItem(name: "Green Tea Latte", price: 57, imageName: "latte", type: "Latte"),
        MenuItem(name: "Iced Shaken Lemon Tea", price: 43, imageName: "espresso", type: "Non Coffee"),
        MenuItem(name: "Strawberry Açaí Refresher", price: 49, imageName: "espresso", type: "Non Coffee")
    ]),
    CoffeeShopStruct(name: "Fore", location: "The Breeze", description: "Modern, grab-and-go café with sleek design and limited seating—best for short breaks or quick coffee runs.", distance: 0, steps: 0, calories: 0, latitude: -6.302514, longitude: 106.654299, logo: "forelogo", menu: [
        MenuItem(name: "Iced Starrycano", price: 25, imageName: "latte", type: "Americano"),
        MenuItem(name: "Iced Bumi Latte", price: 37, imageName: "latte", type: "Latte"),
        MenuItem(name: "Iced Cappuccino", price: 35, imageName: "cappuccino", type: "Cappuccino"),
        MenuItem(name: "Espresso", price: 30, imageName: "espresso", type: "Espresso"),
        MenuItem(name: "Butterscotch Sea Salt Latte", price: 42, imageName: "latte", type: "Latte"),
        MenuItem(name: "Matcha Latte", price: 40, imageName: "latte", type: "Latte"),
        MenuItem(name: "Chizu Chocolate", price: 38, imageName: "latte", type: "Non Coffee"),
        MenuItem(name: "Hazelnut Latte", price: 41, imageName: "latte", type: "Latte"),
        MenuItem(name: "Kopi Gula Aren", price: 36, imageName: "espresso", type: "Espresso"),
        MenuItem(name: "Chizu Matcha", price: 39, imageName: "latte", type: "Non Coffee")
    ]),
    CoffeeShopStruct(name: "36 Grams", location: "GOP 1", description: "Small specialty coffee kiosk with limited seating and a cozy vibe—best for quick coffee breaks or takeaway, not ideal for working long hours.", distance: 0, steps: 0, calories: 0, latitude: -6.301446, longitude: 106.650023, logo: "logo36grams", menu: [
        MenuItem(name: "Iced Lemon Coffe Soda", price: 44, imageName: "latte", type: "Latte"),MenuItem(name: "Kopi Gula Aren", price: 24, imageName: "espresso", type: "Americano"),
        MenuItem(name: "Dark Cloudy Bay", price: 27, imageName: "cappuccino", type: "Americano"),
        MenuItem(name: "Spanish Latte", price: 40, imageName: "latte", type: "Latte"),
        MenuItem(name: "Coconut Latte", price: 30, imageName: "latte", type: "Latte"),
        MenuItem(name: "Iced Matcha Latte", price: 37, imageName: "latte", type: "Latte"),
        MenuItem(name: "Mocha Peppermint", price: 42, imageName: "latte", type: "Latte"),
        MenuItem(name: "Coco Mint", price: 29, imageName: "latte", type: "Non Coffee")
    ]),
    CoffeeShopStruct(name: "Tamper", location: "The Breeze", description: "Artisan coffee shop specializing in manual brew methods and locally sourced beans, ideal for coffee enthusiasts.", distance: 0, steps: 0, calories: 0, latitude: -6.301870, longitude: 106.654210, logo: "tamperlogo", menu: [
        MenuItem(name: "Es Kopi Mahal", price: 28, imageName: "latte", type: "Espresso"),
        MenuItem(name: "Es Kopi Susu Tajir", price: 32, imageName: "latte", type: "Espresso"),
        MenuItem(name: "Espresso", price: 40, imageName: "espresso", type: "Espresso"),
        MenuItem(name: "Cappuccino", price: 45, imageName: "cappuccino", type: "Cappuccino"),
        MenuItem(name: "Ice Green Tea Latte", price: 52, imageName: "latte", type: "Latte"),
        MenuItem(name: "Vanilla Latte", price: 46, imageName: "latte", type: "Latte"),
        MenuItem(name: "Choco Hazelnut", price: 48, imageName: "latte", type: "Non Coffee"),
        MenuItem(name: "Cold Brew Coffee", price: 45, imageName: "latte", type: "Cold Brew"),
        MenuItem(name: "Nitro Cold Brew", price: 91, imageName: "latte", type: "Latte"),
        MenuItem(name: "Kopi Susu Gula Aren", price: 44, imageName: "latte", type: "Latte")
    ]),
    CoffeeShopStruct(name: "% Arabica", location: "The Breeze", description: "International specialty coffee brand from Kyoto, known for its high-quality beans, precision brewing, and sleek minimalist design.", distance: 0, steps: 0, calories: 0, latitude: -6.30179, longitude: 106.65321, logo: "logoarabica", menu: [
        MenuItem(name: "% Arabica Iced White Mocha Blend 12oz", price: 69, imageName: "espresso", type: "Espresso"),
        MenuItem(name: "% Arabica Iced Americano Blend 12oz", price: 49, imageName: "espresso", type: "Americano"),
        MenuItem(name: "% Arabica Iced Lemonade Still 12oz", price: 51, imageName: "espresso", type: "Non Coffee"),
        MenuItem(name: "% Arabica Iced Spanish Latte Blend 12oz", price: 65, imageName: "espresso", type: "Latte"),
        MenuItem(name: "% Arabica Iced Matcha Latte 12oz", price: 65, imageName: "espresso", type: "Latte"),
        MenuItem(name: "% Arabica Iced Dark latte 12oz", price: 69, imageName: "espresso", type: "Latte")
    ]),
    CoffeeShopStruct(name: "Kenangan Signature", location: "The Breeze", description: "Premium coffee shop offering modern takes on Indonesian coffee, with an upscale ambiance and exclusive menu items.", distance: 0, steps: 0, calories: 0, latitude: -6.301535, longitude: 106.653458, logo: "kenangan", menu: [
        MenuItem(name: "Kopi Kenangan Mantan", price: 38, imageName: "latte", type: "Latte"),
        MenuItem(name: "Americano", price: 40, imageName: "espresso", type: "Americano"),
        MenuItem(name: "Latte", price: 47, imageName: "latte", type: "Latte"),
        MenuItem(name: "Kopi Susu Gula Aren", price: 44, imageName: "latte", type: "Latte"),
        MenuItem(name: "Avocado Coffee", price: 50, imageName: "latte", type: "Non Coffee")
    ]),
    CoffeeShopStruct(name: "Tabemori", location: "GOP 6", description: "A cafe serving coffee and fare in a calm, minimalist environment.", distance: 0, steps: 0, calories: 0, latitude: -6.302768, longitude: 106.653470, logo: "tabemorilogo", menu: [
        MenuItem(name: "Iced Americano", price: 21, imageName: "cappuccino", type: "Americano"),
        MenuItem(name: "Iced Rich Aren", price: 24, imageName: "espresso", type: "Espresso"),
        MenuItem(name: "Iced Cheezy Rich", price: 29, imageName: "cappuccino", type: "Espresso"),
        MenuItem(name: "Iced Caramel Machiatto", price: 29, imageName: "cappuccino", type: "Non Coffee"),
        MenuItem(name: "Iced Regal Rum Cafe Latte", price: 29, imageName: "cappuccino", type: "Latte"),
        MenuItem(name: "Iced Oreo Rum Cafe Latte", price: 29, imageName: "cappuccino", type: "Latte"),
        MenuItem(name: "Iced Chocolate", price: 28, imageName: "cappuccino", type: "Non Coffee"),
        MenuItem(name: "Iced Fruit Punch", price: 29, imageName: "cappuccino", type: "Non Coffee"),
        MenuItem(name: "Iced Summer Punch", price: 27, imageName: "cappuccino", type: "Non Coffee"),
        MenuItem(name: "Iced Klepon Cafe Latte", price: 29, imageName: "latte", type: "Latte")
    ]),
    CoffeeShopStruct(name: "Apple Academy", location: "GOP 9", description: "Hai, ini cuman buat test aja", distance: 0, steps: 0, calories: 0, latitude: -6.302168805766506, longitude: 106.65218820473441, logo: "sbux", menu: [
        MenuItem(name: "Espresso", price: 50, imageName: "espresso", type: "Espresso"),
        MenuItem(name: "Cappuccino", price: 55, imageName: "cappuccino", type: "Cappuccino"),
        MenuItem(name: "Latte", price: 57, imageName: "latte", type: "Latte")
    ]),
    CoffeeShopStruct(name: "Lawson", location: "GOP 6", description: "A convenience store offering ready-to-go coffee, snacks, and quick meals for people on the move.", distance: 0, steps: 0, calories: 0, latitude: -6.302592, longitude: 106.653380, logo: "lawsonlogo", menu: [
        MenuItem(name: "Arabica Gayo", price: 18, imageName: "espresso", type: "Espresso"),
        MenuItem(name: "Cappuccino", price: 22, imageName: "cappuccino", type: "Cappuccino"),
        MenuItem(name: "Ice Coffee Latte", price: 22, imageName: "latte", type: "Latte"),
        MenuItem(name: "Ice Caramel Vanilla (Fresh Milk)", price: 69, imageName: "espresso", type: "Espresso"),
        MenuItem(name: "Ice Choco Richi", price: 22, imageName: "espresso", type: "Non Coffee"),
        MenuItem(name: "Ice Honey Yuzu", price: 22, imageName: "espresso", type: "Non Coffee"),
        MenuItem(name: "Ice Pink Blossom Tea", price: 10, imageName: "espresso", type: "Non Coffee")
    ]),
    CoffeeShopStruct(name: "Bean! Spot Alfamart", location: "GOP 9", description: "Casual coffee counter located inside Alfamart, serving affordable fresh coffee alongside convenience store items.", distance: 0, steps: 0, calories: 0, latitude: -6.302168805766506, longitude: 106.65218820473441, logo: "beanspotlogo", menu: [
        MenuItem(name: "Single Espresso", price: 10, imageName: "espresso", type: "Espresso"),
        MenuItem(name: "Americano", price: 15, imageName: "cappuccino", type: "Americano"),
        MenuItem(name: "Latte", price: 15, imageName: "latte", type: "Latte"),
        MenuItem(name: "Cappuccino", price: 15, imageName: "espresso", type: "Cappuccino"),
        MenuItem(name: "Chocolate", price: 15, imageName: "espresso", type: "Non Coffee"),
        MenuItem(name: "Mocha", price: 18, imageName: "espresso", type: "Mocha"),
        MenuItem(name: "Gula Aren", price: 18, imageName: "espresso", type: "Non Coffee")
    ])
]

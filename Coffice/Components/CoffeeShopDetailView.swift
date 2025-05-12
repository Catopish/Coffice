////
////  Overlay.swift
////  Coffice
////
////  Created by Al Amin Dwiesta on 24/03/25.
////

import SwiftUI
import MapKit

struct CoffeeShopDetailView: View {
    let coffeeShop: CoffeeShopStruct
    
    var body: some View {
        VStack {
            Text(coffeeShop.name)
                .font(.largeTitle)
            Text("Distance: \(Int(coffeeShop.distance)) m")
        }
        .navigationTitle(coffeeShop.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

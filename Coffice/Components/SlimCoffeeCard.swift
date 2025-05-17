//
//  SlimCoffeeCard.swift
//  Coffice
//
//  Created by Al Amin Dwiesta on 12/05/25.
//

import SwiftUI
import Foundation

struct SlimCoffeeCard: View {
    var coffee:CoffeeMenuStruct
    var shopName: String
    
    var body: some View {
        ZStack(){
            Rectangle()
                .foregroundColor(Color(red: 0.66, green: 0.36, blue: 0.18))
                .frame(width: 114, height: 141)
                .cornerRadius(20)
            Image("\(coffee.image)")
            //            Image("AmericanoPlaceholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 77, height: 112)
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 114, height: 141)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .black,
                            .clear
                        ]),
                        startPoint: .bottom,
                        endPoint: .center
                    )
                )
                .opacity(0.8)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("\(coffee.name)")
                    .font(Font.custom("SF Pro", size: 16).weight(.semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Text("\(shopName)")
                    .font(Font.custom("SF Pro", size: 10).weight(.light))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: 100, maxHeight: .infinity, alignment: .bottomLeading)
            .padding([.leading, .bottom], 12)
        }
    }
}


//#Preview {
//    SlimCoffeeCard()
//}

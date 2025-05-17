//
//  SlimCoffeeCard.swift
//  Coffice
//
//  Created by Al Amin Dwiesta on 12/05/25.
//

import SwiftUI
import Foundation

struct MediumCoffeeCard: View {
    var coffee: CoffeeMenuStruct
    
    var body: some View {
        ZStack(){
            Rectangle()
                .foregroundColor(Color(red: 0.66, green: 0.36, blue: 0.18))
                .frame(width: 179, height: 167)
                .cornerRadius(20)
            Image("\(coffee.image)")
            //            Image("AmericanoPlaceholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 87, height: 132)
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 179, height: 167)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .black,
                            .clear
                        ]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .opacity(0.6)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: -1) {
                Text("\(coffee.name)")
                    .font(Font.custom("SF Pro", size: 20).weight(.bold))
                    .foregroundColor(.white)
                HStack(spacing: 4) {
                    Image(systemName: "tag.fill")
                        .font(Font.custom("SF Pro", size: 9).weight(.bold))
                        .foregroundColor(.white)
                    Text("\(coffee.tag1) | \(coffee.tag2) | \(coffee.tag3)")
                        .font(Font.custom("SF Pro", size: 11).weight(.bold))
                        .foregroundColor(.white)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .padding([.leading, .bottom], 12)
        }
    }
}


//#Preview {
//    MediumCoffeeCard()
//}

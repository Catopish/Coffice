//
//  SlimCoffeeCard.swift
//  Coffice
//
//  Created by Al Amin Dwiesta on 12/05/25.
//

import SwiftUI
import Foundation

struct SlimCoffeeCard: View {
    var body: some View {
        ZStack(){
            Rectangle()
                .foregroundColor(Color(red: 0.66, green: 0.36, blue: 0.18))
                .frame(width: 104, height: 141)
                .cornerRadius(20)
            Image("KenanganChocoOrange")
            //            Image("AmericanoPlaceholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 77, height: 112)
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 104, height: 141)
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
            
            VStack(alignment: .leading, spacing: -3) {
                Text("Capuccino")
                    .font(Font.custom("SF Pro", size: 16).weight(.semibold))
                    .lineSpacing(20)
                    .foregroundColor(.white)
                Text("Kopi Kenangan")
                    .font(Font.custom("SF Pro", size: 10).weight(.light))
                    .lineSpacing(20)
                    .foregroundColor(.white)
            }
            .frame(width: 82, height: 30)
            .offset(x: 0, y: 46.50)
            
        }
    }
}


#Preview {
    SlimCoffeeCard()
}

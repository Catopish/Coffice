//
//  SplashScreen.swift
//  Coffice
//
//  Created by Angel on 09/04/25.
//


import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color.brown4
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Image("logocoffice")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
//                    .shadow(radius: 2)

            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

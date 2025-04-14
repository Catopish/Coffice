//
//  CofficeApp.swift
//  Coffice
//
//  Created by Hafi on 20/03/25.
//

import SwiftUI
import SwiftData

@main
struct CofficeApp: App {
    @State private var isSplashActive = true
    @AppStorage("userName") var userName: String = ""
    
    var body: some Scene {
        WindowGroup {
            if isSplashActive {
                SplashScreenView()
                    .onAppear {
                        // Delay 2 detik sebelum masuk ke main view
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                isSplashActive = false
                            }
                        }
                    }
            } else {
                
                if userName.isEmpty {
                    OnboardingView()
                }
                else {
                    Homepage()
                }
            }
        }
    }
}

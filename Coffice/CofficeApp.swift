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
    @AppStorage("userName") var userName: String = ""
    
    var body: some Scene {
        WindowGroup {
            if userName.isEmpty {
                OnboardingView()
            }
            else {
                Homepage()
            }
        }
    }
}

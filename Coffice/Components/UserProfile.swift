//
//  userProfile.swift
//  Coffice
//
//  Created by Hafi on 22/04/25.
//


import SwiftUI
import SwiftData
import HealthKit
import CoreLocation

struct UserProfile: View {
    @AppStorage("userName") var userName: String = ""
    @ObservedObject var streakManager : StreakManager
    

//    let daysStreak = UserDefaults.standard.integer(forKey: "streak")
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Hi, \(userName)!")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.leading, 6)
                Text("Let’s walk and sip! ☕️")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .padding(.leading, 6)
            }
            .padding()
            Spacer()
            VStack {
                Image(systemName: "flame.fill")
                    .font(.title)
                    .padding(.trailing, 6)
                Text("\(streakManager.streak) streak")
                    .padding(.trailing, 6)
            }
            .padding()
            .foregroundColor(.white)
            .padding(.horizontal, 5)
        }
    }
}

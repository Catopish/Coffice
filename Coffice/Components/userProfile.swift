//
//  userProfile.swift
//  Coffice
//
//  Created by Hafi on 08/04/25.
//
import SwiftUI

struct userProfile: View {
    @AppStorage("userName") var userName: String = ""
    @StateObject var streakManager = StreakManager()
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Hi, \(userName)!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Let’s walk and sip! ☕️")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .padding()
            Spacer()
            HStack {
                Text("\(streakManager.streak) Streak")
                Image(systemName: "flame.fill")
            }
            .padding()
            .background(Color.brown2)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: 150, height: 20)
            .padding(.horizontal, 5)
        }
    }
}

//
//  PreferencesQuestionView.swift
//  Coffice
//
//  Created by Al Amin Dwiesta on 12/05/25.
//

import SwiftUI
import Foundation

struct PreferencesQuestionView: View {
    var body: some View {
        ZStack(alignment: .leading){
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.86, green: 0.64, blue: 0.50),
                    .white
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading,spacing: 20){
                HStack(){
                    Text("Questions")
                        .font(.headline)
                        .foregroundStyle(.black)
                    Spacer()
                    Text("skip")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                .padding(.top,20)
                .padding(.horizontal,24)
                
                Text("What is your coffee preferences? ")
                    .font(Font.custom("SF Pro", size: 32).weight(.bold))
                    .foregroundColor(.black)
                    .padding(.horizontal,24)
                Text("Help us customize your experience")
                    .font(Font.custom("SF Pro", size: 15).weight(.light))
                    .foregroundColor(Color(red: 0.28, green: 0.23, blue: 0.16))
                    .padding(.horizontal,24)
                
                HStack{
                    Spacer()
                    QuestionsCard()
                    Spacer()
                }
                HStack(spacing: 105) {
                    buttonQuestionsCard(systemname: "xmark")
                    buttonQuestionsCard(systemname: "checkmark")
                }
                .frame(maxWidth: .infinity,alignment: .center)
            }
            .padding(.bottom,120)
        }
    }
}

#Preview {
    PreferencesQuestionView()
}

struct buttonQuestionsCard : View {
    var systemname: String
    
    var body: some View {
        ZStack{
            Ellipse()
                .foregroundColor(.white)
                .frame(width: 80, height: 80)
                .shadow(
                    color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 1
                )
            
            Image(systemName: systemname)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(Color(red: 0.66, green: 0.36, blue: 0.18)) // Matching theme
        }
    }
}

struct QuestionsCard : View {
    var body: some View {
        VStack(spacing: 54) {
            HStack(spacing: 5) {
                Text("1/5")
                    .font(Font.custom("SF Pro", size: 11))
                    .lineSpacing(22)
                    .foregroundColor(.black)
            }
            .padding(10)
            .frame(height: 19)
            .background(Color(red: 0.97, green: 0.91, blue: 0.87))
            .cornerRadius(15)
            Text("Do you like sweet?")
                .font(Font.custom("SF Pro", size: 16).weight(.bold))
                .lineSpacing(22)
                .foregroundColor(.black)
        }
        .padding(EdgeInsets(top: 20, leading: 30, bottom: 90, trailing: 30))
        .frame(width: 266.83, height: 247.16,alignment: .center)
        .background(.white)
        .cornerRadius(15)
        .shadow(
            color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 5, x: 1, y: 1
        )
        
    }
}

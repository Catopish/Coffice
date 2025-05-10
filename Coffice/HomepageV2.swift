//
//  HomepageV2.swift
//  Coffice
//
//  Created by Al Amin Dwiesta on 09/05/25.
//

import SwiftUI
import Foundation

struct HomepageV2: View {
    @StateObject private var healthViewModel = HealthDashboardViewModel()
    
    @State var isLoading: Bool = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            //                        heading()
            VStack(alignment: .leading) {
                userProfileV2()
                HealthDashboardView(viewModel: healthViewModel, isLoading: $isLoading)
                Spacer()
                
            }
            
        }
        .foregroundColor(.clear)
        .frame(width: 393)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.86, green: 0.64, blue: 0.50),
                    .white
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

struct heading: View {
    var body: some View{
        VStack(spacing: 0) {
            Color.brown2.frame(height: 200)
            Spacer()
        }
        .ignoresSafeArea()
        VStack(spacing: 0) {
            Image("cofe")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
            //            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct userProfileV2: View {
    @AppStorage("userName") var userName: String = ""
    
    var body: some View {
        HStack()  {
            VStack(alignment: .leading) {
                Text("Hi, \(userName)!")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.leading, 6)
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    HomepageV2()
}

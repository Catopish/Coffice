//
//  ActivitySummary.swift
//  Coffice
//
//  Created by Hafi on 08/04/25.
//
import SwiftUI


struct ActivitySummary: View {
//    @StateObject var healthManager = HealthManager()
    @ObservedObject var liveViewModel: LiveActivityViewModel
    
    var body: some View {
        Spacer()
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image (systemName: "figure.walk")
                    .padding(.bottom)
                Text("Your Activity")
                    .foregroundColor(Color("brown3"))
                    .padding(.bottom)
                    .fontWeight(.bold)
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Move")
                        .font(.headline)
                        .foregroundColor(Color("brown2"))
                    
                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text("\(liveViewModel.liveCalories, specifier: "%.1f")")
                            .font(.title)
                            .foregroundStyle(.primary)
                            .foregroundColor(Color("brown3"))
                        
                        Text("CAL")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                    }
                }
                
                Spacer()
                VStack(alignment: .leading, spacing: 2) {
                    Text("Steps")
                        .font(.headline)
                        .foregroundColor(Color("brown2"))
                    
                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text("\(liveViewModel.liveSteps)")
                            .font(.title)
                            .foregroundStyle(.primary)
                            .foregroundColor(Color("brown3"))
                        Text("STEPS")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .frame(width: 320, height: 130)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

//
//  HealthDashboardView.swift
//  Coffice
//
//  Created by Al Amin Dwiesta on 06/04/25.
//

import SwiftUI
import HealthKit


struct HealthDashboardView: View {
    @ObservedObject var viewModel = HealthDashboardViewModel()
    @Binding var isLoading: Bool
    
    var body: some View {
        VStack {
            if viewModel.isHealthKitAvailable {
                DashboardCard(isLoading: $isLoading, viewModel: viewModel)
            } else {
                Text("HealthKit is not available on this device")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            viewModel.requestAuthorization()
        }
    }
}

struct DashboardCard: View {
    @Binding var isLoading: Bool
    @ObservedObject var viewModel: HealthDashboardViewModel
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                Text("Today's Activity")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(Color(red: 0.66, green: 0.36, blue: 0.18))
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.top, 10)
            
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    HealthStatRow(
                        icon: "flame.fill",
                        color: .brown2,
                        title: "Move",
                        value: "\(Int(viewModel.activeCalories))",
                        unit: "kcal",
                        isLoading: $isLoading
                    )
                    
                }
                VStack(alignment: .leading, spacing: 12) {
                    HealthStatRow(
                        icon: "figure.walk",
                        color: .brown2,
                        title: "Exercises",
                        value: "\(viewModel.steps)",
                        unit: "steps",
                        isLoading: $isLoading
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)            }
            .padding(.top, -20)
            .padding(20)
            .padding(.bottom,-5)
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        //        .shadow(radius: 4)
        .padding()
    }
}

struct HealthStatRow: View {
    let icon: String
    let color: Color
    let title: String
    let value: String
    let unit: String
    @Binding var isLoading: Bool
    
    var body: some View {
        VStack(alignment:.leading) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(Color(red: 0.66, green: 0.36, blue: 0.18))
            //                .foregroundColor(.secondary)
                .frame(alignment: .leading)
            
            
            HStack(alignment: .firstTextBaseline, spacing: 2){
                Text(isLoading ? "Loading..." :"\(value)/3274")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 0.28, green: 0.23, blue: 0.16))
                //                    .frame(alignment: .leading)
                
                //                Text(isLoading ? "Loading..." :value)
                //                    .bold()
                
                Text(unit)
                    .foregroundColor(Color(red: 0.28, green: 0.23, blue: 0.16))
                    .font(.caption)
            }
        }
    }
}

#Preview{
    DashboardCard(isLoading: .constant(false), viewModel: .init())
}

struct ActivityRingView: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            // Background Ring
            Circle()
                .stroke(lineWidth: 12)
                .opacity(0.3)
                .foregroundColor(.red)
            
            // Progress Ring
            Circle()
                .trim(from: 0.0, to: min(CGFloat(progress), 1.0))
                .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                .foregroundColor(.red)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
            
            // Percentage Text
            VStack {
                Text("\(Int(progress * 100))%")
                    .font(.title3)
                    .bold()
                
                Text("MOVE")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}


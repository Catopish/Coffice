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
        VStack {
            HStack {
                Text("Today's Activity")
                    .font(.headline)
                    .padding(10)
                    .padding(.horizontal)
                Spacer()
            }
            
            HStack(spacing: 20) {
                // Activity Ring
                ActivityRingView(progress: viewModel.moveGoalProgress)
                    .frame(width: 100, height: 100)


                // Health Stats
                VStack(alignment: .leading, spacing: 12) {
                    HealthStatRow(
                        icon: "flame.fill",
                        color: .brown2,
                        title: "Move",
                        value: "\(Int(viewModel.activeCalories))",
                        unit: "CAL",
                        isLoading: $isLoading
                    )
                    
                    HealthStatRow(
                        icon: "figure.walk",
                        color: .brown2,
                        title: "Steps",
                        value: "\(viewModel.steps)",
                        unit: "STEPS",
                        isLoading: $isLoading
                    )
                    
//                    HealthStatRow(
//                        icon: "figure.walk",
//                        color: .blue,
//                        title: "Distance",
//                        value: String(format: "%.1f", viewModel.distance),
//                        unit: "M"
//                    )
                }
            }
            .padding(.bottom, 20)
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding()
        .padding(.bottom, -20)
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
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 30)
            
            Text(title)
                .foregroundColor(.secondary)
                .frame(width: 60, alignment: .leading)
            
            Text(isLoading ? "Loading..." :value)
                .bold()
            
            Text(unit)
                .foregroundColor(.secondary)
                .font(.caption)
        }
    }
}

struct ActivityRingView: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            // Background Ring
            Circle()
                .stroke(lineWidth: 12)
                .opacity(0.3)
                .foregroundColor(.brown2)
            
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

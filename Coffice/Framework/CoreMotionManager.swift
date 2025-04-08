//
//  CoreMotionManager.swift
//  Coffice
//
//  Created by Al Amin Dwiesta on 08/04/25.
//

import Foundation
import CoreMotion
import Combine

class LiveActivityViewModel: ObservableObject {
    private let pedometer = CMPedometer()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var liveSteps: Int = 0
    @Published var liveCalories: Double = 0.0
    @Published var isTracking: Bool = false

    // Optional: you could allow setting this based on user profile
    private let userWeightKg: Double = 60.0
    
    func startLiveActivity() {
        guard CMPedometer.isStepCountingAvailable() else {
            print("Pedometer not available.")
            return
        }

        liveSteps = 0
        liveCalories = 0.0
        isTracking = true

        pedometer.startUpdates(from: Date()) { [weak self] data, error in
            guard let self = self, error == nil, let data = data else { return }

            DispatchQueue.main.async {
                self.liveSteps = data.numberOfSteps.intValue
                self.liveCalories = self.estimateCalories(steps: self.liveSteps, weightKg: self.userWeightKg)
            }
        }
    }

    func stopLiveActivity() {
        pedometer.stopUpdates()
        isTracking = false
        // Save to UserDefaults
        UserDefaults.standard.set(liveSteps, forKey: "latestStepActivity")
        UserDefaults.standard.set(liveCalories, forKey: "latestCaloriesActivity")    }

    private func estimateCalories(steps: Int, weightKg: Double) -> Double {
        // Simple MET-based estimation
        // 0.04 kcal per step per kg — can be adjusted based on better formulas
        return Double(steps) * 0.04 * (weightKg / 60.0)
    }
}

import SwiftUI
import HealthKit

class HealthDashboardViewModel: ObservableObject {
    private let healthStore = HKHealthStore()
    private let calendar = Calendar.current
    
    @Published var isHealthKitAvailable = false
    @Published var activeCalories: Double = 0
    @Published var steps: Int = 0
    @Published var distance: Double = 0
    @Published var moveGoalProgress: Double = 0
    
    private let moveGoalTarget: Double = 700 // Default move goal (calories)
    
    init() {
        isHealthKitAvailable = HKHealthStore.isHealthDataAvailable()
        if isHealthKitAvailable {
            // Initial load with empty data
        }
    }
    
    func requestAuthorization() {
        guard isHealthKitAvailable else { return }
        
        // Define the types we want to read
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .stepCount)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        ]
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
            if success {
                DispatchQueue.main.async {
                    self.fetchTodayData()
                }
            } else if let error = error {
                print("Authorization failed with error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchTodayData() {
        fetchActiveCalories()
        fetchSteps()
        fetchDistance()
    }
    
    private func fetchActiveCalories() {
        guard let caloriesType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else { return }
        
        fetchTodaySumStatistics(for: caloriesType, unit: HKUnit.kilocalorie()) { result in
            DispatchQueue.main.async {
                self.activeCalories = result
                self.moveGoalProgress = self.activeCalories / self.moveGoalTarget
            }
        }
    }
    
    private func fetchSteps() {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        
        fetchTodaySumStatistics(for: stepType, unit: HKUnit.count()) { result in
            DispatchQueue.main.async {
                self.steps = Int(result)
            }
        }
    }
    
    private func fetchDistance() {
        guard let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else { return }
        
        fetchTodaySumStatistics(for: distanceType, unit: HKUnit.meter()) { result in
            DispatchQueue.main.async {
                self.distance = result
            }
        }
    }
    
    private func fetchTodaySumStatistics(for quantityType: HKQuantityType, unit: HKUnit, completion: @escaping (Double) -> Void) {
        // Get today's start and end
        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)
        
        // Create predicate to fetch data for today only
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        // Create the query
        let query = HKStatisticsQuery(
            quantityType: quantityType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            
            completion(sum.doubleValue(for: unit))
        }
        
        // Execute the query
        healthStore.execute(query)
    }
}


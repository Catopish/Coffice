import HealthKit
import Foundation
import Combine

class HealthManager: ObservableObject {
    private var healthStore = HKHealthStore()
    private var stepAnchor: HKQueryAnchor?
    private var calorieAnchor: HKQueryAnchor?
    
    @Published var stepsToday: Double = 0
    @Published var caloriesToday: Double = 0
    
    init() {
        requestAuthorization()
    }
    
    func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else { return }
        
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        
        let readTypes: Set = [stepType, calorieType]
        
        healthStore.requestAuthorization(toShare: nil, read: readTypes) { success, error in
            if success {
                DispatchQueue.main.async {
                    self.startObservingSteps()
                    self.startObservingCalories()
                }
            }
        }
    }
    
    func startObservingSteps() {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date(), options: .strictStartDate)
        
        let query = HKAnchoredObjectQuery(type: stepType, predicate: predicate, anchor: stepAnchor, limit: HKObjectQueryNoLimit) { _, samples, _, newAnchor, _ in
            self.stepAnchor = newAnchor
            self.processSteps(samples)
        }
        
        query.updateHandler = { _, samples, _, newAnchor, _ in
            self.stepAnchor = newAnchor
            self.processSteps(samples)
        }
        
        healthStore.execute(query)
    }
    
    func processSteps(_ samples: [HKSample]?) {
        guard let quantitySamples = samples as? [HKQuantitySample] else { return }
        
        let newSteps = quantitySamples.reduce(0.0) { sum, sample in
            sum + sample.quantity.doubleValue(for: .count())
        }
        
        DispatchQueue.main.async {
            self.stepsToday += newSteps
        }
    }
    
    func startObservingCalories() {
        let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date(), options: .strictStartDate)
        
        let query = HKAnchoredObjectQuery(type: calorieType, predicate: predicate, anchor: calorieAnchor, limit: HKObjectQueryNoLimit) { _, samples, _, newAnchor, _ in
            self.calorieAnchor = newAnchor
            self.processCalories(samples)
        }
        
        query.updateHandler = { _, samples, _, newAnchor, _ in
            self.calorieAnchor = newAnchor
            self.processCalories(samples)
        }
        
        healthStore.execute(query)
    }
    
    func processCalories(_ samples: [HKSample]?) {
        guard let quantitySamples = samples as? [HKQuantitySample] else { return }
        
        let newCalories = quantitySamples.reduce(0.0) { sum, sample in
            sum + sample.quantity.doubleValue(for: .kilocalorie())
        }
        
        
        DispatchQueue.main.async {
            self.caloriesToday += newCalories
        }
    }
}


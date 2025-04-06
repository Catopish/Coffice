import SwiftUI
import HealthKit

struct HealthDashboardView: View {
    @ObservedObject private var viewModel = HealthDashboardViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isHealthKitAvailable {
                DashboardCard(viewModel: viewModel)
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
    @ObservedObject var viewModel: HealthDashboardViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Today's Activity")
                    .font(.headline)
                    .padding(.leading)
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
                        unit: "CAL"
                    )
                    
                    HealthStatRow(
                        icon: "figure.walk",
                        color: .brown2,
                        title: "Steps",
                        value: "\(viewModel.steps)",
                        unit: "STEPS"
                    )
                    
//                    HealthStatRow(
//                        icon: "figure.walk",
//                        color: .blue,
//                        title: "Distance",
//                        value: String(format: "%.1f", viewModel.distance),
//                        unit: "M"
//                    )
                }
                .padding(.trailing)
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 4)
        .padding()
    }
}

struct HealthStatRow: View {
    let icon: String
    let color: Color
    let title: String
    let value: String
    let unit: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 30)
            
            Text(title)
                .foregroundColor(.secondary)
                .frame(width: 60, alignment: .leading)
            
            Text(value)
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

// Preview
struct HealthDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        HealthDashboardView()
    }
}

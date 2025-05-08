import Foundation

class StreakManager: ObservableObject {
    @Published var streak: Int = 0
    @Published var shouldShowStreak: Bool = false
    
    private let streakKey = "userStreak"
    private let lastDateKey = "lastStreakDate"
    private let showStreakKey = "showStreak"
    init() {
        loadStreak()
    }
    
    func completeToday() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let lastDate = UserDefaults.standard.object(forKey: lastDateKey) as? Date

        //        var showStreak : Bool = false
        
        if let last = lastDate, calendar.isDate(last, inSameDayAs: today) {
            return
        }        // Check if today is consecutive to the last streak day.
        if let last = lastDate,
           let yesterday = calendar.date(byAdding: .day, value: 1, to: last),
           calendar.isDate(yesterday, inSameDayAs: today) {
            print(1)
            streak += 1
        } else {
            streak = 1
            print(2)
        }
        
        // Save updated streak and the date.
        UserDefaults.standard.set(streak, forKey: streakKey)
        UserDefaults.standard.set(today, forKey: lastDateKey)
        
        // Signal to the UI that the streak page should be shown.
        shouldShowStreak = true
        UserDefaults.standard.set(streak, forKey: streakKey)
        UserDefaults.standard.set(today, forKey: lastDateKey)

    }
    
    private func loadStreak() {
        streak = UserDefaults.standard.integer(forKey: streakKey)
    }
}

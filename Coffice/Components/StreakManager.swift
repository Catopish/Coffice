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
        let today = Calendar.current.startOfDay(for: Date())
        let lastDate = UserDefaults.standard.object(forKey: lastDateKey) as? Date ?? Date.distantPast
        //        var showStreak : Bool = false
        
        if Calendar.current.isDateInToday(lastDate) {
            // Udah diselesaikan hari ini → jangan tambah streak
            return
        }
        // Check if today is consecutive to the last streak day.
        if lastDate != Date.distantPast,
           let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: lastDate),
           Calendar.current.isDate(today, inSameDayAs: nextDate) {
            // It is a consecutive day.
            print(1)
            streak += 1
        } else {
            // It's either the first time or not consecutive.
            streak = 1
            print(2)
        }
        
        // Save updated streak and the date.
        UserDefaults.standard.set(streak, forKey: streakKey)
        UserDefaults.standard.set(today, forKey: lastDateKey)
        
        // Signal to the UI that the streak page should be shown.
        shouldShowStreak = true
        print(3)
        print(shouldShowStreak)
        //        if Calendar.current.isDate(today, equalTo: lastDate.addingTimeInterval(86400), toGranularity: .day) {
        //            // Lanjutan dari kemarin → tambah streak
        //            streak += 1
        //            shouldShowStreak = true
        //            print(shouldShowStreak)
        //        } else {
        //            // Bukan hari setelahnya → reset
        //            print("test")
        //            streak = 1
        //        }
        
        UserDefaults.standard.set(streak, forKey: streakKey)
        UserDefaults.standard.set(today, forKey: lastDateKey)
        //        UserDefaults.standard.set(showStreak, forKey: showStreakKey)
    }
    
    private func loadStreak() {
        streak = UserDefaults.standard.integer(forKey: streakKey)
    }
}

import Foundation

class StreakManager: ObservableObject {
    @Published var streak: Int = 0
    
    private let streakKey = "userStreak"
    private let lastDateKey = "lastStreakDate"
    
    init() {
        loadStreak()
    }
    
    func completeToday() {
        let today = Calendar.current.startOfDay(for: Date())
        let lastDate = UserDefaults.standard.object(forKey: lastDateKey) as? Date ?? Date.distantPast
        
        if Calendar.current.isDateInToday(lastDate) {
            // Udah diselesaikan hari ini → jangan tambah streak
            return
        }

        if Calendar.current.isDate(today, equalTo: lastDate.addingTimeInterval(86400), toGranularity: .day) {
            // Lanjutan dari kemarin → tambah streak
            streak += 1
        } else {
            // Bukan hari setelahnya → reset
            streak = 1
        }

        UserDefaults.standard.set(streak, forKey: streakKey)
        UserDefaults.standard.set(today, forKey: lastDateKey)
    }
    
    private func loadStreak() {
        streak = UserDefaults.standard.integer(forKey: streakKey)
    }
}

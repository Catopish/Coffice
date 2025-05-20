import SwiftUI

struct AlertStreak: View {
    @ObservedObject var streakManager : StreakManager
//    @Binding var showPopupAlert : Bool
    @State private var isYes = false
    @Environment(\.dismiss) var dismiss
//    var onDismiss: () -> Void = {}

    var body: some View {
        ZStack {
            Color.brown4
            .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text("\(streakManager.streak) DAY STREAK")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()
                
                Image("kopi2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.brown2)
                Text("You’ve brewed a streak for \(streakManager.streak) days! \n Don’t let the cup go cold, keep walking~")
                    .font(.body)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                Button(action: {
//                    showPopupAlert = false
//                    dismiss()
                    streakManager.shouldShowStreak = false
                }) {
                    Text("OK")
                        .font(.headline)
                        .frame(maxWidth: 250)
                        .padding()
                        .background(Color.brown2)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
            }
        }
    }
}

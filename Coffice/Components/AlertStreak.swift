import SwiftUI

struct StreakPopupView: View {
    @StateObject var streakManager = StreakManager()
    var onDismiss: () -> Void = {}

    var body: some View {
        VStack(spacing: 16) {
            Text("\(streakManager.streak) Day Streak")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.brown3)
                .padding()
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .foregroundColor(.brown2)
                .padding(.bottom)
                
            
            Text("Keep going! You’ve been unstoppable for \(streakManager.streak) days!")
                .font(.body)
                .foregroundColor(.brown3)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            
            Button(action: onDismiss) {
                Text("OK")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.brown2)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
           
        }
        .padding()
        .frame(width: 300)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}

struct StreakPopupView_Previews: PreviewProvider {
    static var previews: some View {
        StreakPopupView()
    }
}

import SwiftUI

struct AlertArrived: View {
    @ObservedObject var liveViewModel: LiveActivityViewModel
    @ObservedObject var streakManager : StreakManager
    @Binding var hasArrived: Bool
    var moveCalories: Int = 258
    var steps: Int = 1072
    var onDismiss: () -> Void = {}
    @Environment(\.dismiss) var dismiss



    let latestSteps = UserDefaults.standard.integer(forKey: "latestStepActivity")
    let latestCalories = UserDefaults.standard.double(forKey: "latestCaloriesActivity")

    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 8) {
                Text("You've Arrived!")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.top)
                
                Text("Hope you enjoy the coffee and the walk!")
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .padding(.bottom)
                
                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: "flame.fill")
                            .resizable()
                            .frame(width: 20, height: 28)
                            .foregroundStyle(Color(uiColor: .brown1))
                        HStack {
                            Text("\(latestCalories, specifier: "%.1f")")
                                .font(.title3)
                                .foregroundColor(.primary)
                            Text("CAL")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    HStack {
                        Image(systemName: "figure.walk")
                            .resizable()
                            .frame(width: 20, height: 28)
                            .foregroundStyle(Color(uiColor: .brown1))
                        HStack {
                            Text("\(latestSteps)")
                                .font(.title3)
                                .foregroundColor(.primary)
                            Text("STEPS")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                        
                    }
                }
                .padding(.bottom)
                
                Button(action: {
                    dismiss()
                    streakManager.completeToday()
                    liveViewModel.stopLiveActivity()
                    hasArrived = false
                }) {
                    Text("Got it")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.brown1)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }

            }
            .padding()
            .frame(width: 330)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 10)
        }
    }
}


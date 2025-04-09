import SwiftUI

struct AlertArrived: View {
    @ObservedObject var liveViewModel: LiveActivityViewModel
    @ObservedObject var streakManager : StreakManager
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
            VStack() {
                Text("You've Arrived!")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.brown3)
                    .padding(.bottom)
                
                Text("Hope you enjoy the coffee and the walk!")
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .foregroundColor(.brown3)
                    .padding(.bottom)
                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: "flame.fill")
                            .resizable()
                            .frame(width: 20, height: 28)
                            .foregroundStyle(Color(uiColor: .brown2))
                        HStack {
                            Text("\(latestCalories, specifier: "%.1f")")
                                .font(.title3)
                                .foregroundColor(.brown3)
                            Text("CAL")
                                .font(.subheadline)
                                .foregroundColor(.brown3)
                        }
                    }
                    
                    HStack {
                        Image(systemName: "figure.walk")
                            .resizable()
                            .frame(width: 20, height: 28)
                            .foregroundStyle(Color(uiColor: .brown2))
                        HStack {
                            Text("\(latestSteps)")
                                .font(.title3)
                                .foregroundColor(.brown3)
                            Text("STEPS")
                                .font(.subheadline)
                                .foregroundColor(.brown3)
                        }
                        
                    }
                }
                .padding(.vertical, 8)
                
                Button(action: {
//                    onDismiss()
                    dismiss()
                    streakManager.completeToday()
                    liveViewModel.stopLiveActivity()
                }) {
                    Text("OK")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                    //                    .frame(width: 80, height: 10)
                        .padding()
                        .background(Color.brown2)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.top, 8)
            }
            .padding()
            .frame(width: 300)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 10)
        }
    }
}

//struct ArrivalArrived_Previews: PreviewProvider {
//    static var previews: some View {
//        AlertArrived(liveViewModel: liveViewModel)
//    }
//}

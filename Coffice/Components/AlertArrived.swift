import SwiftUI

struct ArrivalPopupView: View {
    var moveCalories: Int = 258
    var steps: Int = 1072
    var onDismiss: () -> Void = {}
    
    let latestSteps = UserDefaults.standard.integer(forKey: "latestStepActivity")
    let latestCalories = UserDefaults.standard.double(forKey: "latestCaloriesActivity")
    
    var body: some View {
        VStack() {
            Text("You've Arrived!")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.brown3)
            
            Text("Keep up the great work!")
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

            Button(action: onDismiss) {
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

struct ArrivalPopupView_Previews: PreviewProvider {
    static var previews: some View {
        ArrivalPopupView()
    }
}

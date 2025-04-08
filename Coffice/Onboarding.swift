import SwiftUI

enum AuthAlert: Identifiable {
    case location
    case health
    
    var id: Int {
        switch self {
        case .location: return 0
        case .health: return 1
        }
    }
}

struct OnboardingView: View {
    @AppStorage("userName") var userName: String = ""
    
    @StateObject private var healthViewModel = HealthDashboardViewModel()
    @StateObject var locationManager = LocationManager()
    
    @Environment(\.dismiss) var dismiss
    @State private var tempName: String = ""
    @State private var nameEntered: Bool = false
    
//    @State private var isLocationAuthorized = false
//    @State private var isHealthAuthorized = false
    
    // Flag to trigger the alert if permissions are missing
//    @State private var showAuthAlert: Bool = false
    
    
    var body: some View {
        VStack() {
            Spacer()
            
            Text("Welcome, Cofficer!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("Before we begin, what should we call you?")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.bottom, 20)
            
            TextField("Enter your name", text: $tempName)
                .padding()
                .frame(height: 50)
                .frame(maxWidth: 330)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.bottom, 5)
            
            Button(action: {
                let trimmed = tempName.trimmingCharacters(in: .whitespacesAndNewlines)
                if !trimmed.isEmpty {
                    userName = trimmed
                }
                nameEntered = true
                dismiss()
            }) {
                Text("Continue")
                    .padding()
                    .frame(maxWidth: 330)
                    .background(Color.brown2)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .disabled(tempName.trimmingCharacters(in: .whitespaces).isEmpty)
            .fullScreenCover(isPresented: $nameEntered){
                Homepage()
            }
            
            Spacer()
        }
        .onAppear {
            locationManager.checkAuthorization()
            healthViewModel.requestAuthorization()
        }
//        .onChange(of: locationManager.authorizationStatus) { newStatus in
//            if newStatus == .authorizedWhenInUse || newStatus == .authorizedAlways {
//                isLocationAuthorized = true
//                healthViewModel.requestAuthorization()
//            }
//            else {
//                isLocationAuthorized = false
//                checkPermissions()
//            }
//        }
//        .onChange(of: healthViewModel.isHealthKitAvailable) { newValue in
//            isHealthAuthorized = newValue
//            checkPermissions()
//        }
//        .alert(isPresented: $showAuthAlert) {
//            Alert(
//                title: Text("Permissions Required"),
//                message: Text("Please enable all required permissions (Location and Health) for the app to function properly."),
//                dismissButton: .default(Text("Exit App"), action: {
//                    // Force quit the app. Note that Apple discourages this in production.
//                    exit(0)
//                })
//            )
//        }
    }
    
    // Check if both permissions are authorized; if not, trigger the alert.
//    private func checkPermissions() {
//        if !isLocationAuthorized || !isHealthAuthorized {
//            // Delay showing the alert slightly to allow the system dialogs to finish.
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                showAuthAlert = true
//            }
//        }
//    }
}
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

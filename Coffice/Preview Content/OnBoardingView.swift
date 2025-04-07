//import SwiftUI
//
//struct OnboardingView: View {
//    @AppStorage("userName") var userName: String = ""
//    @State private var tempName: String = ""
//
//    var body: some View {
//        VStack() {
//            Spacer()
//            
//            Text("Welcome, Cofficer!")
//                .font(.title)
//                .fontWeight(.bold)
//                .foregroundColor(.primary)
//    
//            Text("Before we begin, what should we call you?")
//                .font(.body)
//                .multilineTextAlignment(.center)
//                .foregroundColor(.primary)
//                .padding(.bottom, 20)
//
//            TextField("Enter your name", text: $tempName)
//                .padding()
//                .frame(height: 50)
//                .frame(maxWidth: 330)
//                .background(Color(.systemGray6))
//                .cornerRadius(10)
//                .padding(.bottom, 5)
//
//            Button(action: {
//                let trimmed = tempName.trimmingCharacters(in: .whitespacesAndNewlines)
//                if !trimmed.isEmpty {
//                    userName = trimmed
//                }
//            }) {
//                Text("Continue")
//                    .padding()
//                    .frame(maxWidth: 330)
//                    .background(Color.brown2)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding(.horizontal)
//            .disabled(tempName.trimmingCharacters(in: .whitespaces).isEmpty)
//
//            Spacer()
//        }
//    }
//}
////struct OnboardingView_Previews: PreviewProvider {
////    static var previews: some View {
////        OnboardingView()
////    }
////}

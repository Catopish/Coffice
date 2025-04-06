import SwiftUI

struct OnboardingView: View {
    @AppStorage("userName") var userName: String = ""
    @State private var tempName: String = ""

    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Text("Welcome, Cofficer!")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Before we begin, what should we call you?")
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            TextField("Enter your name", text: $tempName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .textInputAutocapitalization(.words)

            Button(action: {
                let trimmed = tempName.trimmingCharacters(in: .whitespacesAndNewlines)
                if !trimmed.isEmpty {
                    userName = trimmed
                }
            }) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .disabled(tempName.trimmingCharacters(in: .whitespaces).isEmpty)

            Spacer()
        }
    }
}
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

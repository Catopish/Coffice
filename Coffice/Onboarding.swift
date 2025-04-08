import SwiftUI

struct OnboardingView: View {
    @AppStorage("userName") var userName: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var tempName: String = ""

    var body: some View {
        ZStack {
            Color.brown4
            .ignoresSafeArea()
            VStack() {
                Spacer()
                
                Image("kopi1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text("Hello, we are Coffice!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("...and you are?")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
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
                
                Spacer()
            }
            .foregroundColor(.brown1)
        }
        }
}
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

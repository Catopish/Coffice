import SwiftUI

struct AlertExitMap: View {
    @State private var showPopup = false
    @State private var showPopupArrived = false
    @State private var isYes = false
    @ObservedObject var liveViewModel: LiveActivityViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            VStack {
//                ActivitySummary()
            }

            VStack {
                            HStack {
                                Button(action: {
                                    showPopup = true
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.white)
                                        .font(.title)
                                }
                                .padding(.leading, 16)

                                Spacer()
                            }
                            .padding(.top, 16)

                            Spacer()
                        }
           
            if showPopup {
                ZStack {
                    Color.black.opacity(0.3)
                        .edgesIgnoringSafeArea(.all)

                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .frame(width: 320, height: 180)
                        .overlay(
                            VStack(spacing: 20) {
                                Text("Exit Journey?")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                
                                Text("If you exit now, you’ll be returned\nto the home page.")
                                    .font(.callout)
                                    .multilineTextAlignment(.center)

                                HStack(spacing: 16) {
                                    Button(action: {
                                        dismiss()
                                    }) {
                                        Text("Yes")
                                            .frame(width: 130, height: 40)
                                            .font(.callout)
                                            .foregroundColor(.brown1)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color.brown, lineWidth: 2)
                                            )
                                    }

                                    Button(action: {
                                        showPopup = false
                                    }) {
                                        Text("No")
                                            .frame(width: 130, height: 40)
                                            .font(.callout)
                                            .background(Color.brown1)
                                            .foregroundColor(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    }
                                }
                            }
                        )
                }
            }
        }
    }
}


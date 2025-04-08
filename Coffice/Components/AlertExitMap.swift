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

            Button(action: {
                showPopup = true
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
                    .font(.title)
            }
            .offset(x: 150, y: -360)

            // Popup
            if showPopup {
                ZStack {
                    Color.black.opacity(0.3)
                        .edgesIgnoringSafeArea(.all)

                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .frame(width: 320, height: 160)
                        .overlay(
                            VStack(spacing: 20) {
                                Text("Are you sure you want to cancel this journey?")
                                    .font(.callout)
                                    .multilineTextAlignment(.center)

                                HStack(spacing: 20) {
                                    Button(action: {
                                        liveViewModel.stopLiveActivity()
                                        dismiss()
//                                        showPopupArrived = true
                                    }) {
                                        Text("Yes")
                                            .frame(width: 125, height: 40)
                                            .font(.callout)
                                            .foregroundColor(.brown2)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color.brown, lineWidth: 2)
                                            )
                                    }

                                    Button(action: {
                                        showPopup = false
                                    }) {
                                        Text("No")
                                            .frame(width: 125, height: 40)
                                            .font(.callout)
                                            .background(Color.brown2)
                                            .foregroundColor(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    }
                                }
                            }
                        )
                }
            }
        }
        //NOTE: testing arrived
//        .fullScreenCover(isPresented: $showPopupArrived){
//            ArrivalPopupView()
//        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlertExitMap()
//    }
//}

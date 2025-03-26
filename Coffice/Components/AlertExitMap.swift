import SwiftUI

struct ContentView: View {
    @State private var showPopup = false
    @State private var isYes = false
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        ZStack {
            // Background (peta atau konten utama)
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            // Tombol untuk menampilkan popup
            Button("End Journey") {
                showPopup = true
            }
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            // Popup
            if showPopup {
                ZStack {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 300, height: 180)
                        .overlay(
                            VStack(spacing: 20) {
                                Text("Are you sure you want to end this journey?")
                                    .font(.body)
                                    .multilineTextAlignment(.center)
                                
                                
                                    HStack(spacing: 20) {
                                        NavigationLink(){
                                            Homepage()
                                        } label : {
                                            Text("Yes")
                                                .frame(width: 100, height: 40)
                                                .background(Color.white)
                                                .foregroundColor(.black)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.black, lineWidth: 2)
                                                )
                                        }
                                        
                                        Button(action: {
                                            showPopup = false
                                        }) {
                                            Text("No")
                                                .frame(width: 100, height: 40)
                                                .background(Color.black)
                                                .foregroundColor(.white)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                        }
                                    }
                                
                                
                            }
                            .padding()
                        )
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


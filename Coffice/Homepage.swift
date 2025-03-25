//
//  ContentView.swift
//  Coffice
//
//  Created by Hafi on 20/03/25.
//

import SwiftUI
import SwiftData

struct Homepage: View {
    @State private var streak: Int = 0
    var body: some View {
        VStack {
            HStack {
                Image("avatar")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding()
               
                VStack (alignment: .leading) {
                    Text("User's Name")
                    Text("User's Location")
                        .foregroundColor(.secondary)
                
                }
                Spacer()
                
                HStack {
                    Text ("\(streak) Streak")
                    Image(systemName: "flame.fill")
                }
                .padding(13)
                .background(Color.orange)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                }
                Spacer()
                      }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                  }
              }
            


#Preview {
    Homepage()
}

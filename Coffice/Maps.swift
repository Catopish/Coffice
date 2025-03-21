//
//  ContentView.swift
//  Coffice
//
//  Created by Hafi on 20/03/25.
//

import SwiftUI
import SwiftData

struct Maps: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink{
                    Homepage()
                } label: {
                    Text("Homepage")
                }
            }
        }
    }
}

#Preview {
    Maps()
}

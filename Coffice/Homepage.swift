//
//  ContentView.swift
//  Coffice
//
//  Created by Hafi on 20/03/25.
//

import SwiftUI
import SwiftData
import HealthKit

struct Homepage: View {
    
    @State private var searchContent: String = ""
    var coffeeshopNames : [String] = ["Startbucks","Fore","Tamper"]
    
    var body: some View {
        VStack(alignment: .leading){
            VStack{
                
                NavigationView{
                    List{
                        ForEach(coffeeshopNames, id: \.description){
                            name in Text(name)
                        }
                        .navigationTitle("Coffeeshops")
                    }
                    .searchable(text: $searchContent,placement: .navigationBarDrawer(displayMode: .always))
                    
                    
                    
                }
            }
            
        }
    }
}


#Preview {
    Homepage()
}

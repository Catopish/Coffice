//
//  MapView.swift
//  Landmarks
//
//  Created by Angel on 23/03/25.
//

import SwiftUI
import MapKit
import HealthKit

struct MapView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var showDetail: Bool
    
    var coordinate: CLLocationCoordinate2D
    
    
    var body: some View {
        ZStack {
            Map(position: .constant(.region(region)))
            
            Spacer()
            ActivitySummary()
            Button("Dismiss") {
                showDetail = false
                dismiss()
            }
        }
    }
    
    
    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
        )
        
                
            }
}




   



#Preview {
//    MapView(showDetail: $showDetail, coordinate: CLLocationCoordinate2D(latitude: -6.3019094, longitude: 106.6517333))
    ActivitySummary()
}

import SwiftUI

struct ActivitySummary: View {
    var body: some View {
        Spacer()
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image (systemName: "figure.walk")
                    .padding(.bottom)
                Text("Your Activity")
                    .foregroundColor(Color("brown3"))
                    .padding(.bottom)
                    .fontWeight(.bold)
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Move")
                        .font(.headline)
                        .foregroundColor(Color("brown2"))
                    
                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text("258")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                            .foregroundColor(Color("brown3"))

                        Text("kcal")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                    }
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Steps")
                        .font(.headline)
                        .foregroundColor(Color("brown2"))
                    
                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text("3672")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                            .foregroundColor(Color("brown3"))
                        Text("steps")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .frame(width: 350, height: 150)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

struct ActivitySummary_Previews: PreviewProvider {
    static var previews: some View {
        ActivitySummary()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray.opacity(0.2))
    }
}




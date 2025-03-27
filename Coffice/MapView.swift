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
    
    var coordinate: CLLocationCoordinate2D
    
    
    var body: some View {
        ZStack {
            
            Map(position: .constant(.region(region)))
            AlertExitMap()

            Spacer()
            VStack{

                    
                    ActivitySummary()

            }
//            Button("Dismiss") {
//                dismiss()
//            }

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
    MapView(coordinate: CLLocationCoordinate2D(latitude: -6.3019094, longitude: 106.6517333))
}

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
                            .font(.title)
                            .foregroundStyle(.primary)
                            .foregroundColor(Color("brown3"))

                        Text("CAL")
                            .font(.headline)
                            .foregroundStyle(.secondary)

                    }
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Steps")
                        .font(.headline)
                        .foregroundColor(Color("brown2"))
                    
                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text("1072")
                            .font(.title)
                            .foregroundStyle(.primary)
                            .foregroundColor(Color("brown3"))
                        Text("STEPS")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .frame(width: 320, height: 130)
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




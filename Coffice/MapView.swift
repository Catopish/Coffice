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




   



//#Preview {
//    MapView(showDetail: $showDetail, coordinate: CLLocationCoordinate2D(latitude: -6.3019094, longitude: 106.6517333))
//}

struct ActivitySummary: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ZStack{
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 350, height: 150)
                        .cornerRadius(10)
                    HStack {
                        Text ("Your Activity")
                        
                    }
                    VStack {
                        Text ("Move")
                        Text ("258 kcal")
                    }
                }
            }
            Spacer()
                .frame(height: 10)
        }
    }
}

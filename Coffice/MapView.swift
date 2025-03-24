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
    var coordinate: CLLocationCoordinate2D
    
    
    var body: some View {
        ZStack {
            Map(position: .constant(.region(region)))
            
            Spacer()
            VStack {
                Spacer()
                HStack {
                    ZStack{
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 350, height: 150)
                            .cornerRadius(10)
                        VStack (alignment: .leading) {
                            Text ("Your Activity")
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

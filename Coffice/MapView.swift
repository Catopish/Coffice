//
//  MapView.swift
//  Landmarks
//
//  Created by Angel on 23/03/25.
//

import SwiftUI
import MapKit


struct MapView: View {
    var coordinate: CLLocationCoordinate2D


    var body: some View {
        Map(position: .constant(.region(region)))
    }


    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    }
}



#Preview {
    MapView(coordinate: CLLocationCoordinate2D(latitude: -6.3015152, longitude: 106.6551521))
}

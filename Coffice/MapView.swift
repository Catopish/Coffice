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
    @StateObject private var locationManager = LocationManager()
    @Binding var coffeShops: CoffeeShopStruct?
    @ObservedObject var liveViewModel: LiveActivityViewModel
    
    var body: some View {
        ZStack {
            if let status = locationManager.authorizationStatus {
                switch status {
                case .authorizedAlways, .authorizedWhenInUse:
                    MapViewWalking(locationManager: locationManager, selectedShop: $coffeShops)
                    
                case .notDetermined:
                    Text("Requesting GPS permission...")
                        .font(.title2)
                        .foregroundColor(.orange)
                    
                case .denied, .restricted:
                    Text("GPS is required to use this app.")
                        .font(.title2)
                        .foregroundColor(.red)
                    
                @unknown default:
                    Text("Unknown status")
                }
            } else {
                Text("Checking GPS permission...")
                    .font(.title2)
            }
//            AlertExitMap(liveViewModel: liveViewModel)
            VStack{
                ActivitySummary(liveViewModel: liveViewModel)
            }
            AlertExitMap(liveViewModel: liveViewModel)
//            AlertExitMap()

        }
    }
}


//
//struct ActivitySummary_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivitySummary()
//            .previewLayout(.sizeThatFits)
//            .padding()
//            .background(Color.gray.opacity(0.2))
//    }
//}




//import SwiftUI
//import CoreLocation
//
//struct MapView: View {
//    @StateObject private var locationManager = LocationManager()
//    @Binding var coffeShops: CoffeeShopStruct?
//
//
//    var body: some View {
//        VStack {
//            if let status = locationManager.authorizationStatus {
//                switch status {
//                case .authorizedAlways, .authorizedWhenInUse:
//                    MapViewWalking(locationManager: locationManager, selectedShop: $coffeShops)
//                    Text("Entering walking mode...")
//
//                case .notDetermined:
//                    Text("Requesting GPS permission...")
//                        .font(.title2)
//                        .foregroundColor(.orange)
//
//                case .denied, .restricted:
//                    Text("GPS is required to use this app.")
//                        .font(.title2)
//                        .foregroundColor(.red)
//
//                @unknown default:
//                    Text("Unknown status")
//                }
//            } else {
//                Text("Checking GPS permission...")
//                    .font(.title2)
//            }
//        }
//
//    }
//}

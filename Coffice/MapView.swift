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
            AlertExitMap(liveViewModel: liveViewModel)
            VStack{
                ActivitySummary(liveViewModel: liveViewModel)
            }

        }
    }
    
}

struct ActivitySummary: View {
//    @StateObject var healthManager = HealthManager()
    @ObservedObject var liveViewModel: LiveActivityViewModel
    
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
                        Text("\(liveViewModel.liveCalories, specifier: "%.1f")")
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
                        Text("\(liveViewModel.liveSteps)")
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

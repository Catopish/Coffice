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
    @ObservedObject var streakManager: StreakManager
    @Binding var coffeShops: CoffeeShopStruct?
    @ObservedObject var liveViewModel: LiveActivityViewModel
    @Binding var hasArrivedAtDestination : Bool
    
    var body: some View {
        ZStack {
            if let status = locationManager.authorizationStatus {
                switch status {
                case .authorizedAlways, .authorizedWhenInUse:
                    MapViewWalking(locationManager: locationManager, liveViewModel: liveViewModel, selectedShop: $coffeShops,hasArrivedAtDestination: $hasArrivedAtDestination)
                    
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
        .overlay{
            if hasArrivedAtDestination {
                AlertArrived(liveViewModel: liveViewModel, streakManager: streakManager, hasArrived: $hasArrivedAtDestination)
                    
            }
        }
        .onAppear() {
            liveViewModel.startLiveActivity()
        }
    }
}


import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var showSettingsAlert = false
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        checkAuthorization()
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func checkAuthorization() {
        let status = locationManager.authorizationStatus
        print("Authorization status: \(status.rawValue)")
        DispatchQueue.main.async {
            self.authorizationStatus = status
            switch status {
            case .notDetermined:
                self.requestLocationPermission()
            case .denied, .restricted:
                self.showSettingsAlert = true
            case .authorizedAlways, .authorizedWhenInUse:
                self.locationManager.startUpdatingLocation()
            @unknown default:
                break
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
    
   
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("Received new location: \(location.coordinate)")
            DispatchQueue.main.async {
                self.userLocation = location
            }
        }
    }
}

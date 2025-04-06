import Foundation
import MapKit

class MapWalkingManager: ObservableObject {
    @Published var routePolyline: MKPolyline?
    @Published var travelTime: TimeInterval?
    @Published var distance: CLLocationDistance?
    
    func calculateRoute(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D, completion: ((Bool) -> Void)? = nil) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        request.transportType = .walking
        
        MKDirections(request: request).calculate { response, error in
            if let route = response?.routes.first {
                DispatchQueue.main.async {
                    self.routePolyline = route.polyline
                    self.travelTime = route.expectedTravelTime
                    self.distance = route.distance
                    completion?(true)
                }
            } else {
                DispatchQueue.main.async {
                    completion?(false)
                }
            }
        }
    }
}

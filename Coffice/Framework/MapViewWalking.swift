import SwiftUI
import MapKit

struct MapViewWalking: View {
    @ObservedObject var locationManager: LocationManager
    @State private var mapPosition: MapCameraPosition = .automatic
    @State private var routePolyline: MKPolyline?
    @State private var routeCalculated = false
//    @Binding var latCoffeShops: Double
//    @Binding var longCoffeShops: Double
    @Binding var selectedShop: CoffeeShopStruct?
    
//    private let destinationCoordinate = CLLocationCoordinate2D(latitude: -7.777848720301518, longitude: 110.33756018305395)
    // Computed destination coordinate:
        private var destinationCoordinate: CLLocationCoordinate2D {
            if let shop = selectedShop {
                return CLLocationCoordinate2D(latitude: shop.latitude, longitude: shop.longitude)
            } else {
                // Default coordinate if no shop is selected
                return CLLocationCoordinate2D(latitude: -7.777848720301518, longitude: 110.33756018305395)
            }
        }
    
    var body: some View {
        VStack {
            if let userLocation = locationManager.userLocation {
                Map(position: $mapPosition) {
                    if let polyline = routePolyline {
                        MapPolyline(polyline)
                            .stroke(.blue, lineWidth: 4)
                    }
                    
                    // Optionally show annotations
                    Annotation("You", coordinate: userLocation.coordinate) {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(.blue)
                    }
                    
                    Annotation("Destination", coordinate: destinationCoordinate) {
                        Image(systemName: "mappin")
                            .foregroundColor(.red)
                    }
                }
                .onAppear {
                    calculateRouteIfNeeded()
                }
            } else {
                ProgressView("Getting your location...")
            }
        }
    }
    
    private func calculateRouteIfNeeded() {
        guard !routeCalculated, let userLocation = locationManager.userLocation else { return }
        fetchRoute(from: userLocation.coordinate, to: destinationCoordinate)
    }

    private func fetchRoute(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        request.transportType = .walking
        
        MKDirections(request: request).calculate { response, error in
            if let route = response?.routes.first {
                DispatchQueue.main.async {
                    self.routePolyline = route.polyline
                    self.routeCalculated = true
                    self.mapPosition = .rect(route.polyline.boundingMapRect.insetBy(dx: -50, dy: -50))
                }
            }
        }
    }
}

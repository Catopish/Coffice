import SwiftUI
import MapKit

struct MapViewWalking: View {
    @StateObject var locationManager: LocationManager
    @ObservedObject var liveViewModel: LiveActivityViewModel
    @State private var mapPosition: MapCameraPosition = .automatic
    @StateObject var mapWalkingManager = MapWalkingManager()
    @Binding var selectedShop: CoffeeShopStruct?
    @Environment(\.dismiss) var dismiss
    
    @Binding var hasArrivedAtDestination : Bool
    @State private var showArrivalAlert = false
    
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
                    if let polyline = mapWalkingManager.routePolyline {
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
                    mapWalkingManager.calculateRoute(from: userLocation.coordinate, to: destinationCoordinate) { success in
                        if success, let routePolyline = mapWalkingManager.routePolyline {
                            self.mapPosition = .rect(routePolyline.boundingMapRect.insetBy(dx: -50, dy: -50))
                        }
                        
                    }
                }
                .onChange(of: locationManager.userLocation) { _, newLocation in
                    guard let newLocation = newLocation else { return }
                    
                    // Calculate route and update map position
                    mapWalkingManager.calculateRoute(from: newLocation.coordinate, to: destinationCoordinate) { success in
                        if success, let routePolyline = mapWalkingManager.routePolyline {
                            self.mapPosition = .rect(routePolyline.boundingMapRect.insetBy(dx: -50, dy: -50))
                        }
                    }
                    
                    // Check if user is close enough to the destination
                    let destinationLocation = CLLocation(latitude: destinationCoordinate.latitude, longitude: destinationCoordinate.longitude)
                    let distance = newLocation.distance(from: destinationLocation) // distance in meters
                    
                    if distance < 100 && !hasArrivedAtDestination {
                        hasArrivedAtDestination = true
                        showArrivalAlert = true
                    }
                }

            } else {
                ProgressView("Getting your location...")
            }
        }
    }
}

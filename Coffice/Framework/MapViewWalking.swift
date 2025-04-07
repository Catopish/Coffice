import SwiftUI
import MapKit

struct MapViewWalking: View {
    @ObservedObject var locationManager: LocationManager
    @State private var mapPosition: MapCameraPosition = .automatic
    @ObservedObject var mapWalkingManager = MapWalkingManager()
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
                .onChange(of: locationManager.userLocation ) {
                    mapWalkingManager.calculateRoute(from: userLocation.coordinate, to: destinationCoordinate) { success in
                        if success, let routePolyline = mapWalkingManager.routePolyline {
                            self.mapPosition = .rect(routePolyline.boundingMapRect.insetBy(dx: -50, dy: -50))
                        }
                        
                    }
                }
            } else {
                ProgressView("Getting your location...")
            }
        }
    }
}

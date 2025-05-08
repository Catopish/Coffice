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
    
//    func calculateCalories(for distance: CLLocationDistance, at walkingSpeed: Double, in time: TimeInterval) -> Int {
//        let caloriesBurned = Int(3 * walkingSpeed * 60 * time / 200)
//        return caloriesBurned
//    }
    func calculateCaloriesBurned(for distance: CLLocationDistance, at walkingSpeed: Double, in time: TimeInterval) -> Int {
        // Asumsi berat rata-rata orang Indonesia (kg)
        let weight: Double = 60.0
        
        // Konversi kecepatan dari m/s ke km/jam
        let speedKMH = walkingSpeed * 3.6
        
        // Tentukan nilai MET berdasarkan kecepatan berjalan (nilai perkiraan)
        let met: Double
        if speedKMH < 3 {
            met = 2.0    // Kecepatan sangat lambat
        } else if speedKMH < 4 {
            met = 2.9    // Kecepatan berjalan santai
        } else if speedKMH < 5 {
            met = 3.5    // Kecepatan normal
        } else if speedKMH < 6 {
            met = 4.3    // Kecepatan agak cepat
        } else if speedKMH < 7 {
            met = 5.0    // Kecepatan cepat
        } else {
            met = 6.0    // Kecepatan sangat cepat (hampir mendekati jogging)
        }
        
        // Konversi durasi dari detik ke jam
        let hours = time / 3600.0
        
        // Perhitungan kalori terbakar
        let caloriesBurned = met * weight * hours
        
        return Int(caloriesBurned)
    }
    
    func calculateSteps(for distance: CLLocationDistance, averageStepLength: Double = 0.75) -> Int {
        let steps = distance / averageStepLength
        return Int(steps)
    }
}

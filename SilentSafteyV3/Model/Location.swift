//
//  Location.swift
//  SilentSafteyV3
//
//  Created by Mihir Thakur on 8/6/23.
//
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var locationCompletion: ((String?, CLLocation?) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func fetchUserLocation(completion: @escaping (String?, CLLocation?) -> Void) {
        self.locationCompletion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                if let error = error {
                    print("Reverse geocoding error: \(error.localizedDescription)")
                    self.locationCompletion?(nil, nil)
                    return
                }

                guard let placemark = placemarks?.first,
                      let streetAddress = placemark.thoroughfare,
                      let latitude = placemark.location?.coordinate.latitude,
                      let longitude = placemark.location?.coordinate.longitude else {
                    self.locationCompletion?(nil, nil)
                    return
                }

                let location = CLLocation(latitude: latitude, longitude: longitude)
                self.locationCompletion?(streetAddress, location)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
        self.locationCompletion?(nil, nil)
    }
}

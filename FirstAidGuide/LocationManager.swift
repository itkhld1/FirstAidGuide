//
//  LocationManager.swift
//  FirstAidGuide
//
//  Created by itkhld on 24.12.2024.
//

import CoreLocation
import SwiftUI
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    @Published var locationError: String?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationError = error.localizedDescription
    }
}

func fetchNearbyHospitals(location: CLLocation, completion: @escaping ([MKMapItem]) -> Void) {
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = "hospital"
    request.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)

    let search = MKLocalSearch(request: request)
    search.start { response, error in
        if let error = error {
            print("Error searching for hospitals: \(error.localizedDescription)")
            completion([])
        } else {
            completion(response?.mapItems ?? [])
        }
    }
}



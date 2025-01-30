//
//  UserLocationServiceProtocol.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation
import CoreLocation

protocol UserLocationService {
    func getCountryCode() async -> String?
}

class UserLocationServiceImpl: NSObject, ObservableObject, CLLocationManagerDelegate, UserLocationService {
    
    private var locationManager: CLLocationManager?
    private var continuation: CheckedContinuation<String?, Never>?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
    
    func getCountryCode() async -> String? {
        return await withCheckedContinuation { [weak self] continuation in
            self?.continuation = continuation
            self?.locationManager?.requestWhenInUseAuthorization()
            self?.locationManager?.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            continuation?.resume(returning: nil)
            return
        }
        fetchCountryFromLocation(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(returning: nil)
    }
    
    private func fetchCountryFromLocation(_ location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let country = placemarks?.first?.isoCountryCode, error == nil {
                self?.continuation?.resume(returning: country)
            } else {
                self?.continuation?.resume(returning: nil)
            }
        }
    }
}

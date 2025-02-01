//
//  LocalCountryCodeServiceImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
import CoreLocation

class LocalCountryCodeServiceImpl: NSObject, ObservableObject, CLLocationManagerDelegate, LocalCountryCodeService {
    
    private var locationManager: CLLocationManager?
    private var continuation: CheckedContinuation<String, Error>?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
    
    func getCountryCode() async throws -> String {
        try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self else {
                continuation.resume(throwing: CountryCodeError.custom("Service deallocated"))
                return
            }
            
            guard self.continuation == nil else {
                continuation.resume(throwing: CountryCodeError.custom("A location request is already in progress"))
                return
            }
            
            self.continuation = continuation
            self.locationManager?.requestWhenInUseAuthorization()
            self.locationManager?.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            safelyResumeContinuation(throwing: CountryCodeError.custom("Couldn't get user location"))
            return
        }
        fetchCountryFromLocation(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        safelyResumeContinuation(throwing: error)
    }
    
    private func fetchCountryFromLocation(_ location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let country = placemarks?.first?.isoCountryCode, error == nil {
                self?.safelyResumeContinuation(returning: country)
            } else {
                self?.safelyResumeContinuation(throwing: CountryCodeError.custom("Reverse geocoding failed"))
            }
        }
    }
    
    private func safelyResumeContinuation(returning value: String? = nil, throwing error: Error? = nil) {
        guard let continuation = continuation else { return }
        self.continuation = nil

        if let error = error {
            continuation.resume(throwing: error)
        } else if let value = value {
            continuation.resume(returning: value)
        }
    }
}

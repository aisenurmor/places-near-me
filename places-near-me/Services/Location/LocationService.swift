//
//  LocationService.swift
//  places-near-me
//
//  Created by aisenur on 21.05.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import UIKit
import CoreLocation

enum Result<K> {
    case success(K)
    case failure(Error)
}

final class LocationService: NSObject {
    
    var userLocation: CLLocationCoordinate2D?
    private var manager: CLLocationManager
    
    var status: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    var currentLocation: ((Result<CLLocation>) -> Void)?
    var changeOfLocation: ((Bool) -> Void)?
    
    init(manager: CLLocationManager = .init()) {
        self.manager = manager
        self.manager.startUpdatingLocation()
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        super.init()
        self.manager.delegate = self
        self.manager.distanceFilter = CLLocationDistance(exactly: 250)! //get new locations after 250 meters
    }
    
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func getLocation() {
        manager.requestLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        currentLocation?(.failure(error))
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.sorted(by: { $0.timestamp > $1.timestamp }).first {
            currentLocation?(.success(location))
            userLocation = location.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .notDetermined, .restricted:
            changeOfLocation?(false)
        default:
            changeOfLocation?(true)
        }
    }
}

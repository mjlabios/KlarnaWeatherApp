//
//  UserLocation.swift
//  KlarnaWeatherApp
//
//  Created by Mark Labios on 11/11/19.
//  Copyright © 2019 Mark Labios. All rights reserved.
//

import CoreLocation

protocol UserLocationDelegate {
    func onUserLocationUpdate(latitude: Double, longitude: Double)
}

class UserLocation: NSObject, CLLocationManagerDelegate {
    private let manager: CLLocationManager
    var delegate: UserLocationDelegate?
    
    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
        super.init()
    }

    func startUpdating() {
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latitude = locations.last?.coordinate.latitude ?? 0
        let longitude = locations.last?.coordinate.longitude ?? 0
        delegate?.onUserLocationUpdate(latitude: latitude, longitude: longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

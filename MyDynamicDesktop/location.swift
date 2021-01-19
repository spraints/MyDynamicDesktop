//
//  location.swift
//  MyDynamicDesktop
//
//  Created by Matt Burke on 1/18/21.
//

import Foundation
import CoreLocation

func getLocation(latitude: Double?, longitude: Double?) -> CLLocationCoordinate2D {
    if latitude == nil || longitude == nil {
        let locationManager = CLLocationManager()
        let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
        return locValue
    }
    var ret = CLLocationCoordinate2D()
    ret.latitude = latitude!
    ret.longitude = longitude!
    return ret
}

//
//  City.swift
//  Week2WeatherBoy
//
//  Created by Consultant on 12/9/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Foundation
import CoreLocation

struct City {
    let name: String
    let state: String
    let population: String
    let coordinates: CLLocationCoordinate2D

}

extension City {
    // for persistent data loading
    init(_ core: CoreCity) {
        self.name = core.name!  // need to unwrap because Objective C doesn't have optionals, which data models are in
        self.state = core.state!
        self.population = core.population!
        let coord = CLLocationCoordinate2D(latitude: core.latitude, longitude: core.longitude)
        self.coordinates = coord
    }
}

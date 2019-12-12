//
//  WeatherAPI.swift
//  Week2WeatherBoy
//
//  Created by Consultant on 12/11/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Foundation

struct WeatherAPI {
    
    // dependency injection - passing an objects' dependency from the outside
    var city: City!
    
    // separate api call
    let base = "http://api.openweathermap.org/data/2.5/weather?"    // apples regulations don't allow unsecure networks in the app unless specified in info.plist
    // coordinates = lat=33.7490&lon=84.3880
    let key = "&units=imperial&APPID=7cdcd7f9a8620c069b7159b27a5f7a34"


    
    // needs parameter: City in order to initialize
    init(_ cty: City) {
        self.city = cty
    }
    
    // optional becuase to contruct a URL from a string gives back an optional
    var cityURL: URL? {
        let lat = city.coordinates.latitude
        let lon = city.coordinates.longitude
        return URL(string: base + "lat=\(lat)&lon=\(lon)" + key)
    }
    
}

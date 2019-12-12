//
//  Weather.swift
//  Week2WeatherBoy
//
//  Created by Consultant on 12/11/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Foundation

class Weather {
    
    let temperature: Double
    let description: String
    let humidity: Int
    let windSpeed: Double
    
    // init? means failable initializer - has the ability to be nil
    init?(_ dict: [String:Any]) {
        guard let mainDict = dict["main"] as? [String?:Any],
            let temp = mainDict["temp"] as? Double,
            let weatherArr = dict["weather"] as? [[String:Any]],
            let descrip = weatherArr[0]["description"] as? String,
            let humid = mainDict["humidity"] as? Int,
            let windDict = dict["wind"] as? [String:Any],
            let wind = windDict["speed"] as? Double else { return nil }   // optional, so needs to be unwrapped
        
        self.temperature = temp
        self.description = descrip
        self.humidity = humid
        self.windSpeed = wind
    }
}

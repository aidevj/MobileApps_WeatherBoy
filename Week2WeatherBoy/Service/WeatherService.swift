//
//  WeatherService.swift
//  Week2WeatherBoy
//
//  Created by Consultant on 12/11/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Foundation

typealias WeatherHandler = (Weather?) -> Void   // needs to be optional so we can use nil in completion
// Singleton
final class WeatherService {
    
    static let shared = WeatherService()
    private init() {}
    
    // escaping gives it its own lifespan
    func getWeather(from city: City, completion: @escaping WeatherHandler) {
        
        guard let url = WeatherAPI(city).cityURL else {
            completion(nil)
            return
        }
        // 1. API request - data task
        // data task start in a suspended state
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            // 2. check for errors
            if let _ = err {    // exit func if we get err
                completion(nil)
                return
            }
            
            // 3. unwrap data
            // check if there's data, using optional binding
            if let data = dat {
                // in this scope we can use the data we unwrap
                
                do{
                    // 4. serialize response
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
                        // 5. Create object - init weather
                        let weather = Weather(jsonResponse) {
                        // 6. Pass object to completion
                        completion(weather)
                    } else {
                        completion(nil)
                        return
                    }
                } catch {
                    print("Couldn't Serialize: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
            }
                
            
        }.resume() // fire data task
    } // end func
}

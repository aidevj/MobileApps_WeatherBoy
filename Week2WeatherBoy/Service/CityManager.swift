//
//  CityManager.swift
//  Week2WeatherBoy
//
//  Created by Consultant on 12/9/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Foundation
import CoreLocation

// nickname for data structure, funcitonality, etc.
typealias CityHandler = ([City]) -> Void

// Singleton (mostly found on network layers)
// 1. final - stops inheritance form the class
final class CityManager {
    
    // 2. static - shared property so everything has to use the same instance
    static let shared = CityManager()
    
    // 3. private init - no one else can create an instance
    private init() {}
    
    // closures - isolated block of functionality that cna take parameteres nad have return types
    // escaping - the closure now has a separate life span than the function it resides in (it's its own entity now that outlasts the function)
    func getCities(completion: @escaping CityHandler) {
        // get async values by using closures. setting up call backs to get a result to use later
        // need escaping closure to wait aorund to capture the values whenver it's done
        // escaping means has a seperate lifespan than the function it's in, the closure will continue after the function is done
        // this is how to create call backs in iOS
        guard let path = Bundle.main.path(forResource: "cities", ofType: "json") else {
            // need to use guard let to safetly unwrap since it lets us leave the scope early
            completion([])
            return
        }
        
        
        // container to hold cities
        var cities = [City]()
        // GCD - Grand Central Dispatch - low level API to perform multi-threading (change threads)
        // background thread asynchronously
        DispatchQueue.global().async {
            // create url from path
            let url = URL(fileURLWithPath: path)
            do {
                // tru to get data from url
                let data = try Data(contentsOf: url)
                // json derulo serialization - convert data to custom object
                let citiesDict = try JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
                // loop through dictionaries and init city
                for dict in citiesDict {
                    guard let name = dict["city"] as? String,
                        let state = dict["state"] as? String,
                        let long = dict["longitude"] as? Double,
                        let lat = dict["latitude"] as? Double,
                        let pop = dict["population"] as? String else { continue }
                    
                    let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    let city = City(name: name, state: state, population: pop, coordinates: coordinates)
                    
                    // add new city to array of cities
                    cities.append(city)
                }
                
                // call completion to add cities array
                completion(cities)
                
            } catch {
                // if not, pass empty array to completion and exit
                completion([])
                print("Couldn't serialize JSON: \(error.localizedDescription)")
                return
            }
            
            
            
        }
        
    } // end func
    

}

//
//  MapViewController.swift
//  Week2WeatherBoy
//
//  Created by Consultant on 12/11/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    // dependency injection (passing dependency from outside so it doesn't have to worry about creating it)
    var city: City! // implicit unwrap - this value WILL be there when called
    var weather: Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        setupButton()
    }
    
    private func setupMap() {
        guard let myCity = city else { return } // safetly unwrap optional using optional binding
        getWeather()    // get weather for map
        
        // set map region to show
        let region = MKCoordinateRegion(center: myCity.coordinates, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        // create annotation for map
        let annotation = MKPointAnnotation()
        annotation.coordinate = myCity.coordinates
        annotation.title = "\(myCity.name)"
        annotation.subtitle = "\(myCity.state)"
        
        // est map prpoerties
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
    }
    
    private func setupButton() {
        let weatherButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(showWeatherAlert)) // button is now connected to show weather fucntion
        navigationItem.rightBarButtonItem = weatherButton
    }
    
    @objc private func showWeatherAlert() {
        guard let wthr = weather, let cty = city else { return } // safetly unwrap properties
        let alertVC = AlertViewController.instance((cty, wthr))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func getWeather() {
        WeatherService.shared.getWeather(from: city) { [weak self] wthr in // note: escaping closure - risk of retain cycles
            guard let weather = wthr else { return }
            self?.weather = weather
            print("Current weather: \(weather.description)")
        }
    }
    
    
}

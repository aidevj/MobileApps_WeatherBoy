//
//  AlertViewController.swift
//  Week2WeatherBoy
//
//  Created by Consultant on 12/13/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    var informationTuple: (city: City, wthr: Weather)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupAlert() {
        let city = informationTuple.city
        let wthr = informationTuple.wthr
        cityNameLabel.text = "\(city.name), \(city.state)"
        weatherDescriptionLabel.text = wthr.description
        weatherImage.image = #imageLiteral(resourceName: "cloudy")
        tempLabel.text = "Temperature: \(wthr.temperature)"
        humidityLabel.text = "Humidity: \(wthr.humidity)"
        windSpeedLabel.text = "Wind Speed: \(wthr.windSpeed)"
    }

}

extension AlertViewController {
    // class func works like static, globally accessible w/o and instance but they CAN be modified
    //Helper - return weather alert instance
    class func instance(_ info: (city: City, wthr: Weather)) -> AlertViewController {
        let alertVC = AlertViewController()
        alertVC.informationTuple = info
        return alertVC
    }
}

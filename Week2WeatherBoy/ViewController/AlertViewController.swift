//
//  AlertViewController.swift
//  Week2WeatherBoy
//
//  Created by Consultant on 12/13/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    var informationTuple: (city: City, wthr: Weather)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAlert()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        if touch.view == view {
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func setupAlert() {
        mainView.layer.cornerRadius = 15
        let city = informationTuple.city
        let weather = informationTuple.wthr
        cityNameLabel.text = "\(city.name), \(city.state)"
        weatherDescriptionLabel.text = weather.description
        weatherImage.image = #imageLiteral(resourceName: "cloudy")
        tempLabel.text = "Temperature: \(Int(weather.temperature)) degrees"
        humidityLabel.text = "Humidity: \(weather.humidity)"
        windSpeedLabel.text = "Wind Speed: \(weather.windSpeed)"
    }
    
    @IBAction func closeAlert(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension AlertViewController {
    // class func works like static, globally accessible w/o and instance but they CAN be modified
    //Helper - return weather alert instance
    static func instance(_ info: (city: City, wthr: Weather)) -> AlertViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let alertVC = storyboard.instantiateViewController(identifier: "AlertViewController") as! AlertViewController
        alertVC.informationTuple = info
        return alertVC
    }
}

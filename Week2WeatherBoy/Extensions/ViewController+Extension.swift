//
//  ViewController+Extension.swift
//  Week2WeatherBoy
//
//  Created by Consultant on 12/13/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

extension UIViewController {
    func showMap(of city: City) {
        CityManager.shared.save(city)
        
        // new instance of view controller and present it
        let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        mapVC.hidesBottomBarWhenPushed = true
        mapVC.city = city   // send the information foward
        navigationController?.view.backgroundColor = .white
        navigationController?.pushViewController(mapVC, animated: true) // push VC onto stack (back button)
    }
}

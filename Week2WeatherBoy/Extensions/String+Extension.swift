//
//  String+Extension.swift
//  Week2WeatherBoy
//
//  Created by Consultant on 12/10/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Foundation

extension String {
    var addCommas: String? { // optional because this needs to fail on an int
        guard let num = Int(self) else { return nil }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal  // same as NumberFormatter.numberStyle.decimal
        return numberFormatter.string(from: num as NSNumber)
    }
}

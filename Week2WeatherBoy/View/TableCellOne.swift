//
//  TableCellOne.swift
//  Week2WeatherBoy
//
//  Created by Consultant on 12/9/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

class TableCellOne: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    // Globally accessible property that belongs to the class instead of an instance (same as C)
    static let identifier = "TableCellOne"
    
    
}

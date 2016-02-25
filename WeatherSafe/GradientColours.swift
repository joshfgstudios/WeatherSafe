//
//  GradientColours.swift
//  WeatherSafe
//
//  Created by Joshua Ide on 25/02/2016.
//  Copyright © 2016 Fox Gallery Studios. All rights reserved.
//

import Foundation
import UIKit

class Colours {
    
    let hotTop = UIColor(red: 250.0/255, green: 134.0/255, blue: 31.0/255, alpha: 1.0).CGColor
    let hotBottom = UIColor(red: 252.0/255, green: 193.0/255, blue: 37.0/255, alpha: 1.0).CGColor
    
    let gradientLayer: CAGradientLayer!
    
    init() {
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [hotTop, hotBottom]
        gradientLayer.locations = [0.0, 1.0]
    }
}
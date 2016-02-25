//
//  Constants.swift
//  WeatherSafe
//
//  Created by Joshua Ide on 25/02/2016.
//  Copyright © 2016 Fox Gallery Studios. All rights reserved.
//

import Foundation
import UIKit

let URL_BASE = "http://api.openweathermap.org/data/2.5/weather?"
let URL_CITY_ID = "id=7839805"
let URL_PARAMETERS = "&units=metric&appid="
let API_KEY = "8e1e3e946ef53c541637cf0ee2e12dd9"

//Colours
let hotTop = UIColor(red: 250.0/255, green: 134.0/255, blue: 31.0/255, alpha: 1.0).CGColor
let hotBottom = UIColor(red: 252.0/255, green: 193.0/255, blue: 37.0/255, alpha: 1.0).CGColor

let warmTop = UIColor(red: 252.0/255, green: 193.0/255, blue: 37.0/255, alpha: 1.0).CGColor
let warmBottom = UIColor(red: 167.0/255, green: 222.0/255, blue: 48.0/255, alpha: 1.0).CGColor

let coolTop = UIColor(red: 91.0/255, green: 194.0/255, blue: 252.0/255, alpha: 1.0).CGColor
let coolBottom = UIColor(red: 74.0/255, green: 218.0/255, blue: 112.0/255, alpha: 1.0).CGColor

let coldTop = UIColor(red: 60.0/255, green: 157.0/255, blue: 228.0/255, alpha: 1.0).CGColor
let coldBottom = UIColor(red: 143.0/255, green: 196.0/255, blue: 228.0/255, alpha: 1.0).CGColor

typealias DownloadComplete = () -> ()
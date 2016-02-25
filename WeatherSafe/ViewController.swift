//
//  ViewController.swift
//  WeatherSafe
//
//  Created by Joshua Ide on 23/02/2016.
//  Copyright © 2016 Fox Gallery Studios. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    //Outlets
    //------------------
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var lblCityName: UILabel!
    
    //Properties
    //------------------
    var weather: Weather!
    
    //Functions
    //------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        weather = Weather()
        weather.downloadWeatherDetails { () -> () in
            self.updateUI()
        }
    }
    
    func updateUI() {
        lblCityName.text = weather.cityName
        lblCurrentTemp.text = weather.currentTemp
    }


}


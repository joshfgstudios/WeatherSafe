//
//  ViewController.swift
//  WeatherSafe
//
//  Created by Joshua Ide on 23/02/2016.
//  Copyright © 2016 Fox Gallery Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Outlets
    //------------------
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var spinnerWeather: UIActivityIndicatorView!

    
    //Properties
    //------------------
    var weather: Weather!
    var gradientColours: Colours!
    
    //Functions
    //------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        weather = Weather()
    }
        
    override func viewDidAppear(animated: Bool) {
        refreshData()
        refreshBackgroundColours()
    }
    
    func updateUI() {
        lblCityName.text = weather.cityName
        lblCurrentTemp.text = "\(weather.currentTemp) °C"
    }
    
    func refreshData() {
        func startLoading() {
            lblCityName.hidden = true
            lblCurrentTemp.hidden = true
            spinnerWeather.startAnimating()
        }
        
        func loadingComplete() {
            lblCityName.hidden = false
            lblCurrentTemp.hidden = false
            spinnerWeather.stopAnimating()
        }
        
        startLoading()
        
        weather.downloadWeatherDetails { () -> () in
            self.updateUI()
            loadingComplete()
        }
    }
    
    func refreshBackgroundColours() {
        gradientColours = Colours(top: warmTop, bottom: warmBottom)
        view.backgroundColor = UIColor.clearColor()
        let backgroundLayer = gradientColours.gradientLayer
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, atIndex: 0)
    }


}


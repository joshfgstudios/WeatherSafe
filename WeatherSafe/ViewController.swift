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
    @IBOutlet weak var spinnerRefresh: FGActivityIndicator!

    
    //Properties
    //------------------
    var weather: Weather!
    var gradientColours = Colours(top: coldBottom, bottom: hotTop)
    
    //Functions
    //------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        weather = Weather()
    }
        
    override func viewDidAppear(animated: Bool) {
        refreshData()
    }
    
    func updateUI() {
        lblCityName.text = weather.cityName
        lblCurrentTemp.text = "\(weather.currentTemp) °C"
    }
    
    func refreshData() {
        func startLoading() {
            lblCityName.hidden = true
            lblCurrentTemp.hidden = true
            spinnerRefresh.playLoadingAnimation()
            spinnerRefresh.startAnimating()
        }
        
        func loadingComplete() {
            lblCityName.hidden = false
            lblCurrentTemp.hidden = false
            spinnerRefresh.stopLoadingAnimation()
        }
        
        startLoading()
        
        weather.downloadWeatherDetails { () -> () in
            self.updateUI()
            self.refreshBackgroundColours()
            loadingComplete()
        }
    }
    
    func refreshBackgroundColours() {
        if Int(weather.currentTemp) >= 32 {
            gradientColours = Colours(top: hotTop, bottom: hotBottom)
        } else if Int(weather.currentTemp) >= 20 {
            gradientColours = Colours(top: warmTop, bottom: warmBottom)
        } else if Int(weather.currentTemp) >= 14 {
            gradientColours = Colours(top: coolTop, bottom: coolBottom)
        } else {
            gradientColours = Colours(top: coldTop, bottom: coldBottom)
        }
        
        let backgroundLayer = gradientColours.gradientLayer
        backgroundLayer.removeFromSuperlayer()
        view.backgroundColor = UIColor.clearColor()
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, atIndex: 0)
    }


}


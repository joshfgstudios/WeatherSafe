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
    @IBOutlet weak var constrYCurrentTempLabel: NSLayoutConstraint!

    
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
        //Layout
        constrYCurrentTempLabel.constant -= view.bounds.height / 24
        lblCityName.alpha = 0.0
        lblCurrentTemp.alpha = 0.0
        
        refreshData()
    }
    
    func updateUI() {
        lblCityName.text = weather.cityName
        lblCurrentTemp.text = "\(weather.currentTemp) °C"
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func refreshData() {
        startLoading()
        
        weather.downloadWeatherDetails { () -> () in
            self.updateUI()
            self.refreshBackgroundColours()

            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "loadingComplete", userInfo: nil, repeats: false)
            //loadingComplete()
        }
    }
    
    func startLoading() {
        spinnerRefresh.playLoadingAnimation()
        spinnerRefresh.startAnimating()
    }
    
    func loadingComplete() {
        spinnerRefresh.stopLoadingAnimation()
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.lblCityName.alpha = 1.0
            self.lblCurrentTemp.alpha = 1.0
            self.constrYCurrentTempLabel.constant += self.view.bounds.height / 24
            self.view.layoutIfNeeded()
            }, completion: nil)
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


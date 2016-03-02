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
    @IBOutlet weak var lblMinTemp: UILabel!
    @IBOutlet weak var lblL: UILabel!
    @IBOutlet weak var lblH: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var spinnerRefresh: FGActivityIndicator!
    @IBOutlet weak var constrYCurrentTempLabel: NSLayoutConstraint!
    @IBOutlet weak var imgWindSpeed: UIImageView!
    @IBOutlet weak var imgHumidity: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var constrYWindSpeedLabel: NSLayoutConstraint!
    @IBOutlet weak var constrYHumidityLabel: NSLayoutConstraint!

    
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
    
    override func viewWillAppear(animated: Bool) {
        //Layout
        constrYCurrentTempLabel.constant -= view.bounds.height / 24
        constrYWindSpeedLabel.constant += view.bounds.height / 12
        constrYHumidityLabel.constant += view.bounds.height / 12
        lblCityName.alpha = 0.0
        lblCurrentTemp.alpha = 0.0
        lblMinTemp.alpha = 0.0
        lblMaxTemp.alpha = 0.0
        lblL.alpha = 0.0
        lblH.alpha = 0.0
        lblWindSpeed.alpha = 0.0
        lblHumidity.alpha = 0.0
        lblDescription.alpha = 0.0
        imgWindSpeed.alpha = 0.0
        imgHumidity.alpha = 0.0
    }
        
    override func viewDidAppear(animated: Bool) {
        refreshData()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func updateUI() {
        lblCityName.text = "\(weather.cityName), \(weather.country)"
        lblCurrentTemp.text = "\(weather.currentTemp) °C"
        lblMinTemp.text = "\(weather.minTemp)"
        lblMaxTemp.text = "\(weather.maxTemp)"
        lblWindSpeed.text = "\(weather.windSpeed) KPH"
        lblHumidity.text = "\(weather.humidity) %"
        lblDescription.text = "\(weather.description)"
    }
    
    func refreshData() {
        startLoading()
        
        weather.downloadWeatherDetails { () -> () in
            self.updateUI()
            self.refreshBackgroundColours()
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "loadingComplete", userInfo: nil, repeats: false)
        }
    }
    
    func startLoading() {
        spinnerRefresh.playLoadingAnimation()
    }
    
    func loadingComplete() {
        spinnerRefresh.stopLoadingAnimation()
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.lblCityName.alpha = 0.65
            self.lblCurrentTemp.alpha = 1.0
            self.lblMinTemp.alpha = 1.0
            self.lblMaxTemp.alpha = 1.0
            self.lblL.alpha = 1.0
            self.lblH.alpha = 1.0
            self.lblWindSpeed.alpha = 1.0
            self.lblHumidity.alpha = 1.0
            self.lblDescription.alpha = 1.0
            self.imgWindSpeed.alpha = 1.0
            self.imgHumidity.alpha = 1.0
            self.constrYCurrentTempLabel.constant += self.view.bounds.height / 24
            self.constrYWindSpeedLabel.constant -= self.view.bounds.height / 12
            self.constrYHumidityLabel.constant -= self.view.bounds.height / 12
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


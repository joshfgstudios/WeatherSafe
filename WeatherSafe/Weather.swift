//
//  Weather.swift
//  WeatherSafe
//
//  Created by Joshua Ide on 25/02/2016.
//  Copyright © 2016 Fox Gallery Studios. All rights reserved.
//

import Foundation
import Alamofire

class Weather {
    
    private var _cityName: String!
    private var _weatherURL: String!
    private var _forecastURL: String!
    private var _currentTemp: String!
    private var _minTemp: String!
    private var _maxTemp: String!
    private var _windSpeed: String!
    private var _country: String!
    private var _icon: String!
    private var _description: String!
    private var _humidity: String!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = "-"
        }
        return _cityName
    }
    
    var weatherURL: String {
        return _weatherURL
    }
    
    var forecastURL: String {
        return _forecastURL
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = "-"
        }
        return _currentTemp
    }
    
    var minTemp: String {
        if _minTemp == nil {
            _minTemp = "-"
        }
        return _minTemp
    }
    
    var maxTemp: String {
        if _maxTemp == nil {
            _maxTemp = "-"
        }
        return _maxTemp
    }
    
    var windSpeed: String {
        if _windSpeed == nil {
            _windSpeed = "-"
        }
        return _windSpeed
    }
    
    var country: String {
        if _country == nil {
            _country = "-"
        }
        return _country
    }
    
    var icon: String {
        if _icon == nil {
            _icon = "01d"
        }
        return _icon
    }
    
    var description: String {
        if _description == nil {
            _description = "Clear sky"
        }
        return _description.capitalizedString
    }
    
    var humidity: String {
        if _humidity == nil {
            _humidity = "0"
        }
        return _humidity
    }
    
    init() {
        self._weatherURL = "\(URL_BASE)\(URL_DAILY)\(URL_CITY_ID)\(URL_PARAMETERS)\(API_KEY)"
        self._forecastURL = "\(URL_BASE)\(URL_FORECAST)\(URL_CITY_ID)\(URL_PARAMETERS)\(API_KEY)"
    }
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        
        let urlDaily = NSURL(string: _weatherURL)!
        let urlForecast = NSURL(string: _forecastURL)!
        
        //Alamofire request
        //-----------------
        Alamofire.request(.GET, urlDaily).responseJSON { response in
         
            let result = response.result
            
            //Top level dictionary
            if let dict = result.value as? Dictionary<String, AnyObject> {

                //Individual values
                if let name = dict["name"] as? String {
                    self._cityName = name
                }
                
                if let sys = dict["sys"] as? Dictionary<String, AnyObject> {
                    if let country = sys["country"] as? String {
                        self._country = country
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let temp = main["temp"] as? Int {
                        self._currentTemp = "\(temp)"
                    }
                    
                    if let humidity = main["humidity"] as? Double {
                        self._humidity = "\(humidity)"
                    }
                }
                
                if let wind = dict["wind"] as? Dictionary<String, AnyObject> {
                    if let speed = wind["speed"] as? Double {
                        self._windSpeed = "\(speed)"
                    }
                }
                
                if let weather = dict["weather"] as? Dictionary<String, AnyObject> {
                    if let icon = weather["icon"] as? String {
                        self._icon = icon
                    }
                    
                    if let description = weather["description"] as? String {
                        self._description = description
                    }
                }
                
                //Forecast alamofire request
                //---------------
                Alamofire.request(.GET, urlForecast).responseJSON { response in

                    let result = response.result
                    
                    //Top level dictionary
                    if let dict = result.value as? Dictionary<String, AnyObject> {
                        
                        //List of days
                        if let list = dict["list"] as? [Dictionary<String, AnyObject>] where list.count > 0 {
                            //First day in list (today)
                            if let todayTemp = list[0]["temp"] as? Dictionary<String, AnyObject> {
                                if let minToday = todayTemp["min"] as? Int {
                                    self._minTemp = "\(minToday)"
                                }
                                
                                if let maxToday = todayTemp["max"] as? Int {
                                    self._maxTemp = "\(maxToday)"
                                }
                            }
                        }
                        
                    }
                    completed()
                }
                //---------------
                //End forecast alamofire request
            }
        }
        //--------------------
        //End Alamofire request
        
    }
    
}
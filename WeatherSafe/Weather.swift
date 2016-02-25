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
    private var _currentTemp: String!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = "-"
        }
        return _cityName
    }
    
    var weatherURL: String {
        return _weatherURL
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = "-"
        }
        return _currentTemp
    }
    
    init() {
        self._weatherURL = "\(URL_BASE)\(URL_CITY_ID)\(URL_PARAMETERS)\(API_KEY)"
    }
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _weatherURL)!
        
        //Alamofire request
        //-----------------
        Alamofire.request(.GET, url).responseJSON { response in
         
            let result = response.result
            
            //Top level dictionary
            if let dict = result.value as? Dictionary<String, AnyObject> {

                //Individual values
                if let name = dict["name"] as? String {
                    self._cityName = name
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let temp = main["temp"] as? Int {
                        self._currentTemp = "\(temp)"
                    }
                }
                
            }
            completed()
        }
        //--------------------
        //End Alamofire request
        
    }
    
}
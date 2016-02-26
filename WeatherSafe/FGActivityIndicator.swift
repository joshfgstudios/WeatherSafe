//
//  FGActivityIndicator.swift
//  WeatherSafe
//
//  Created by Joshua Ide on 26/02/2016.
//  Copyright © 2016 Fox Gallery Studios. All rights reserved.
//

import UIKit

class FGActivityIndicator: UIImageView {


    var images = [UIImage]()
    
    func populateImages() {
        var x = 1
        repeat {
            let img = UIImage(named: "indicator\(x)")
            images.append(img!)
            x += 1
        } while x <= 4
    }
    
    override func startAnimating() {
        //Animation
    }
    
    override func stopAnimating() {
        //End animation
    }

}

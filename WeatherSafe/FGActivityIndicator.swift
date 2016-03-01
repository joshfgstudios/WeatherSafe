//
//  FGActivityIndicator.swift
//  WeatherSafe
//
//  Created by Joshua Ide on 26/02/2016.
//  Copyright © 2016 Fox Gallery Studios. All rights reserved.
//

import UIKit

class FGActivityIndicator: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playLoadingAnimation()
    }
    
    func playLoadingAnimation() {
        self.alpha = 1.0
        self.hidden = false
        self.image = UIImage(named: "indicator1")
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        var x = 1
        repeat {
            let img = UIImage(named: "indicator\(x)")
            imgArray.append(img!)
            x += 1
        } while x <= 4
        
        self.animationImages = imgArray
        self.animationDuration = 0.9
        self.animationRepeatCount = 100
        self.startAnimating()
    }
    
    func stopLoadingAnimation() {
            self.image = UIImage(named: "indicator1")
            self.animationImages = nil
            self.stopAnimating()
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.alpha = 0.0
            }, completion: nil)
    }

}

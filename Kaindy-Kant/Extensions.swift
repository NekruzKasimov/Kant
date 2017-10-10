//
//  Extensions.swift
//  elDiscount
//
//  Created by ZYFAR on 06.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension UIViewController {
   
    func showErrorAlert(message: String) {
        //HUD.hide()
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setNavigationBar() {
        let revealVC =  self.revealViewController()
        if revealVC != nil {
            let leftButton = UIBarButtonItem(image: UIImage(named: "menu"),
                                             style: .plain,
                                             target: revealVC,
                                             action:  #selector(SWRevealViewController.revealToggle(_:)))
            
            self.navigationItem.leftBarButtonItem = leftButton
            // self.navigationController!.navigationItem.leftBarButtonItem = leftButton
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
    }
}

extension Int {
    func timestampToDate() -> Date {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        let dtf = DateFormatter()
        let localTimeZoneName: String = TimeZone.current.identifier
        dtf.timeZone = NSTimeZone(name: localTimeZoneName) as TimeZone!
        dtf.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let temp = dtf.string(from: date as Date)
        return dtf.date(from: temp)!
    }
    
}

class Alert {
    static let shared = Alert()
    var tintColor: UIColor?
    
    func showCustomAlertIn(vc:UIViewController, withTitle title: String, message: String, actions:[UIAlertAction])  {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.tintColor = tintColor ?? .black
        for action in actions {
            alertController.addAction(action)
        }
        vc.present(alertController, animated: true, completion: nil)
    }
    
    func showSimpleAlertIn(vc:UIViewController, withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        alertController.addAction(okAction)
        vc.present(alertController, animated: true, completion: nil)
    }
}




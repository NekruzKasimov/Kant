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
//extension UIView {
//    func addConstraintsWithFormat(format: String, views: UIView...) {
//        var viewsDictionary = [String: UIView]()
//        for (index, view) in views.enumerated() {
//            let key = "v\(index)"
//            view.translatesAutoresizingMaskIntoConstraints = false
//            viewsDictionary[key] = view
//        }
//        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
//    }
//}


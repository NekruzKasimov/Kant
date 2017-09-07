//
//  Extensions.swift
//  elDiscount
//
//  Created by ZYFAR on 06.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

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

//
//  ViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 11/8/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var lang = DataManager.shared.getLanguage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Constants.shared.setLanguage()
    }
}

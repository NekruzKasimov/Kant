//
//  MainViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        mainMenuBtn.target = revealViewController()
        mainMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
    }
}

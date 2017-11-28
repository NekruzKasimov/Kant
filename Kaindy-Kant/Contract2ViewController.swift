//
//  Contract2ViewController.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 11/28/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class Contract2ViewController: ViewController {

    @IBOutlet weak var showCalendar: ShowWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pdf = Bundle.main.url(forResource: "contract2", withExtension: "pdf")
        {
            showCalendar.loadRequest(URLRequest(url: pdf))
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "agreement3".localized(lang: self.lang)!
    }
}

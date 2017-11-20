//
//  SugarViewController.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 11/20/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class SugarViewController: ViewController {

    @IBOutlet weak var showCalendar: ShowWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pdf = Bundle.main.url(forResource: "contract_sugar", withExtension: "pdf")
        {
            showCalendar.loadRequest(URLRequest(url: pdf))
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "agreement2".localized(lang: self.lang)!
    }
}

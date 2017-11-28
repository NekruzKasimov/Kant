//
//  KantViewController.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 11/20/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class KantViewController: ViewController {

    @IBOutlet weak var showCalendar: ShowWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pdf = Bundle.main.url(forResource: "contract_kant", withExtension: "pdf")
        {
            showCalendar.loadRequest(URLRequest(url: pdf))
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "agreement1".localized(lang: self.lang)!
//        self.navigationController?.navigationBar.topItem?.title = ""
    }
}

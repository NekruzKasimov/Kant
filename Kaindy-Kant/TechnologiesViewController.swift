//
//  TechnologiesViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/19/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class TechnologiesViewController: ViewController {

    @IBOutlet weak var showCalendar: ShowWebView!
    var pdfName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pdf = Bundle.main.url(forResource: pdfName, withExtension: "pdf")
        {
            showCalendar.loadRequest(URLRequest(url: pdf))
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "technology".localized(lang: self.lang)!
    }
}

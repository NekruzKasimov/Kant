//
//  LaboratoryViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 19.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class LaboratoryViewController: UIViewController {

    @IBOutlet weak var laboratoryWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "https://www.olx.ua/obyavlenie/analiz-pochv-rasteniy-i-vody-v-akkreditovanoy-laboratorii-IDbdT3X.html") {
            let request = URLRequest(url: url)
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if error == nil {
                    self.laboratoryWebView.loadRequest(request)
                }
            })
         task.resume()
        }
    }
}

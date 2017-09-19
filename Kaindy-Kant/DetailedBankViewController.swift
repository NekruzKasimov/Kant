//
//  DetailedBankViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 19.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class DetailedBankViewController: UIViewController {

    @IBOutlet weak var detailedBankWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "http://www.ab.kg/ky/bankovskie-uslugi-uridicheskim-licam/credits/agro/") {
            let request = URLRequest(url: url)
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if error == nil {
                    self.detailedBankWebView.loadRequest(request)
                }
            })
            task.resume()
        }
    }
}

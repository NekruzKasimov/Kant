//
//  DocumentViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 15.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {

    @IBOutlet weak var documentView: UIWebView!
    var documentName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let pdf = Bundle.main.url(forResource: documentName, withExtension: "pdf") {
            documentView.loadRequest(URLRequest(url: pdf))
        }
    }
}

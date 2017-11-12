//
//  AboutAppViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 02.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class AboutAppViewController: ViewController {
    
    @IBOutlet weak var aboutAppImg: UIImageView!
    @IBOutlet weak var aboutAppLbl: UILabel!
    var ru: [String]!
    var kg: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "about_app".localized(lang: self.lang)
        if self.lang == "ky" {
            aboutAppImg.image = #imageLiteral(resourceName: "gizLogoKg")
        } else {
            aboutAppImg.image = #imageLiteral(resourceName: "gizLogoRu")
        }
        aboutAppLbl.text = "about_description".localized(lang: self.lang)
    }
}

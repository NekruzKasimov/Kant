//
//  PopUpViewController.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 11/8/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class PopUpViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var hintLabel: UILabel! {
        didSet {
            hintLabel.text = "hint".localized(lang: self.lang)!
        }
    }
    
    @IBOutlet weak var hintDescriptionLabel: UILabel! {
        didSet {
            hintDescriptionLabel.text = "hint_for_user".localized(lang: lang)!
        }
    }
    
    @IBAction func dismissPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
       UserDefaults.standard.set(true, forKey: "isTipShown")
    }
}

//
//  LanguageViewController.swift
//  Kaindy-Kant
//
//  Created by ITLabAdmin on 10/5/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBOutlet weak var languageView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func russianLanguageButton(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SWRevealViewController")
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func kyrgyzchaLanguageButton(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SWRevealViewController")
        present(vc, animated: true, completion: nil)
    }
}

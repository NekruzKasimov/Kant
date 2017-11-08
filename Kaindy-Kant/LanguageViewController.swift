//
//  LanguageViewController.swift
//  Kaindy-Kant
//
//  Created by ITLabAdmin on 10/5/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SwiftyJSON

class LanguageViewController: UIViewController {
    
    @IBOutlet weak var languageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func russianLanguageButton(_ sender: Any) {
        DataManager.shared.setLanguage(language: "ru")
        showMainPage()
    }
    @IBAction func kyrgyzchaLanguageButton(_ sender: Any) {
        DataManager.shared.setLanguage(language: "ky")
        showMainPage()
    }
    func showMainPage(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SWRevealViewController")
        present(vc, animated: true, completion: nil)
    }
}


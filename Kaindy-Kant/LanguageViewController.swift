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
        sighUp()
    }
    @IBAction func kyrgyzchaLanguageButton(_ sender: Any) {
        sighUp()
    }
    func sighUp(){
        ServerManager.shared.signUp(newUser: DataManager.shared.getNewUser(), completion: showJson, error: showErrorAlert)
    }
    func  showJson(user_id: Int) {
        DataManager.shared.setUserId(user_id: user_id)
        DataManager.shared.saveUser(username: DataManager.shared.getNewUser().phone, password: DataManager.shared.getNewUser().password)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SWRevealViewController")
        present(vc, animated: true, completion: nil)
    }
}

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
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SWRevealViewController")
        sighUp()
        present(vc, animated: true, completion: nil)
    }
    @IBAction func kyrgyzchaLanguageButton(_ sender: Any) {
       
        sighUp()
       
    }
    func sighUp(){
        //let cookie = HTTPCookie.self
        let cookieJar = HTTPCookieStorage.shared
        
        for cookie in cookieJar.cookies! {
            print(cookie.name+"="+cookie.value)
            cookieJar.deleteCookie(cookie)
        }
        ServerManager.shared.signUp(newUser: DataManager.shared.getNewUser(), completion: showJson, error: showErrorAlert)
    }
    
    func  showJson(json: JSON) {
        ServerManager.shared.login(login: DataManager.shared.getNewUser().phone, password: DataManager.shared.getNewUser().password, completion: log_in, error: showErrorAlert)
        
    }
    func log_in(user_id: Int) {
        DataManager.shared.setUserId(user_id: user_id)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SWRevealViewController")
        present(vc, animated: true, completion: nil)
    }
}

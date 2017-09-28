//
//  ChangingPasswordViewController.swift
//  Kaindy-Kant
//
//  Created by ITLabAdmin on 9/21/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class ChangingPasswordViewController: UIViewController {

    @IBOutlet weak var chagingPasswordView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "Восстановление пароля"
//        self.navigationController?.navigationBar.topItem?.title = ""
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Восстановление пароля"
      // self.navigationController?.navigationBar.topItem?.title = ""
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        self.title = "Восстановление пароля"
//        self.navigationController?.navigationBar.topItem?.title = ""
//    }
    @IBAction func chagingPasswordBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ManagingPasswordViewController") as! ManagingPasswordViewController
        self.navigationController?.show(vc, sender: self)
   
    }
}

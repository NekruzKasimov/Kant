//
//  ManagingPasswordViewController.swift
//  Kaindy-Kant
//
//  Created by ITLabAdmin on 9/21/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class ManagingPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Восстановление пароля"
        self.navigationController?.navigationBar.topItem?.title = ""
        // Do any additional setup after loading the view.
    }

    @IBAction func saveNewPasswordButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        //include library PKHUD to show progress of success
    }
    
}

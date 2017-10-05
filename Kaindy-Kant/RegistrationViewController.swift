//
//  RegistrationViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/11/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FontAwesome_swift

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var birthdayTF: UITextField! {
        didSet {
            birthdayTF.delegate = self
            birthdayTF.tag = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = NSLocalizedString("Регистрация", comment: "Регистрация")
    }
    @IBAction func saveButton(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Registration", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LanguageViewController") as? LanguageViewController
        self.present(nextViewController!, animated:true, completion:nil)
    }
}

// MARK: Helper functions

extension RegistrationViewController {
    func showDatePicker() {
        let myDatePicker = UIDatePicker()
        myDatePicker.datePickerMode = .date
        myDatePicker.frame = CGRect(x:0,y:15, width: 270, height: 200)
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alertController.view.addSubview(myDatePicker)
        alertController.view.tintColor = .black
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.locale = Locale.init(identifier: "en_GB")
            self?.birthdayTF.text = dateFormatter.string(from: myDatePicker.date)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:{})
    }
}


// MARK: UITextFieldDelegate methods

extension RegistrationViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            showDatePicker()
            return false
        } else {
            return true
        }
    }
}

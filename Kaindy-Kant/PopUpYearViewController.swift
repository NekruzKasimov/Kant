//
//  PopUpYearViewController.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 11/6/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class PopUpYearViewController: UIViewController {
    var years = [Int]()
    var choseYear: Int = 0
    @IBOutlet weak var yearPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.years = DataManager.shared.getYears()
        choseYear = years[years.count - 1]
    }
    @IBAction func addFieldPressed(_ sender: Any) {
        print(choseYear)
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        //self.navigationController?.show(vc, sender: self)
        self.parent?.navigationController?.show(vc, sender: self)
       // self.dismiss(animated: true, completion: nil)
        
       // present(vc, animated: true, completion: nil)
    }
}
extension PopUpYearViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.years.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(self.years[row])"
    }
    
}

extension PopUpYearViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(years[row])
        choseYear = years[row]
        self.view.endEditing(true)
    }
}

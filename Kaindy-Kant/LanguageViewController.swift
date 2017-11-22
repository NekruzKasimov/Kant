//
//  LanguageViewController.swift
//  Kaindy-Kant
//
//  Created by ITLabAdmin on 10/5/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SwiftyJSON
import PickerView
class LanguageViewController: UIViewController {
    
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var languagePickerView: PickerView!
    
    var languages = ["Русский", "Кыргызча"]
    var selectLanguages = ["Выберите язык", "Тил тандаңыз"]
    var titles = ["Добро пожаловать!", "Кош келиниз!"]
    var buttonTitles = ["Далее", "Кийинки"]
    var isLogin = true
    override func viewDidLoad() {
        super.viewDidLoad()
        languagePickerView.dataSource = self
        languagePickerView.delegate = self
        languagePickerView.selectionStyle = .defaultIndicator
        languagePickerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if languagePickerView.currentSelectedIndex == 0 {
            DataManager.shared.setLanguage(language: "ru")
            showMainPage()
        }
        else {
            DataManager.shared.setLanguage(language: "ky")
            showMainPage()
        }
       
    }
    func showMainPage(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SWRevealViewController")
        present(vc, animated: true, completion: nil)
    }
}
extension LanguageViewController: PickerViewDataSource, PickerViewDelegate {
    func pickerViewNumberOfRows(_ pickerView: PickerView) -> Int {
        return languages.count
    }
    func pickerView(_ pickerView: PickerView, titleForRow row: Int, index: Int) -> String {
        let item = languages[index]
        return item
    }
    func pickerViewHeightForRows(_ pickerView: PickerView) -> CGFloat {
        return 60
    }
    func pickerView(_ pickerView: PickerView, didSelectRow row: Int, index: Int) {
        
        if isLogin {
            nextButton.setTitle(buttonTitles[index], for: .normal)
            titleLabel.text = titles[index]
        }
        else {
            titleLabel.text = selectLanguages[index]
        }
       // print(languages[index])
    }
    func pickerView(_ pickerView: PickerView, styleForLabel label: UILabel, highlighted: Bool) {
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25.0)
        if highlighted {
            label.textColor = .black
        } else {
            label.textColor = .lightGray
        }
    }
    
}


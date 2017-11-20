//
//  ProfileMapTableViewCell.swift
//  Kaindy-Kant
//
//  Created by ITLabAdmin on 9/22/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
protocol ButtonDelegate : class {
    func didPressButton(_ tag: Int, _ action: String)
}
class ProfileMapTableViewCell: UITableViewCell {
    weak var cellDelegate: ButtonDelegate?

    @IBOutlet weak var cardView: UIView! {
        didSet {
            cardView.layer.cornerRadius = 3
            cardView.layer.masksToBounds = false
            cardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
            cardView.layer.shadowOpacity = 0.8
        }
    }
    
    let lang = DataManager.shared.getLanguage()
    
    @IBOutlet weak var averageYieldLabel: UILabel! {
        didSet {
            averageYieldLabel.text = "average_yield".localized(lang: lang)
        }
    }
    @IBOutlet weak var hectaresLabel: UILabel! {
        didSet {
            hectaresLabel.text = "hectar".localized(lang: lang)
        }
    }
    @IBOutlet weak var totalYieldLabel: UILabel!{
        didSet {
            totalYieldLabel.text = "total_yield".localized(lang: lang)
        }
    }
    @IBOutlet weak var beetPointLabel: UILabel! {
        didSet {
            beetPointLabel.text = "beet_point".localized(lang: lang)
        }
    }
    @IBOutlet weak var deleteButton: UIButton! {
        didSet {
           deleteButton.setTitle("delete".localized(lang: lang), for: .normal)
        }
    }
    
    @IBOutlet weak var showOnMapButton: UIButton!{
        didSet {
            showOnMapButton.setTitle("look_at_the_map".localized(lang: lang), for: .normal)
        }
    }
    @IBOutlet weak var changeButton: UIButton! {
        didSet {
            changeButton.setTitle("change".localized(lang: lang), for: .normal)
        }
    }
    @IBOutlet weak var buttonMap: UIButton! {
        didSet {
            buttonMap.layer.masksToBounds = true
            buttonMap.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var idLabel: UILabel! 
    
    @IBOutlet weak var areaLabel: UILabel!
    
    @IBOutlet weak var averageLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var beetLabel: UILabel!
    
    @IBOutlet weak var deleteImageView: UIImageView! {
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(delete(tapGestureRecognizer:)))
            deleteImageView.isUserInteractionEnabled = true
            deleteImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @IBOutlet weak var updateImageView: UIImageView! {
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(update(tapGestureRecognizer:)))
            updateImageView.isUserInteractionEnabled = true
            updateImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    func update(tapGestureRecognizer: UITapGestureRecognizer)
    {
        cellDelegate?.didPressButton(self.tag, "update")
    }
    func delete(tapGestureRecognizer: UITapGestureRecognizer)
    {
        cellDelegate?.didPressButton(self.tag, "delete")
    }
    @IBAction func showInMap(_ sender: Any) {
        cellDelegate?.didPressButton(self.tag, "show")
    }
    @IBAction func deleteFieldPressed(_ sender: Any) {
        cellDelegate?.didPressButton(self.tag, "delete")
    }
    @IBAction func updateFieldPressed(_ sender: Any) {
        cellDelegate?.didPressButton(self.tag, "update")

    }
//    func setData(field: Field){
//        
//    }
    
}

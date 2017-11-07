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
    
    @IBAction func showInMap(_ sender: Any) {
        cellDelegate?.didPressButton(self.tag, "show")
    }
    @IBAction func deleteFieldPressed(_ sender: Any) {
        cellDelegate?.didPressButton(self.tag, "delete")
    }
    @IBAction func updateFieldPressed(_ sender: Any) {
        cellDelegate?.didPressButton(self.tag, "update")

    }
    
}

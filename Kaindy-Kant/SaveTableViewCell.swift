//
//  SaveTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 11/6/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

protocol SaveButtonDelegate : class {
    func didPressButton(_ tag: Int)
}

class SaveTableViewCell: UITableViewCell {
    weak var cellDelegate: SaveButtonDelegate?

    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.setTitle("save".localized(lang: DataManager.shared.getLanguage()), for: .normal)
        }
    }
    @IBAction func saveExpensesPressed(_ sender: Any) {
        cellDelegate?.didPressButton(self.tag)

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}

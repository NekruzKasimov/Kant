//
//  ProfileMapTableViewCell.swift
//  Kaindy-Kant
//
//  Created by ITLabAdmin on 9/22/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
protocol ButtonDelegate : class {
    func didPressButton(_ tag: Int)
}
class ProfileMapTableViewCell: UITableViewCell {
    weak var cellDelegate: ButtonDelegate?

    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var areaLabel: UILabel!
    
    @IBOutlet weak var averageLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBAction func showInMap(_ sender: Any) {
        cellDelegate?.didPressButton(self.tag)
    }
    
}

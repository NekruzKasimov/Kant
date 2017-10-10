//
//  ContactsTableVIewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class ContactsTableViewCell: UITableViewCell {
   
    @IBOutlet weak var iconImage: UIImageView! {
        didSet {
            iconImage.image = UIImage(named: "camera")
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dataLabel: UILabel!
}

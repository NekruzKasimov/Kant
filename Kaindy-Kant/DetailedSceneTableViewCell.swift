//
//  DetailedSceneTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/5/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class DetailedSceneTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var logoImageView: UIImageView! {
        didSet {
            logoImageView.image = UIImage(named: "camera")
        }
    }
}

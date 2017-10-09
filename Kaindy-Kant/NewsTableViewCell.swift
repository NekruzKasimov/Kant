//
//  NewsTableViewCell.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 03.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsView: UIView! {
        didSet {
            newsView.layer.cornerRadius = 3
            newsView.layer.masksToBounds = false
            newsView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            newsView.layer.shadowOffset = CGSize(width: 0, height: 0)
            newsView.layer.shadowOpacity = 0.8
        }
    }
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
}

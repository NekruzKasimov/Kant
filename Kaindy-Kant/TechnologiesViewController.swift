//
//  TechnologiesViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/19/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class TechnologiesViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var desc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = desc
        navigationController?.navigationBar.topItem?.title = ""
    }

}

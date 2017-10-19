//
//  LocalNewsViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 17.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import ImageSlideshow

class LocalNewsViewController: UIViewController {

    @IBOutlet weak var localNewsSlideShow: ImageSlideshow!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSlideShow()
    }
    
    func setupSlideShow() {
        let images: [String] = ["consultation" , "consultation" , "consultation" , "consultation"]
        var imageArray = [InputSource]()
        var count = 0
        for imageModel in images {
            guard  let url = URL(string: imageModel) else {
                return
            }
            imageArray.append(KingfisherSource(url: url))
            
            count += 1
        }
        localNewsSlideShow.setImageInputs(imageArray)
        localNewsSlideShow.pageControl.pageIndicatorTintColor = UIColor.lightGray
        localNewsSlideShow.pageControl.currentPageIndicatorTintColor = .red
    }
}

//
//  HeaderViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import ImageSlideshow

class HeaderViewController: UIViewController {
    
    @IBOutlet weak var slideShow: ImageSlideshow!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var finOffice: DetailedFinOffice!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = finOffice.title
        setSlideImageView()
    }

    func setSlideImageView() {
        var images: [String] = []
        for item in (finOffice.images?.array)! {
            images.append(item.image)
        }
        
        if (images.count != 0) {
            var imageArray = [InputSource]()
            var count = 0
            for imageModel in images {
                guard  let url = URL(string: imageModel) else {
                    return
                }
                imageArray.append(KingfisherSource(url: url))
                
                count += 1
            }
            slideShow.setImageInputs(imageArray)
        } else {
            let url = URL(string: finOffice.logo)!
            var imageArray = [InputSource]()
            imageArray.append(KingfisherSource(url: url))
            slideShow.setImageInputs(imageArray)
        }
        
        slideShow.pageControl.pageIndicatorTintColor = UIColor.lightGray
        slideShow.pageControl.currentPageIndicatorTintColor = .red
    }
}


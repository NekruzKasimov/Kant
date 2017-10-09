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
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        titleLabel.text = course.name
//        setSlideImageView()
//    }
//    
//    func setSlideImageView() {
//        ServerManager.shared._course = nil
//        var images: [String] = []
//        for item in course.images.array {
//            images.append(item.imagePath)
//        }
//        
//        if (images.count != 0) {
//            var imageArray = [InputSource]()
//            var count = 0
//            for imageModel in images {
//                guard  let url = URL(string: imageModel) else {
//                    return
//                }
//                imageArray.append(KingfisherSource(url: url))
//                
//                count += 1
//            }
//            slideShow.setImageInputs(imageArray)
//        } else {
//            slideShow.setImageInputs([ ImageSource(image: UIImage(named: "no-image")!)])
//        }
//        
//        slideShow.pageControl.pageIndicatorTintColor = UIColor.lightGray
//        slideShow.pageControl.currentPageIndicatorTintColor = ThemeColor.coral
//    }
}


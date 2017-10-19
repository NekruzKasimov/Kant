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
    @IBOutlet weak var localNewsTitle: UILabel!
    @IBOutlet weak var localNewsContent: UILabel!
    
    var newsTitle = ""
    var newsContent = ""
    var images: NewsPhotos?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSlideShow()
        localNewsTitle.text = newsTitle
        localNewsContent.text = newsContent
        
    }
    
    func setupSlideShow() {
        
        var imageArray = [InputSource]()
        var count = 0
        for imageModel in (images?.array)! {
            guard  let url = URL(string: imageModel.link) else {
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

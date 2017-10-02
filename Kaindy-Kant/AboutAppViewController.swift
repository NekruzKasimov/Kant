//
//  AboutAppViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 02.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class AboutAppViewController: UIViewController {
    
    @IBOutlet weak var aboutAppImg: UIImageView!
    @IBOutlet weak var aboutAppLbl: UILabel!
    var ru: [String]!
    var kg: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        
        ru = ["Мобильное приложение разработано при финансовой поддержке Федерального правительства Германии через программу Deutsche Gesellschaft für Internationale Zusammenarbeit (GIZ) GmbH (Германского общества по международному сотрудничеству) „Содействие устойчивому экономическому развитию“." , "gizLogoRu"]
        kg = ["Мобилдик колдонмо Германия Федералдык өкмөтү тарабынан  каржыланган Deutsche Gesellschaft für Internationale Zusammenarbeit (GIZ) GmbH (Германия эл аралык кызматташуу коомунун) «Туруктуу экономикалык өнүгүүгө көмөктөшүү” программасы аркылуу иштеп чыгарылган.", "gizLogoKg"]
        
        aboutAppImg.image = UIImage(named: ru[1])
        aboutAppLbl.text = ru[0]
    }
}

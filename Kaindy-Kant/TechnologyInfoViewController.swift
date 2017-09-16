//
//  TechnologyInfoViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 11.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class TechnologyInfoViewController: UIViewController {
    
    @IBOutlet weak var docsTableView: UITableView!
    var docs = ["Приложение 4_Модуль_Сахарная свекла_2016" ,
                "Приложение 5_Кант кызылчасын өстүрүү технологиясы боюнча кыскача таркатма" ,
                "Приложение 6_Тех карта_ сахарная свекла_образец и пустая_2016 - Тех карта_образец_Миргасым" ,
                "Приложение 7_Сравнительный анализ культур_свекла_картофель_кукуруза" ,
                "Sugar Beet VAC_Development Concept-2_MD"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        docsTableView.estimatedRowHeight = 74
        docsTableView.rowHeight = UITableViewAutomaticDimension
        setNavigationBar()
    }
}

extension TechnologyInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = docs[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "TechnologyInfo", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController
        vc.documentName = docs[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

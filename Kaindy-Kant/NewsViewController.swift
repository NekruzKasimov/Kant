//
//  NewsViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 03.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SafariServices
import SVProgressHUD

enum NewsSections: Int {
    case sugar = 0
    case news  = 1
    
    func getItemsCount() -> Int {
        switch self {
        case .sugar:
            return 1
        case .news:
            return 4
        }
    }
}

class NewsViewController: ViewController {

    var newRossahar: Rossahar?
    var sugarJom: SugarJom?
    var localNews: News!
    
    @IBOutlet weak var mySCOutlet: UISegmentedControl! {
        didSet {
            mySCOutlet.setTitle("Россахар", forSegmentAt: 0)
            mySCOutlet.setTitle("local".localized(lang: self.lang), forSegmentAt: 1)
        }
    }
    
    @IBAction func showOtherNews(_ sender: Any) {
        
    }
    
    @IBOutlet weak var newsTableView: UITableView! {
        didSet {
            newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
            newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        SVProgressHUD.show()
        self.title = "news".localized(lang: self.lang)!
        ServerManager.shared.getNewsRossahar({ (succes) in
            SVProgressHUD.dismiss()
            self.setRossahar(rossahar: succes)
        }, error: { (error) in
            SVProgressHUD.dismiss()
            self.showErrorAlert(message: error)
        })
        
        ServerManager.shared.getSugarJom({ (success) in
            SVProgressHUD.dismiss()
           self.setSugarJom(sugarjom: success)
        }, error: { (error) in
            SVProgressHUD.dismiss()
            self.showErrorAlert(message: error)
        })
        
        ServerManager.shared.getLocalNews({ (news) in
            self.setLocalNews(local: news)
            SVProgressHUD.dismiss()
        }, error: { (error) in
            SVProgressHUD.dismiss()
            self.showErrorAlert(message: error)
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "news".localized(lang: self.lang)!
    }
    func setRossahar(rossahar: Rossahar) {
        self.newRossahar = rossahar
        newsTableView.reloadData()
    }
    
    func setSugarJom(sugarjom: SugarJom) {
        self.sugarJom = sugarjom
        newsTableView.reloadData()
    }
    
    func setLocalNews(local: News) {
        self.localNews = local
        newsTableView.reloadData()
    }
   
    @IBAction func mySegmentedControllAction(_ sender: Any) {
        switch mySCOutlet.selectedSegmentIndex {
        case 0:
            newsTableView.reloadData()
        case 1:
            newsTableView.reloadData()
        default:
            break
        }
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if let _ = sugarJom {
                return 1
            }
            return 0
        } else if section == 1 && mySCOutlet.selectedSegmentIndex == 0 {
            if let count = newRossahar?.results.array.count {
                return count - 1
            }
            return 0
        } else {
            if let count = localNews?.results.array.count  {
                return count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch NewsSections(rawValue: indexPath.section)! {
        case .sugar:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SugarAndJomTableViewCell") as! SugarAndJomTableViewCell
            cell.setValues(sugarJom: sugarJom!)
            return cell
        case .news:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
            
            if mySCOutlet.selectedSegmentIndex == 0 {
                cell.setValues(result: (newRossahar?.results.array[indexPath.row])!)
            } else if mySCOutlet.selectedSegmentIndex == 1 {
                cell.setLocalNews(result: (localNews.results.array[indexPath.row].data))
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 204
        }
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && mySCOutlet.selectedSegmentIndex == 0 {
            self.present(SFSafariViewController.init(url: URL(string: "http://rossahar.ru\(newRossahar!.results.array[indexPath.row].link)")!), animated: true, completion: nil)
            
        } else if indexPath.section == 1 && mySCOutlet.selectedSegmentIndex == 1 {
            let sb = UIStoryboard(name: "News", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "LocalNewsViewController") as! LocalNewsViewController
            
            vc.newsTitle = localNews.results.array[indexPath.row].data.title
            vc.newsContent = localNews.results.array[indexPath.row].data.content
            vc.images = localNews.results.array[indexPath.row].photo
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

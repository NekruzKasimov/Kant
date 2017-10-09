//
//  ServerManager.swift
//  OpenSport
//
//  Created by Sanira on 12/3/16.
//  Copyright © 2016 TimelySoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServerManager: HTTPRequestManager  {

    class var shared: ServerManager {
        struct Static {
            static let instance = ServerManager()
        }
        return Static.instance
    }
    
    func getWeather(_ completion: @escaping (Weather)-> Void, error: @escaping (String)-> Void) {
        self.get(api: "&APPID=079587841f01c6b277a82c1c7788a6c3", completion: { (json) in
                    let obj = Weather(json: json)
                    completion(obj)
                }, error: error)
    }
    
    func getAllFinancialOffices(_ completion: @escaping (FinancialOffices)-> Void, error: @escaping (String)-> Void) {
        self.get(api: "/fin-office", completion: { (json) in
            let obj = FinancialOffices(json: json)
            completion(obj)
        }, error: error)
    }
    
    func getFinancialOfficeById(id: Int, _ completion: @escaping (DetailedFinOffice)-> Void, error: @escaping (String)-> Void) {
        self.get(api: "/fin-office/\(id)", completion: { (json) in
            let obj = DetailedFinOffice(json: json)
            completion(obj)
        }, error: error)
    }
    
}

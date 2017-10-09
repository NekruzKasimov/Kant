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
        print("here")
        self.get(endpoint: "", serverType: .whether, completion: { (json) in
            let obj = Weather(json: json)
            completion(obj)
        }, error: error)
    }
//    func signUp(category: Category, completion: @escaping ()-> Void,error: @escaping (String)-> Void) {
//        //let param = category.toDict()
//
//        post(api: "addSubCategories",
//             parameters: param, completion: {(json) in
//                self._categories = nil
//                completion()
//        }
//            , error: error)
//    }
}

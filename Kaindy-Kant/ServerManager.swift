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
    
    var _rossahar: Rossahar?
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
    func signUp(newUser: NewUser, completion: @escaping (JSON)-> Void,error: @escaping (String)-> Void) {
        //let param = category.toDict()
        self.post(endpoint: Constants.Network.EndPoints.SignUp, serverType: .kant, parameters: newUser.toDictionary(), completion: { (json) in
            //let message = json[""]
            completion(json)
        }, error: error)
    }

    func getAllFinancialOffices(_ completion: @escaping (FinancialOffices)-> Void, error: @escaping (String)-> Void) {
        self.get(endpoint: Constants.Network.EndPoints.FinOffice, serverType: .kant, completion: { (succes) in
            completion(FinancialOffices(json: succes))
        }) { (error) in
        }
        
    }
    
    func getFinancialOfficeById(id: Int, _ completion: @escaping (DetailedFinOffice)-> Void, error: @escaping (String)-> Void) {
        self.get(endpoint: "\(Constants.Network.EndPoints.FinOffice)/\(id)", serverType: .kant, completion: { (succes) in
            completion(DetailedFinOffice(json: succes))
        }) { (error) in
        }
    }
    
    func getNewsRossahar(_ completion: @escaping (Rossahar)-> Void, error: @escaping (String)-> Void) {
        self.get(endpoint: "\(Constants.Network.EndPoints.NewRossahar)", serverType: .kant, completion: { (success) in
            completion(Rossahar(json: success))
        }) { (error) in
        }
    }
    
//    func getContactTypes(_ completion: @escaping (ContactTypes)-> Void, error: @escaping (String)-> Void) {
//
//        post(api: "addSubCategories",
//             parameters: param, completion: {(json) in
//                self._categories = nil
//                completion()
//        }
//            , error: error)
//    }
}

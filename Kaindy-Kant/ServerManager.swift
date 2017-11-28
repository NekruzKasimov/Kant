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
    var _expenses: Expenses?
    
    class var shared: ServerManager {
        struct Static {
            static let instance = ServerManager()
        }
        return Static.instance
    }
    
    func checkInternetConnection() -> Bool {
        return self.checkInternetConnection()
    }
    
    func getWeather(_ completion: @escaping (Weather)-> Void, error: @escaping (String)-> Void) {
        
        let data = UserDefaults.standard.data(forKey: "weather")

        if UserDefaults.standard.bool(forKey: "weatherCached") {
            completion(Weather(json: JSON(json: data)))
            return
        }
        
        self.get(endpoint: Constants.Network.EndPoints.Weather, serverType: .kant, completion: { (json) in
            let obj = Weather(json: json)
            completion(obj)
        }, error: { (err) in
            if err.contains("Нет подключения к интернету") || err.contains("Интернет байланышы жок"){
                completion(Weather(json: JSON(json: data)))
            }
            error(err)
        }) { (jsonValue) in
            UserDefaults.standard.set(jsonValue, forKey: "weather")
            UserDefaults.standard.set(true, forKey: "weatherCached")
        }
    }
    
    func signUp(newUser: NewUser, completion: @escaping (Int)-> Void, error: @escaping (String)-> Void) {
        //let param = category.toDict()
        self.post(endpoint: Constants.Network.EndPoints.SignUp, serverType: .kant, parameters: newUser.toDictionary(), completion: { (json) in
            //let message = json[""]
            let token = json["token"].stringValue
            UserDefaults.standard.set(token, forKey: "token")
            let user_id = json["user_id"].intValue
            completion(user_id)
        }, error: error) { (jsonValue) in
        }
    }
    
    func login(login: String, password: String, completion: @escaping (Int)-> Void,error: @escaping (String)-> Void) {
        //let param = category.toDict()
            self.post(endpoint: Constants.Network.EndPoints.Login, serverType: .kant, parameters: ["phone": login, "password": password], completion: { (json) in
                let token = json["token"].stringValue
                UserDefaults.standard.set(token, forKey: "token")
                let user_id = json["user_id"].intValue
                completion(user_id)
            }, error: error) { (jsonValue) in
        }
    }
    func getUser(_ completion: @escaping (NewUser)-> Void, error: @escaping (String)-> Void) {
        self.get(endpoint: "\(Constants.Network.EndPoints.GetUser)/\(DataManager.shared.getUserId())", serverType: .kant, completion: { (json) in
            
            completion(NewUser(json: json))
        }, error: error) { (jsonValue) in
        }
    }
    func updateUser(parameters: [String: String], _ completion: @escaping (NewUser)-> Void, error: @escaping (String)-> Void) {
        print(parameters)
        self.patch(endpoint: "\(Constants.Network.EndPoints.UpdateUser)/\(DataManager.shared.getUserId())", serverType: .kant, parameters: parameters, completion: { (json) in
            completion(NewUser(json: json))
        }, error: error) { (jsonValue) in
        }
    }
    func getFields(_ completion: @escaping (Years)-> Void, error: @escaping (String)-> Void) {
        
        let data = UserDefaults.standard.data(forKey: "fields")
        
        if UserDefaults.standard.bool(forKey: "fieldsCached") {
            completion(Years(json: JSON(json: data)))
            return
        }
        
        self.get(endpoint: "\(Constants.Network.EndPoints.GetFields)/\(DataManager.shared.getUserId())", serverType: .kant, header: DataManager.shared.getLanguage(), completion: { (json) in
            completion(Years(json: json))
        }, error: { (err) in
           if err.contains("Нет подключения к интернету") || err.contains("Интернет байланышы жок"){
                completion(Years(json: JSON(json: data)))
            }
            error(err)
        }) { (jsonValue) in
            UserDefaults.standard.set(jsonValue, forKey: "fields")
            UserDefaults.standard.set(true, forKey: "fieldsCached")
        }
    }
//    func getAllFinancialOffices(_ completion: @escaping (FinancialOffices)-> Void, error: @escaping (String)-> Void) {
//        self.get(endpoint: Constants.Network.EndPoints.FinOffice, serverType: .kant, completion: { (succes) in
//            completion(FinancialOffices(json: succes))
//        }, error: error)
//        
//    }
//    
//    func getFinancialOfficeById(id: Int, _ completion: @escaping (DetailedFinOffice)-> Void, error: @escaping (String)-> Void) {
//        self.get(endpoint: "\(Constants.Network.EndPoints.FinOffice)/\(id)", serverType: .kant, completion: { (succes) in
//            completion(DetailedFinOffice(json: succes))
//        }, error: error)
//    }
    
    func getNewsRossahar(_ completion: @escaping (Rossahar)-> Void, error: @escaping (String)-> Void) {
        
        let data = UserDefaults.standard.data(forKey: "rossahar")
        
        if UserDefaults.standard.bool(forKey: "rossaharCached") {
            completion(Rossahar(json: JSON(json: data)))
            return
        }
        
        self.get(endpoint: "\(Constants.Network.EndPoints.NewRossahar)", serverType: .kant, completion: { (success) in
            completion(Rossahar(json: success))
        }, error: { (err) in
            if err.contains("Нет подключения к интернету") || err.contains("Интернет байланышы жок"){
                completion(Rossahar(json: JSON(json: data)))
            }
            error(err)
        }) { (jsonValue) in
            UserDefaults.standard.set(jsonValue, forKey: "rossahar")
            UserDefaults.standard.set(true, forKey: "rossaharCached")
        }
    }
    
    func getLocalNews(_ completion: @escaping (News)-> Void, error: @escaping (String)-> Void) {
        
        let data = UserDefaults.standard.data(forKey: "local")
        
        if UserDefaults.standard.bool(forKey: "localCached") {
            completion(News(json: JSON(json: data)))
            return
        }
        
        self.get(endpoint: "\(Constants.Network.EndPoints.LocalNews)", serverType: .kant, header: DataManager.shared.getLanguage(), completion: { (success) in
            completion(News(json: success))
        }, error: { (err) in
            if err.contains("Нет подключения к интернету") || err.contains("Интернет байланышы жок"){
                completion(News(json: JSON(json: data)))
            }
            error(err)
        }) {  (jsonValue) in
            UserDefaults.standard.set(jsonValue, forKey: "local")
            UserDefaults.standard.set(true, forKey: "localCached")
        }
    }
    
    
    
    func getExpenses(_ completion: @escaping (Expenses)-> Void, error: @escaping (String)-> Void) {
        
        let data = UserDefaults.standard.data(forKey: "expenses")
        
        if UserDefaults.standard.bool(forKey: "expensesCached") {
            completion(Expenses(json: JSON(json: data)))
            return
        }
        
        
        self.get(endpoint: Constants.Network.EndPoints.Expenses, serverType: .kant, header: DataManager.shared.getLanguage(), completion: { (success) in
            completion(Expenses(json: success))
        }, error: { (err) in
            if err.contains("Нет подключения к интернету") || err.contains("Интернет байланышы жок"){
                completion(Expenses(json: JSON(json: data)))
            }
            error(err)
        }) { (jsonValue) in
            UserDefaults.standard.set(jsonValue, forKey: "expenses")
            UserDefaults.standard.set(true, forKey: "expensesCached")
        }
        
    }
    
    func getFieldExpenses(field_id: Int,_ completion: @escaping (Expenses)-> Void, error: @escaping (String)-> Void) {
        self.get(endpoint: "\(Constants.Network.EndPoints.FieldExpenses)/\(field_id)", serverType: .kant, header: DataManager.shared.getLanguage(),  completion: { (success) in
            completion(Expenses(json: success))
        }, error: error) { (jsonValue) in
        }
        
    }
    
    func getSugarJom(_ completion: @escaping (SugarJom)-> Void, error: @escaping (String)-> Void) {
       
        let data = UserDefaults.standard.data(forKey: "sugarJom")
        
        if UserDefaults.standard.bool(forKey: "sugarJomCached") {
            completion(SugarJom(json: JSON(json: data)))
            return
        }
        
        self.get(endpoint: "\(Constants.Network.EndPoints.SugarJom)", serverType: .kant, completion: { (success) in
            completion(SugarJom(json: success))
        }, error: { (err) in
            if err.contains("Нет подключения к интернету") || err.contains("Интернет байланышы жок"){
                completion(SugarJom(json: JSON(json: data)))
            }
            error(err)
        }) {  (jsonValue) in
            UserDefaults.standard.set(jsonValue, forKey: "sugarJom")
            UserDefaults.standard.set(true, forKey: "sugarJomCached")
        }
    }
    
    func getServices(_ completion: @escaping (Services)-> Void, error: @escaping (String)-> Void) {
        
        let data = UserDefaults.standard.data(forKey: "services")
        
        if UserDefaults.standard.bool(forKey: "servicesCached") {
            completion(Services(json: JSON(json: data)))
            return
        }
        
        self.get(endpoint: "\(Constants.Network.EndPoints.GetServices)", serverType: .kant, header: DataManager.shared.getLanguage(), completion: { (success) in
            completion(Services(json: success))
        }, error: { (err) in
            if err.contains("Нет подключения к интернету") || err.contains("Интернет байланышы жок"){
                completion(Services(json: JSON(json: data)))
            }
            error(err)
        }) { (jsonValue) in
            UserDefaults.standard.set(jsonValue, forKey: "services")
            UserDefaults.standard.set(true, forKey: "servicesCached")
        }
    }
    
    func getTechnologies(_ completion: @escaping (Technologies)-> Void, error: @escaping (String)-> Void) {
        self.get(endpoint: "\(Constants.Network.EndPoints.GetTechnologies)", serverType: .kant, header: DataManager.shared.getLanguage(), completion: { (success) in
            completion(Technologies(json: success))
        }, error: error){ (jsonValue) in
        }
    }
    
    func getSuppliers(_ completion: @escaping (Services)-> Void, error: @escaping (String)-> Void) {
        
        let data = UserDefaults.standard.data(forKey: "suppliers")
        
        if UserDefaults.standard.bool(forKey: "suppliersCached") {
            completion(Services(json: JSON(json: data)))
            return
        }
        
        self.get(endpoint: "\(Constants.Network.EndPoints.GetSuppliers)", serverType: .kant, header:
            DataManager.shared.getLanguage(), completion: { (success) in
            completion(Services(json: success))
        }, error: { (err) in
            if err.contains("Нет подключения к интернету") || err.contains("Интернет байланышы жок"){
                completion(Services(json: JSON(json: data)))
            }
            error(err)
        }) {  (jsonValue) in
            UserDefaults.standard.set(jsonValue, forKey: "suppliers")
            UserDefaults.standard.set(true, forKey: "suppliersCached")
        }
    }
    func addField(field: FieldToAdd, _ completion: @escaping (Int)-> Void, error: @escaping (String)-> Void) {
        print(field.getFieldToAddDictionary())
        self.post(endpoint: "\(Constants.Network.EndPoints.GetFields)/\(DataManager.shared.getUserId())/", serverType: .kant, parameters: field.getFieldToAddDictionary(),  completion: { (json) in
            print(json)
            let id = json["field_id"].intValue
            completion(id)
        }, error: error){ (jsonValue) in
        }
    }
    func deleteField(field_id: Int,_ completion: @escaping (String)-> Void, error: @escaping (String)-> Void) {
        self.delete(endpoint: "\(Constants.Network.EndPoints.GetFields)/\(field_id)", serverType: .kant, completion: { (success) in
            let message = success["success"].stringValue
            completion(message)
        }, error: error){ (jsonValue) in
        }
        
    }
    func updateField(field_id: Int, parameters: [String: Any], _ completion: @escaping (String)-> Void, error: @escaping (String)-> Void) {
        print(parameters)
        self.patch(endpoint: "\(Constants.Network.EndPoints.GetFields)/\(field_id)", serverType: .kant, parameters: parameters, completion: { (json) in
            let message = json["success"].stringValue
            completion(message)
        }, error: error){ (jsonValue) in
        }
    }
    func updateExpenses(parameters: [String: Any], _ completion: @escaping (String)-> Void, error: @escaping (String)-> Void) {
        print(parameters)
        self.patch(endpoint: "\(Constants.Network.EndPoints.Expenses)", serverType: .kant, parameters: parameters, completion: { (json) in
            let message = json["success"].stringValue
            completion(message)
        }, error: error){ (jsonValue) in
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
    func getCurrecncies(_ completion: @escaping ([Currency])-> Void, error: @escaping (String)-> Void) {
        
        let data = UserDefaults.standard.data(forKey: "currency")

        if UserDefaults.standard.bool(forKey: "currencyCached") {
            completion(Currencies(json: JSON(json: data)).array)
            return
        }

        
        self.get(endpoint: "\(Constants.Network.EndPoints.Currencies)", serverType: .kant, completion: { (json) in
            completion(Currencies(json: json).array)
        }, error: { (err) in
            if err.contains("Нет подключения к интернету") || err.contains("Интернет байланышы жок"){
                completion(Currencies(json: JSON(json: data)).array)
            }
            error(err)
        }) { (jsonValue) in
            UserDefaults.standard.set(jsonValue, forKey: "currency")
            UserDefaults.standard.set(true, forKey: "currencyCached")
        }
    }
    func getBeetPoints(_ completion: @escaping (BeetPoints)-> Void, error: @escaping (String)-> Void) {
        self.get(endpoint: "\(Constants.Network.EndPoints.BeetPoint)", serverType: .kant, completion: { (json) in
            completion(BeetPoints(json: json))
        }, error: error){ (jsonValue) in
        }
    }
    func updatePassword(changePassword: ChangePassword, _ completion: @escaping ()-> Void, error: @escaping (String)-> Void) {
        self.put(endpoint: "\(Constants.Network.EndPoints.ChangePassword)/\(DataManager.shared.getUserId())/", serverType: .kant, parameters: changePassword.getDictionary(),  completion: { (json) in
            print(json)
            completion()
        }, error: error){ (jsonValue) in
        }
    }
    
    func registerFirebaseToken(parameters: [String: String], _ completion: @escaping ()-> Void, error: @escaping (String)-> Void) {
        self.patch(endpoint: "\(Constants.Network.EndPoints.RegisterToken)/\(DataManager.shared.getUserId())/", serverType: .kant, parameters: parameters, completion: { (json) in completion()
        }, error: error){ (jsonValue) in
        }
    }
    
    func clearCache() {
        let cache = UserDefaults.standard
        cache.set(false, forKey: "weatherCached")
        cache.set(false, forKey: "currencyCached")
        cache.set(false, forKey: "suppliersCached")
        cache.set(false, forKey: "servicesCached")
        cache.set(false, forKey: "sugarJomCached")
        cache.set(false, forKey: "expensesCached")
        cache.set(false, forKey: "localCached")
        cache.set(false, forKey: "rossaharCached")
        cache.set(false, forKey: "fieldsCached")
    }
}

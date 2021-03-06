//
//  HTTPRequestManager.swift
//  CafeService
//
//  Created by ITLabAdmin on 7/19/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON
import SystemConfiguration

enum ServerType {
    case whether
    case kant
}

class HTTPRequestManager {
    
    typealias SuccessHandler = (JSON) -> Void
    typealias FailureHandler = (String)-> Void
    typealias Parameter = [String: Any]?
    typealias JSONValue = (Data) -> Void
    
    private func request(method: HTTPMethod, endpoint: String, serverType: ServerType, parameters: Parameter, header: String, completion: @escaping SuccessHandler, error: @escaping FailureHandler, json: @escaping JSONValue) {
        if !isConnectedToNetwork() {
            error(Constants.Network.ErrorMessage.NO_INTERNET_CONNECTION!)
            return
        }
        
        var apiUrl = ""
        var tempParam = parameters
        switch serverType {
        case .whether:
            apiUrl = "http://api.openweathermap.org/data/2.5/forecast?lat=42.874722&lon=74.612222&APPID=079587841f01c6b277a82c1c7788a6c3"
            tempParam = nil
        case .kant:
            apiUrl = ApiAddressKant(endpoint: endpoint).getURLString()
        }
        apiUrl.remove(at: apiUrl.index(before: apiUrl.endIndex))
        print(apiUrl)
        var head: HTTPHeaders = [:]
        if let token = UserDefaults.standard.string(forKey: "token") {
            head = ["Authorization" : "Bearer \(token)"]
        }
        if header != "" {
            head.updateValue(header, forKey: "language")
        }
        
        Alamofire.request(apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, method: method, parameters: tempParam, encoding: JSONEncoding.default , headers: head).responseJSON { (response:DataResponse<Any>) in
            //            print(response.description)
            guard response.response != nil else {
                error(Constants.Network.ErrorMessage.UNABLE_LOAD_DATA!)
                return
            }
            //value    String    "PHPSESSID=o549sv96q773fu97jmrc6sa420"
            guard let statusCode = response.response?.statusCode else {
                error(Constants.Network.ErrorMessage.NO_HTTP_STATUS_CODE)
                return
            }
            print("\(statusCode) - \(apiUrl)")
            
            let a = JSON(data: response.data!)
            
            switch(statusCode) {
            case HttpStatusCode.unauthorized.statusCode:
                error(Constants.Network.ErrorMessage.UNAUTHORIZED!)
                break
            case HttpStatusCode.ok.statusCode,
                 HttpStatusCode.accepted.statusCode,
                 HttpStatusCode.created.statusCode:
                
                let jsonValue = JSON(data: response.data!)
                
                if !jsonValue["error"].stringValue.isEmpty{
                    error(jsonValue["error"].stringValue)
                } else {
                    //print(response.response?.allHeaderFields.description)
                    completion(jsonValue)
                    json(response.data!)
                }
                
                break
            default:
                
                let json = JSON(data: response.data!)
                if !json.isEmpty {
                    let message = json["error"].stringValue
                    error(message)
                    //print(message)
                } else {
                    if let data = response.data {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        error(json!)
                    } else {
                        error("")
                    }
                }
            }
        }
    }
    
    
    internal func post(endpoint: String, serverType: ServerType, parameters: Parameter, header: String = "", completion: @escaping SuccessHandler, error: @escaping FailureHandler, json: @escaping JSONValue) {
        request(method: .post, endpoint: endpoint, serverType: serverType, parameters: parameters, header: header, completion: completion, error: error, json: json)
    }
    internal func put(endpoint: String, serverType: ServerType, parameters: Parameter, header: String = "", completion: @escaping SuccessHandler, error: @escaping FailureHandler, json: @escaping JSONValue) {
        request(method: .put, endpoint: endpoint, serverType: serverType, parameters: parameters, header: header, completion: completion, error: error, json: json)
    }
    internal func get(endpoint: String, serverType: ServerType, header: String = "", completion: @escaping SuccessHandler, error: @escaping FailureHandler, json: @escaping JSONValue) {
        request(method: .get, endpoint: endpoint, serverType: serverType, parameters: nil, header: header, completion: completion, error: error, json: json)
    }
    internal func get(endpoint: String, serverType: ServerType, parameters: Parameter, completion: @escaping SuccessHandler, error: @escaping FailureHandler, json: @escaping JSONValue) {
        let header = ""
        request(method: .get, endpoint: endpoint, serverType: serverType, parameters: parameters, header: header, completion: completion, error: error, json: json)
    }
    internal func delete(endpoint: String, serverType: ServerType, completion: @escaping SuccessHandler, error: @escaping FailureHandler, json: @escaping JSONValue) {
        let header = ""
        request(method: .delete, endpoint: endpoint, serverType: serverType, parameters: nil, header: header, completion: completion, error: error, json: json)
    }
    internal func patch(endpoint: String, serverType: ServerType, parameters: Parameter, completion: @escaping SuccessHandler, error: @escaping FailureHandler, json: @escaping JSONValue) {
        let header = ""
        request(method: .patch, endpoint: endpoint, serverType: serverType, parameters: parameters, header: header, completion: completion, error: error, json: json)
    }
    
    
    // MARK: - Internet Connectivity
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}


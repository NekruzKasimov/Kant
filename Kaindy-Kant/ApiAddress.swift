//
//  ApiAddress.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//


import Foundation
import Alamofire

class ApiAddressKant: ApiAddress {

    init(endpoint: String) {
        super.init()
        self.domain = "139.59.22.220:8000"
        self.endpoint = endpoint
        self.param = getStringFrom(parameter: nil)
    }

    convenience init(endpoint: String, param: [String: Any]?) {
        self.init(endpoint: endpoint)
        self.param = getStringFrom(parameter: param as! [String: String]?)
    }
}

class ApiAddress {
    var scheme = "http"
    var domain = ""
    var endpoint: String = ""
    var param: String = ""
    init() {
    }
    func getURLString() -> String {
        return "\(scheme)://\(domain)/\(endpoint)/\(param)"
    }
    
    func getURL() -> URL? {
        return URL(string: getURLString())
    }
    
    func getStringFrom(parameter: [String:String]?) -> String {
        var parameterString = ""
        if parameter == nil {
            return parameterString
        }
        //var count = 0
        for (offset: index, element: (key: key, value: value)) in parameter!.enumerated() {
            if index == 0 {
                parameterString += "?"
            }
            else {
                parameterString += "&"
            }
            parameterString += "\(key)=\(value)"
        }
        return parameterString
    }
}


//
//  FinancialOffices.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

class FinancialOffice {
    var id: Int
    var name: String
    var logo: String
    
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        logo = json["logo"].stringValue
    }
    
    init(){
        id = 0
        name = ""
        logo = ""
    }
    
}

class FinancialOffices: NSObject {
    var array: Array = Array<FinancialOffice>()
    init(json:JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = FinancialOffice(json:json)
            array.append(tempObject)
        }
    }
}

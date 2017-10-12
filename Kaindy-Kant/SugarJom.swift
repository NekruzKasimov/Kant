//
//  Sugar-Jom.swift
//  Kaindy-Kant
//
//  Created by ITLabAdmin on 10/11/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SugarJom {
    
    var sugar: Sugars
    var jom: Joms
    
    init(json: JSON) {
        sugar = Sugars(json: json["sugar"])
        jom = Joms(json: json["jom"])
        
    }
}

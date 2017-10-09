//
//  Rossahar.swift
//  Kaindy-Kant
//
//  Created by ITLabAdmin on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Rossahar {
    var result: Result
    
    init(json: JSON) {
        result = Result(json: json["result"])
        
    }
    func getNewRossahar() -> [String: Any] {
        return ["result": result]
    }
}

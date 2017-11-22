//
//  PhoneNumbers.swift
//  Kaindy-Kant
//
//  Created by Niko on 11/22/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class PhoneNumbers {
    static func format(input: String, _ deleteLastChar: Bool) -> String {
        var str = ""
        
        if input.count == 0 {
            return str
        }
        
        var regex: NSRegularExpression?
        do {
            regex =  try NSRegularExpression(pattern: "[\\s-\\(\\)]" , options: .caseInsensitive)
            
            str = regex!.stringByReplacingMatches(in: input, options: .init(rawValue: 0), range: NSRange(location: 0, length: input.count), withTemplate: "")
            
            if str.count > 9 {
                let end = str.index(str.startIndex, offsetBy: 9)
                str = str.substring(to: end)
            }
            if deleteLastChar {
                let end = str.index(str.endIndex, offsetBy: -1)
                str = str.substring(to: end)
            }
            if str.count < 3 {
                str = str.replacingOccurrences(of: "(\\d+)", with: "($1", options: .regularExpression, range:  str.startIndex..<str.endIndex)
            }
            else if str.count == 3 {
                str = str.replacingOccurrences(of: "(\\d{3})", with: "($1) ", options: .regularExpression, range:  str.startIndex..<str.endIndex)
            }
            else if str.count == 4 {
                str = str.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "($1) $2", options: .regularExpression, range:  str.startIndex..<str.endIndex)
            }
            else if str.count == 5 {
                str = str.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "($1) $2-", options: .regularExpression, range:  str.startIndex..<str.endIndex)
            }
            else if str.count == 6 {
                str = str.replacingOccurrences(of: "(\\d{3})(\\d{2})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range:  str.startIndex..<str.endIndex)
            }
            else if str.count == 7 {
                str = str.replacingOccurrences(of: "(\\d{3})(\\d{2})(\\d+)", with: "($1) $2-$3-", options: .regularExpression, range:  str.startIndex..<str.endIndex)
            }
            else if str.count == 8 {
                str = str.replacingOccurrences(of: "(\\d{3})(\\d{2})(\\d{2})(\\d+)", with: "($1) $2-$3-$4", options: .regularExpression, range:  str.startIndex..<str.endIndex)
            }
            else {
                str = str.replacingOccurrences(of: "(\\d{3})(\\d{2})(\\d{2})(\\d{2})", with: "($1) $2-$3-$4", options: .regularExpression, range:  str.startIndex..<str.endIndex)
            }
            print("str = \(str)")
            return str
            
        }
        catch _  {
            print("error in formatting phone number string")
        }
        return str
    }
    
    static func isValid(number totalString: String, in range: NSRange) -> Bool {
        let firstChar = totalString.first
        if (range.location == 0)
        {
            if(firstChar == "5" || firstChar == "7") {
                return true
            }
        }
        else if(range.location == 1)
        {
            let secondChar = totalString[totalString.index(totalString.startIndex, offsetBy: 1)]
            if((firstChar == "5" && secondChar == "5") ||
                (firstChar == "7" && (secondChar == "7"
                    || secondChar == "0")))
            {
                return true
            }
        }
        else
        {
            return true
        }
        
        return false
        
    }
}

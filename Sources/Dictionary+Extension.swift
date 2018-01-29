//
//  Dictionary+Extension.swift
//  Perfect-QNSDK
//
//  Created by Fidetro on 24/01/2018.
//
import Foundation

extension Dictionary {
    var toString : String? {
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            guard var jsonString = String.init(data: jsonData, encoding: .utf8) else {
                return nil
            }
            jsonString = jsonString.replacingOccurrences(of: " ", with: "")
            jsonString = jsonString.replacingOccurrences(of: "\n", with: "")
            return jsonString
        }catch{
            
            return nil
        }
    }
}

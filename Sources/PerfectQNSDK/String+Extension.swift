//
//  String+Extension.swift
//  PetDayPackageDescription
//
//  Created by Fidetro on 03/01/2018.
//
import Foundation
import PerfectCrypto

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }
    
    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return map { String(format: format, $0) }.joined()
    }
}
extension String {
    
    func AES256Encryption( key: String) -> String? {
        guard let hashData = key.digest(.sha384) else { return nil }
        let hashKeyData:[UInt8] = hashData[0..<32].map {$0}
        let ivData:[UInt8] = hashData[32..<48].map {$0}
        let data:[UInt8] = self.utf8.map { $0 }
        
        guard let x = data.encrypt(.aes_256_cbc, key: hashKeyData, iv: ivData),
            let y = x.encode(.base64) else {
                return nil
        }
        return String(validatingUTF8: y)
    }
    
    func MD5() -> String? {
        guard let hashData = self.digest(.md5) else { return nil }
        let data = Data.init(bytes: hashData)
        
        return data.hexEncodedString()
    }
    
    func hmac_sha1( key: String) -> String? {
        guard let hashData = key.digest(.sha384) else { return nil }
        let hashKeyData:[UInt8] = hashData[0..<32].map {$0}
        let ivData:[UInt8] = hashData[32..<48].map {$0}
        let data:[UInt8] = self.utf8.map { $0 }
        
        guard let x = data.encrypt(.aes_256_cbc, key: hashKeyData, iv: ivData),
            let y = x.encode(.base64) else {
                return nil
        }
        return String(validatingUTF8: y)
    }
    
    func AES256Decryption( key: String) -> String? {
        guard let hashData = key.digest(.sha384) else { return nil }
        let hashKeyData:[UInt8] = hashData[0..<32].map {$0}
        let ivData:[UInt8] = hashData[32..<48].map {$0}
        
        
        guard let base64Data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else { return nil }
        
        let data = [UInt8](base64Data)
        
        guard let x = data.decrypt(.aes_256_cbc, key: hashKeyData, iv: ivData) else {
            return nil
        }
        return String(validatingUTF8: x)
    }
    
    
    func toDictionary() -> [String:Any]? {
        if let jsonData = self.data(using: .utf8) {
            do {
                if  let dict = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String:Any] {
                    return dict
                }
            } catch  {
                
            }
        }
        return nil
    }
}

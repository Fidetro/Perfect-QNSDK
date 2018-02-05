//
//  QNAuth.swift
//  Perfect-QNSDKPackageDescription
//
//  Created by Fidetro on 28/01/2018.
//

import PerfectCrypto
import Foundation

public class QNAuth: NSObject {
    
    private static var accessKey = "AccessKey"
    private static var secretKey = "SecretKey"
    public static func shared(accessKey:String,secretKey:String) {
        QNAuth.accessKey = accessKey
        QNAuth.secretKey = secretKey
        _ = PerfectCrypto.isInitialized
    }
    public static func token(putPolicy:[String:Any]) -> String?{
        guard let encodePolicy = encodedPutPolicy(putPolicy) else { return nil}
        guard let encodeSign = encodedSign(encodePolicy) else { return nil}
        
        let uploadToken = accessKey + ":" + encodeSign + ":" + encodePolicy
        return uploadToken
    }
    private static func encodedPutPolicy(_ putPolicy:[String:Any]) -> String? {
        guard let putPolicyStr = putPolicy.toString else { return nil}
        
        guard let base64Byte = putPolicyStr.encode(.base64),
            let encodedPutPolicy = String(validatingUTF8: base64Byte) else { return nil}
        return encodedPutPolicy
    }
    private static func encodedSign(_ encodedPutPolicy:String) -> String? {
        guard let signByte = encodedPutPolicy.sign(.sha1, key: HMACKey(secretKey))?.encode(.base64),
            let sign = String(validatingUTF8:signByte) else { return nil}
        return sign
    }
    
}


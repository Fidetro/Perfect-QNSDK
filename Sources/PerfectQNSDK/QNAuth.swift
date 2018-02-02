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
        guard let sign = sign(encodePolicy) else { return nil}
        guard let encodeSign = encodedSign(sign) else { return nil}
        
        let uploadToken = accessKey + ":" + encodeSign + ":" + encodePolicy
        return uploadToken
    }
    private static func encodedPutPolicy(_ putPolicy:[String:Any]) -> String? {
        guard let putPolicyStr = putPolicy.toString else { return nil}
        
        guard let base64Byte = putPolicyStr.encode(.base64url),
            let encodedPutPolicy = String(validatingUTF8: base64Byte) else { return nil}
        return encodedPutPolicy
    }
    private static func sign(_ encodedPutPolicy:String) -> String? {
        guard let signByte = encodedPutPolicy.sign(.sha1, key: HMACKey(secretKey))?.encode(.hex),
            let sign = String(validatingUTF8:signByte) else { return nil}
        return sign
    }
    private static func encodedSign(_ sign:String) -> String? {
        guard let encodedSignByte = sign.encode(.base64url),
            let encodedSign = String(validatingUTF8: encodedSignByte) else { return nil}
        return encodedSign
    }
}

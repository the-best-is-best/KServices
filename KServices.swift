//
//  KServices.swift
//  Pods
//
//  Created by Michelle Raouf on 17/09/2024.
//

public class KServices {
    
    enum KeychainError: Error {
        case duplicateEntity
        case unknown(OSStatus)
    }
    
    public  static func  save(
        service: String,
        account: String,
        data: Data
    ) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: data  as AnyObject
        ]
         
       let status = SecItemAdd(query as CFDictionary, nil)
        
        
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateEntity
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
    }
    
    public  static func  get(
        service: String,
        account: String
    ) throws ->  String? {
       
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        
        guard let data = result as? Data else {
            return nil
        }
        let dataString = String(data: data, encoding: .utf8)
        return dataString
   
        
    }
}

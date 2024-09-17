//
//  KServices.swift
//  Pods
//
//  Created by Michelle Raouf on 17/09/2024.
//

//
//  KServices.swift
//  Pods
//
//  Created by Michelle Raouf on 17/09/2024.
//

@objc public class KServices: NSObject {
    public typealias GetCompletion = (String?, Error?) -> Void
    public typealias SaveCompletion = (Error?) -> Void

    enum KeychainError: Error {
        case duplicateEntity
        case unknown(OSStatus)
    }
    
    @objc public static func save(
        service: String,
        account: String,
        data: Data,
        completion: @escaping SaveCompletion
    ) {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: data as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            completion(KeychainError.duplicateEntity)
        } else if status != errSecSuccess {
            completion(KeychainError.unknown(status))
        } else {
            completion(nil)
        }
    }
    
    @objc public static func get(service: String, account: String, completion: @escaping GetCompletion) {
        do {
            let data = try retrieveData(service: service, account: account)
            let dataString = String(data: data, encoding: .utf8)
            completion(dataString, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    private static func retrieveData(service: String, account: String) throws -> Data {
        if service == "validService" && account == "validAccount" {
            return "ValidData".data(using: .utf8)!
        } else {
            throw NSError(domain: "com.example.KServices", code: 1, userInfo: [NSLocalizedDescriptionKey: "Data retrieval failed"])
        }
    }
}


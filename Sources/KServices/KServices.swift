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

import Foundation

@objc public class KServices: NSObject {
    public typealias GetCompletion = (String?, Error?) -> Void
    public typealias GetDataCompletion = (Data?, Error?) -> Void

    public typealias SaveCompletion = (Error?) -> Void

    enum KeychainError: Error {
//        case duplicateEntity
        case unknown(OSStatus)
         case noData
        case unexpectedData
    }
    
    @objc public static func save(
           service: String,
           account: String,
           data: String,  // Now passing data as a String
           completion: @escaping SaveCompletion
       ) {
           // Convert the String to Data using utf8 encoding
           guard let dataAsData = data.data(using: .utf8) else {
               completion(KeychainError.unknown(-1))  // Handle conversion failure
               return
           }
           
           let query: [String: AnyObject] = [
               kSecClass as String: kSecClassGenericPassword,
               kSecAttrService as String: service as AnyObject,
               kSecAttrAccount as String: account as AnyObject
           ]
           
           let status = SecItemAdd(query as CFDictionary, nil)
           
           if status == errSecDuplicateItem {
               // If the item already exists, update the existing item
               let attributesToUpdate: [String: AnyObject] = [
                   kSecValueData as String: dataAsData as AnyObject
               ]
               
               let updateStatus = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
               
               if updateStatus != errSecSuccess {
                   completion(KeychainError.unknown(updateStatus))
               } else {
                   completion(nil)  // Successfully updated
               }
           } else if status != errSecSuccess {
               completion(KeychainError.unknown(status))
           } else {
               completion(nil)  // Successfully added
           }
       }
    
    @objc public static func saveDataType(
           service: String,
           account: String,
           data: Data,  // Now passing data as a String
           completion: @escaping SaveCompletion
       ) {
           // Convert the String to Data using utf8 encoding
         
           
           let query: [String: AnyObject] = [
               kSecClass as String: kSecClassGenericPassword,
               kSecAttrService as String: service as AnyObject,
               kSecAttrAccount as String: account as AnyObject
           ]
           
           let status = SecItemAdd(query as CFDictionary, nil)
           
           if status == errSecDuplicateItem {
               // If the item already exists, update the existing item
               let attributesToUpdate: [String: AnyObject] = [
                   kSecValueData as String: data as AnyObject
               ]
               
               let updateStatus = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
               
               if updateStatus != errSecSuccess {
                   completion(KeychainError.unknown(updateStatus))
               } else {
                   completion(nil)  // Successfully updated
               }
           } else if status != errSecSuccess {
               completion(KeychainError.unknown(status))
           } else {
               completion(nil)  // Successfully added
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
    
    @objc public static func getDataType(service: String, account: String, completion: @escaping GetDataCompletion) {
        do {
            let data = try retrieveData(service: service, account: account)
            completion(data, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    
    private static func retrieveData(service: String, account: String) throws -> Data {
          let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        switch status {
        case errSecSuccess:
            guard let data = item as? Data else {
                throw KeychainError.unexpectedData
            }
            return data
            
        case errSecItemNotFound:
            throw KeychainError.noData
            
        default:
            throw KeychainError.unknown(status)
        }
    }
}

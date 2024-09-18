import Foundation

@objc public class KServices: NSObject {
    public typealias GetCompletion = (Data?, Error?) -> Void
    public typealias SaveCompletion = (Error?) -> Void

    enum KeychainError: Error {
        case duplicateEntity
        case unknown(OSStatus)
        case noData
        case unexpectedData
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

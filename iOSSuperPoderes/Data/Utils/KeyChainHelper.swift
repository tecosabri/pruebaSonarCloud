//
//  KeyChainHelper.swift
//  keychainProjectOpenBank
//
//  Created by Ismael Sabri Pérez on 24/7/23.
//

import Foundation

final class KeyChainHelper {
    
    // Singleton -> para llamar a las funciones de keychain, hay que utilizar el standar
    static let standard = KeyChainHelper()
    private init() {}
    
    func save(data: Data, service: String = "KEEPCODING", account: String) {
        // Petición a keychain para guardar datos
        let query = [
            kSecValueData: data, // los datos que queremos guardar (token)
            kSecClass: kSecClassGenericPassword, // Tipo de encriptación que queremos
            kSecAttrService: service, // Compartimento dentro de keychain donde queremos que se guarde la info
            kSecAttrAccount: account // Clave a la que se asocia la data (el user asociado al token)
        ] as CFDictionary
        
        // Guardar data en keychain.
        let status = SecItemAdd(query, nil)
        
        // Si se guarda con éxito entonces status success
        if status != errSecSuccess {
            print("Error: error adding item")
        }
        
        // Item added
        // Si se guarda y devuelve el error de que ya existe el elemento entonces:
        if status == errSecDuplicateItem {
            // Petición para guardar data
            let queryToUpdate = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecAttrAccount: account
            ] as CFDictionary
            // Petición con los atributos que queremos que se actualicen
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            // Actualizamos el data
            SecItemUpdate(queryToUpdate, attributesToUpdate)
        }
    }
    
    func read(service: String = "KEEPCODING", account: String) -> Data? {
        // Petición para leer un data asociado a un account
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true // Necesitamos que devuelva el valor que se ha leído
        ] as CFDictionary
        
        var result: AnyObject? // El resultado es anyobject porque en keychain se puede guardar cualquier cosa
        // LEES EN KEYCHAIN QUÉ HAY ASOCIADO A ACCOUNT Y LO METES EN RESULT
        SecItemCopyMatching(query, &result)
        
        return result as? Data // Devuelve result en el tipo que necesites
    }
    
    func delete(service: String = "KEEPCODING", account: String) {
        // Petición para borrar el data que está asociado al account
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
        ] as CFDictionary
        // Borras el data
        SecItemDelete(query)
        print("Deleted token")
    }
}




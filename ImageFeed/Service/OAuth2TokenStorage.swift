//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Muller Alexander on 17.08.2023.
//

import Foundation
import SwiftKeychainWrapper

final class OAuth2TokenStorage {
    
    private let keychainWrapper = KeychainWrapper.standard
    
    private enum Keys: String {
        case token
    }
    
    var token: String? {
        get {
            KeychainWrapper.standard.string(forKey: Keys.token.rawValue)
        }
        set {
            guard let newValue = newValue else {
                keychainWrapper.removeObject(forKey: Keys.token.rawValue)
                return
            }
            let isDone = keychainWrapper.set(newValue, forKey: Keys.token.rawValue)
            guard isDone else { return }
        }
    }
}

//
//  AuthManagers.swift
//  Spotify
//
//  Created by Chase on 2022/2/26.
//

import Foundation

final class AuthManager {
    static let share = AuthManager()
    
    private init() {
        
    }
    
    var isSignIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool? {
        return nil
    }
}

//
//  AuthManagers.swift
//  Spotify
//
//  Created by Chase on 2022/2/26.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    struct Constant {
        static let clientID = "6a5b83beb78241a1bdb509cf970b2112"
        static let clientSecet = "20ab4d983c7e41f6bff4d5fabccef8f3"
    }
    
    private init() {}
    
    public var signInURL: URL? {
        let scopes = "user-read-private"
        let redirectURI = "https://www.google.com"
        let base = "https://accounts.spotify.com/authorize"
        let string: String = "\(base)?response_type=code&client_id=\(Constant.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        return URL(string: string)
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
    
    public func exchangeCodeForToken(
        code: String,
        completion: @escaping ((Bool) -> Void)
    ) {
        //Get Token
    }
    
    public func refreshAccessToken() {
        
    }
    
    public func catchToken() {
        
    }
}

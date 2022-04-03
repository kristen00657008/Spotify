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
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
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
        guard let url = URL(string: Constant.tokenAPIURL) else {
            return
        }
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "https://www.google.com")
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constant.clientID+":"+Constant.clientSecet
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)",
                         forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data,
                  error == nil else {
                      completion(false)
                      return
                  }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("SUCCESS")
                completion(true)
            }
            catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        
        task.resume()
    }
    
    public func refreshAccessToken() {
        
    }
    
    public func catchToken() {
        
    }
}

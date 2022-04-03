//
//  AuthViewController.swift
//  Spotify
//
//  Created by Chase on 2022/2/26.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {

    private let webView: WKWebView = {
        let pres = WKWebpagePreferences()
        pres.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = pres
        let webView = WKWebView(frame: .zero, configuration: config)
        
        return webView
    }()
    
    public var completionHandler: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        view.addSubview(webView)
        guard let url = AuthManager.shared.signInURL else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    //when web jump will run this callback
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        }
        print(url.absoluteString)
        //Exchange the code for access token
        let component = URLComponents(string: url.absoluteString)
        guard let code = component?.queryItems?.first(where: {$0.name == "code"})?.value else {
            return
        }
        
        print("Code: \(code)")
        AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: true)
                self?.completionHandler?(success)
            }
        }
    }

}

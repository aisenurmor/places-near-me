//
//  ViewController.swift
//  places-near-me
//
//  Created by aisenur on 21.05.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let filePath = Bundle.main.path(forResource: "videoName", ofType: "gif")
        let gif = NSData(contentsOfFile: filePath!)

        webView = WKWebView(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.height))
        webView.navigationDelegate = self
        webView.isUserInteractionEnabled = false
        webView.contentMode = .scaleAspectFill
        
        webView.sizeToFit()
        
        webView.load(gif! as Data, mimeType: "image/gif", characterEncodingName: "utf-8", baseURL: NSURL() as URL)
        
        self.view.addSubview(webView)

        let filter = UIView()
        filter.frame = self.view.frame
        filter.backgroundColor = UIColor.black
        filter.alpha = 0.05
        self.view.addSubview(filter)

        let welcomeLabel = UILabel(frame: CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: 100))
        welcomeLabel.text = "WELCOME"
        welcomeLabel.textColor = UIColor.white
        welcomeLabel.font = UIFont.systemFont(ofSize: 50)
        welcomeLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(welcomeLabel)

        let loginBtn = UIButton(frame: CGRect(x: 40, y: 360, width: 240, height: 40))
        loginBtn.layer.borderColor = UIColor.white.cgColor
        loginBtn.layer.borderWidth = 2
        loginBtn.titleLabel!.font = UIFont.systemFont(ofSize: 24)
        loginBtn.tintColor = UIColor.white
        loginBtn.setTitle("Login", for: .normal)
        self.view.addSubview(loginBtn)

        let signUpBtn = UIButton(frame: CGRect(x: 40, y: 420, width: 240, height: 40))
        signUpBtn.layer.borderColor = UIColor.white.cgColor
        signUpBtn.layer.borderWidth = 2
        signUpBtn.titleLabel!.font = UIFont.systemFont(ofSize: 24)
        signUpBtn.tintColor = UIColor.white
        signUpBtn.setTitle("Sign Up", for: .normal)
        self.view.addSubview(signUpBtn)
    }
}

//
//  WebView.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 13/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import WebKit
import PromiseKit

extension Utiles {
    
    public func openUrlInWebViewURL(_ url: String, _ title: String = "", _ hideTabbar: Bool = false) {
        let webView = WebView()
        webView.initializeURL(title, url)
        webView.hidesBottomBarWhenPushed = hideTabbar
        utils.navigation()?.pushViewController(webView, animated: true)
    }
    
    public func openUrlInWebViewHTML(_ html: String, _ title: String = "", _ hideTabbar: Bool = false) {
        let webView = WebView()
        webView.initializeHTML(title, html)
        webView.hidesBottomBarWhenPushed = hideTabbar
        utils.navigation()?.pushViewController(webView, animated: true)
    }
    
}

class WebView: BaseController {
    
    // MARK: Type
    
    enum URLType {
        case url, htmlstring
    }
    fileprivate var urltype = URLType.url
    
    // MARK: public
    
    public var linkWebView = String()
    public var htmlkWebView = String()
    public var pageTitle = String()
    
    // MARK: private
    
    fileprivate let webView = WKWebView()
    fileprivate let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    fileprivate let visualEffectView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIBlurEffect(style: .light)
        return visualEffectView
    }()
    
    // MARK: override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: UI
        webView.navigationDelegate = self
        webView.uiDelegate = self
        self.view.backgroundColor = .white
        self.navigationItem.title = self.pageTitle
        
        // MARK: render
        
        renderWebView()
        renderVisual()
        renderActivity()
        
        // MARK: webview
        
        switch urltype {
            
        case .url:
            let url = URL(string: linkWebView)
            log.debug(url?.absoluteString ?? "failed to load url")
            if let unwarppedURL = url {
                let request = URLRequest(url: unwarppedURL)
                let session = URLSession.shared
                let task = session.dataTask(with: request) {_, _, error in
                    if error == nil {
                        DispatchQueue.main.async(execute: { [unowned self] in
                            self.webView.load(request)
                        })
                    } else {
                        print(error as Any)
                    }
                }
                task.resume()
            }
            
        case .htmlstring:
            DispatchQueue.main.async(execute: { [unowned self] in
                self.webView.loadHTMLString(self.htmlkWebView, baseURL: nil)
            })
        }
        
    }
    
    // MARK: initialize
    
    public func initializeURL(_ title: String, _ link: String) {
        urltype = .url
        linkWebView = link
        pageTitle = title
    }
    
    public func initializeHTML(_ title: String, _ html: String) {
        urltype = .htmlstring
        htmlkWebView = html
        pageTitle = title
    }
    
}

// MARK: render

extension WebView {
    
    fileprivate func renderWebView() {
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeArea.top)
            make.bottom.equalTo(self.view.safeArea.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
    }
    
    fileprivate func renderVisual() {
        self.view.addSubview(visualEffectView)
        visualEffectView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeArea.top)
            make.bottom.equalTo(self.view.safeArea.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
    }
    
    fileprivate func renderActivity() {
        self.activity.startAnimating()
        self.view.addSubview(activity)
        activity.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY).offset(-44)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
    }
    
}

// MARK: webview delegate

extension WebView: WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        let surl = request.url?.absoluteString ?? ""
        if surl.contains("flowTonesApp") {
            self.dismiss(animated: true, completion: nil)
           return false
        }
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        log.debug("load webview is finished")
        after(seconds: 0.5).done {
            UIView.animate(withDuration: 0.5, animations: {
                self.visualEffectView.alpha = 0.0
                self.activity.alpha = 0.0
            }, completion: { _ in
                self.activity.stopAnimating()
            })
        }
    }
    
}

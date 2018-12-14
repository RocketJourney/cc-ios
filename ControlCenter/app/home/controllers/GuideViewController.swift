//
//  GuideViewController.swift
//  ControlCenter
//
//  Created by Erik on 12/13/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit
import WebKit

class GuideViewController: UIViewController, WKUIDelegate, WKNavigationDelegate{
  
  let url: String = "https://assets.rocketjourney.com/control-center/assets/staff_guide/main_es.html"
  var webView: WKWebView!
  var activityIndicator: UIActivityIndicatorView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    
  }
  
  
  override func loadView() {
    let webConfiguration = WKWebViewConfiguration()
    webView = WKWebView(frame: .zero, configuration: webConfiguration)
    webView.uiDelegate = self
    webView.navigationDelegate = self
    view = webView
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.activityIndicator?.center = self.webView.center
  }
  
  private func setupView() -> Void {
    self.title = "GUIDE".localized
    self.webView.backgroundColor = UIColor(hex: 0xcccccc)
    self.webView.scrollView.backgroundColor = UIColor(hex: 0xcccccc)
    self.webView.isOpaque = false
    
    self.activityIndicator = UIActivityIndicatorView(style: .white)
    self.reloadData()
    
    
  }
  
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    self.hideActivityIndicator()
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    self.hideActivityIndicator()
  }
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    self.hideActivityIndicator()
    NSLog("URL ====> %@", navigation)
  }
  

  
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    if navigationAction.navigationType == .linkActivated  {
      if let url = navigationAction.request.url,
        let host = url.host, !host.hasPrefix("https://rckt.fit/"),
        UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url)
        NSLog(url.description)
        NSLog("Redirected to browser. No need to open it locally")
        decisionHandler(.cancel)
      } else {
        NSLog("Open it locally")
        decisionHandler(.allow)
      }
    } else {
      NSLog("not a user click")
      decisionHandler(.allow)
    }
  }
  
  
  
  
  private func showActivityIndicator() -> Void {
    self.activityIndicator!.startAnimating()
    self.activityIndicator!.isHidden = false
  }
  
  private func hideActivityIndicator() -> Void {
    self.activityIndicator!.stopAnimating()
    self.activityIndicator!.isHidden = true
  }
  
  
  func reloadData() -> Void{
    let myURL = URL(string: self.url)
    
    let myRequest = URLRequest(url: myURL!)
    webView.load(myRequest)
    
    self.webView.addSubview(self.activityIndicator!)
    
    
    self.showActivityIndicator()
  }
  
}

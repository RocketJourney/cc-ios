//
//  WebViewController.swift
//  ControlCenter
//
//  Created by Erik on 12/4/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController,  WKUIDelegate, WKNavigationDelegate{
  
  var webView: WKWebView!
  
  
  override func loadView() {
    let webConfiguration = WKWebViewConfiguration()
    webView = WKWebView(frame: .zero, configuration: webConfiguration)
    webView.uiDelegate = self
    webView.navigationDelegate = self
    view = webView
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    self.backCross()
  }
  
  
  func setupView() -> Void {
    self.view.backgroundColor = UIColor(hex: 0xcccccc)
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    self.navigationItem.hidesBackButton = false
    
    self.title = "TERMS_OF_SERVICE".localized
    self.webView.backgroundColor = UIColor(hex: 0xcccccc)
    let preferredLanguage = NSLocale.preferredLanguages[0]
    
    var myURL: URL?
    
    if preferredLanguage.contains("en"){
      myURL = Bundle.main.url(forResource: "terms", withExtension: "html")
    }else{
      myURL = Bundle.main.url(forResource: "terms-es", withExtension: "html")
    }
    let myRequest = URLRequest(url: myURL!)
    webView.load(myRequest)
  }
  
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    
  }
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    
  }
  
}

//
//  PreludeViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/15/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit
import Alamofire

class PreludeViewController: UIViewController {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var invitationConde: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    self.setupNotification()
    // Do any additional setup after loading the view.
    self.hideSpinner()
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  private func setupView() -> Void {
    self.view.backgroundColor = UIColor.rocketYellow()
    self.activityIndicator.startAnimating()
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.showIntroViewController()
      
    }
    
  }
  
  func showSpinner() -> Void {
    self.activityIndicator.isHidden = false
    self.activityIndicator.startAnimating()
  }
  
  func hideSpinner() -> Void {
    self.activityIndicator.isHidden = true
    self.activityIndicator.stopAnimating()
  }
  
  private func setupNotification() -> Void {
    let invitationCodeNotification = Notification.Name("invitationCodeNotification")
    NotificationCenter.default.addObserver(self, selector: #selector(validateCode(notification:)), name: invitationCodeNotification, object: nil)
    
    
    
    let introNotification = Notification.Name("showIntroViewController")
    NotificationCenter.default.addObserver(self, selector: #selector(self.showIntroViewController), name: introNotification, object: nil)
    
  }
  
  
  @objc func validateCode(notification: Notification) -> Void {
    self.showSpinner()
    if let userInfo = notification.userInfo {
      if let code = userInfo["invitationCode"] as? String {
        self.invitationConde = code
        if self.isNetworkReachable(){
          User.validateInvitation(code, completion: {
            self.hideSpinner()
            self.performSegue(withIdentifier: "kCheckEmailSegue", sender: nil)
            
          }) { (error) in
            
            
            self.hideSpinner()
            NSLog(error.localizedDescription)
            if let error = error as? NSError {
              if error.code == 422 {
                let alertController = UIAlertController(title: "LINK_DOES_NOT_EXIST".localized, message: "LINK_DOES_NOT_EXIST".localized, preferredStyle: UIAlertController.Style.alert)
                
                let alertAction = UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.default, handler: { (handler) in
                  self.performSegue(withIdentifier: "kIntroSegue", sender: nil)
                
                })
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
              }else if error.code == 404 {
                let alertController = UIAlertController(title: "LINK_EXPIRED".localized, message: "LINK_EXPIRED".localized, preferredStyle: UIAlertController.Style.alert)
                let alertAction = UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.default, handler: { (handler) in
                  self.performSegue(withIdentifier: "kIntroSegue", sender: nil)
                  
                })
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
              }else {
                let alertController = UIAlertController(title: "INTERNAL_SERVER_ERROR_TITLE".localized, message: "INTERNAL_SERVER_ERROR_MESSAGE".localized, preferredStyle: UIAlertController.Style.alert)
                let alertAction = UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.default, handler: { (handler) in
                  self.performSegue(withIdentifier: "kIntroSegue", sender: nil)
                  
                })
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
              }
            }
          }
        }else{
          self.hideSpinner()
          self.noInternetAlert()
        }
        
      }else{
        self.hideSpinner()
      }
    }else{
      self.hideSpinner()
    }
  }
  
  
  @objc func showIntroViewController() -> Void {
    if User.current != nil && User.current?.token != nil && User.current?.currentClub != nil {
      self.performSegue(withIdentifier: "kPreludeHomeSegue", sender: nil)
    }else{
      self.performSegue(withIdentifier: "kIntroSegue", sender: nil)
    }
  }
  
}

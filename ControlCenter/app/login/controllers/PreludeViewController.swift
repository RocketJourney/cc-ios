//
//  PreludeViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/15/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class PreludeViewController: UIViewController {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    self.setupNotification()
    // Do any additional setup after loading the view.
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  private func setupView() -> Void {
    self.view.backgroundColor = UIColor.rocketYellow()
    self.activityIndicator.startAnimating()
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.performSegue(withIdentifier: "kIntroSegue", sender: nil)
    }
    
  }
  
  private func setupNotification() -> Void {
    let invitationCodeNotification = Notification.Name("invitationCodeNotification")
    NotificationCenter.default.addObserver(self, selector: #selector(validateCode(notification:)), name: invitationCodeNotification, object: nil)
    NotificationCenter.default.post(name: Notification.Name("showPreludeViewController"), object: nil)
  }
  
  
  @objc func validateCode(notification: Notification) -> Void {
    
    
  }
  
}

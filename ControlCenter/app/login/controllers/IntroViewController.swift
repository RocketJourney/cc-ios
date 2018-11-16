//
//  IntroViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/8/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
  
  @IBOutlet weak var alReadyAccountLabel: UILabel!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var dontHaveAccountLabel: UILabel!
  @IBOutlet weak var createAccountLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()    
    
    // Do any additional setup after loading the view.
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.setupNotification()
  }
  
  private func setupView() -> Void {
    self.view.backgroundColor = UIColor(hex: 0x1a1a1a)
    
    self.alReadyAccountLabel.font = UIFont.montserratRegular(18)
    self.alReadyAccountLabel.textColor = UIColor(hex: 0xb3b3b3)
    self.alReadyAccountLabel.text = "ALREADY_HAVE_ACCOUNT".localized
    
    self.loginButton.setTitle("LOGIN".localized, for: .normal)
    self.loginButton.setTitleColor(UIColor(hex: 0x1a1a1a), for: .normal)
    self.loginButton.backgroundColor = UIColor(hex: 0xffcc00)
    self.loginButton.layer.cornerRadius = 12
    self.loginButton.titleLabel?.font = UIFont.montserratBold(20)
    self.loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    
    self.dontHaveAccountLabel.font = UIFont.montserratRegular(16)
    self.dontHaveAccountLabel.textColor = UIColor(hex: 0xb3b3b3)
    self.dontHaveAccountLabel.text = "DONT_HAVE_ACCOUNT".localized
    
    self.createAccountLabel.font = UIFont.montserratRegular(16)
    self.createAccountLabel.textColor = UIColor(hex: 0xeaeaea)
    self.createAccountLabel.text = "CREATE_ACCOUNT_TEXT".localized
    
  }
  
  
  @objc func setupNotification() -> Void {
    let showPreludeNotification = Notification.Name("showPreludeViewController")
    NotificationCenter.default.addObserver(self, selector: #selector(self.showPreludeViewController), name: showPreludeNotification, object: nil)
    
    
    let showPreludeNotification2 = Notification.Name("showPreludeLoginViewController")
    NotificationCenter.default.addObserver(self, selector: #selector(self.showPreludeViewController), name: showPreludeNotification2, object: nil)
  }
  
  
  @objc func showPreludeViewController() -> Void {
    self.dismissView()
  }
  
  
  
  
  @objc func loginAction() -> Void {
    performSegue(withIdentifier: "kLoginSegue", sender: nil)
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}

//
//  LoginViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/8/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  
  weak var email: UITextField?
  weak var password: UITextField?
  weak var loginButton: UIButton?
  var activityIndicator: UIActivityIndicatorView?
  var backButton: UIBarButtonItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    self.setupNotification()
    
    // Do any additional setup after loading the view.
  }
    
  
  @objc func setupView() -> Void {
    self.view.backgroundColor = UIColor(hex: 0x313131)
    self.backCross()
    self.title = "LOGIN".localized
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.backgroundColor = UIColor.clear
    self.tableView.tableFooterView = UIView()
    self.tableView.separatorColor = UIColor(hex: 0x313131)
    
    self.backButton = UIBarButtonItem(image: UIImage(named:"cross-image"), style: .plain, target: self, action: #selector(self.popViewController))
    self.navigationItem.leftBarButtonItem = self.backButton
    self.navigationItem.rightBarButtonItem?.tintColor = UIColor.rocketYellow()
  }
  
  
  @objc func popViewController() -> Void {
    self.dismissView()
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 2
    default:
      return 1
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.selectionStyle = .none
    switch indexPath.section {
    case 0:
      cell.backgroundColor = UIColor.black
      if indexPath.row == 0{
        if let email = self.email {
          email.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 60)
          cell.addSubview(email)
        }else {
          let _email = UITextField()
          _email.keyboardAppearance = .dark
          _email.autocorrectionType = .no
          _email.leftViewMode = .always
          let xview = UIView()
          xview.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
          _email.leftView = xview
          //_email.accessibilityLabel = "SIGN_UP_FORM_EMAIL".localized
          _email.font = UIFont.montserratBold(19)
          _email.textColor = UIColor(hex: 0xeaeaea)
          _email.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60)
          cell.addSubview(_email)
          let string = NSMutableAttributedString(string: "SIGN_UP_FORM_EMAIL".localized)
          string.montserratBold(18, color: UIColor(hex: 0x2a2a2a)!)
          _email.attributedPlaceholder = string
          //_email.addTarget(self, action: #selector(SignUpFormController.validate), for: .editingChanged)
          _email.tintColor = UIColor.rocketYellow()
          
          _email.keyboardType = .emailAddress
          _email.autocapitalizationType = .none
          self.email = _email
        }
      }else if indexPath.row == 1 {
        if let password = self.password {
          password.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60)
          cell.addSubview(password)
        } else {
          let _password = UITextField()
          _password.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60)
          //_password.delegate = self
          _password.keyboardAppearance = .dark
          _password.tag = 1
          //_password.accessibilityLabel = "SIGN_UP_FORM_PASSWORD".localized
          let string = NSMutableAttributedString(string: "SIGN_UP_FORM_PASSWORD".localized)
          string.montserratBold(18, color: UIColor(hex: 0x2a2a2a)!)
          _password.attributedPlaceholder = string
          _password.textColor = UIColor(hex: 0xeaeaea)
          let xview = UIView()
          _password.font = UIFont.montserratBold(19)
          xview.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
          _password.leftViewMode = .always
          _password.leftView = xview
          _password.tintColor = UIColor.rocketYellow()
          _password.keyboardType = .default
          _password.isSecureTextEntry = true
          //_password.addTarget(self, action: #selector(SignUpFormController.validate), for: .editingChanged)
          //_password.isSecureTextEntry = showPassword
          self.password = _password
          cell.addSubview(_password)
        }
        let btn = UIButton()
        btn.setTitle("FORGOT".localized, for: UIControl.State())
        btn.addTarget(self, action: #selector(self.forgotPassword), for: .touchUpInside)
        btn.setTitleColor(UIColor.rocketYellow(), for: .normal)
        btn.titleLabel!.font = UIFont.montserratBold(12)
        btn.sizeToFit()
        btn.center = CGPoint(x: view.frame.size.width - (btn.frame.size.width / 2) - 12, y: 30)
        cell.addSubview(btn)
      }
    default:
      cell.backgroundColor = UIColor.clear
      
      if indexPath.row == 0{
        if let loginButton = self.loginButton {
          loginButton.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60)
          cell.addSubview(loginButton)
        }else {
          let _loginButton = UIButton()
          _loginButton.frame =  CGRect(x: 10, y: 0, width: view.frame.size.width - 20, height: 60)
          _loginButton.setTitle("LOGIN".localized, for: .normal)
          _loginButton.setTitleColor(UIColor(hex: 0x1a1a1a), for: .normal)
          _loginButton.backgroundColor = UIColor(hex: 0xffcc00)
          _loginButton.layer.cornerRadius = 12
          _loginButton.titleLabel?.font = UIFont.montserratBold(20)
          _loginButton.addTarget(self, action: #selector(self.validateData(_:)), for: .touchUpInside)
          
          let _activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
          _activityIndicator.color = UIColor.white
          cell.addSubview(_loginButton)
          cell.addSubview(_activityIndicator)
          _activityIndicator.center = _loginButton.center
          self.activityIndicator = _activityIndicator
          
          self.loginButton = _loginButton
          
          cell.addSubview(_loginButton)
        }
      }
      
    }
    return cell
  }
  
  
  @objc func validateData(_ sender: UIButton) -> Void {
    let button = sender
    button.backgroundColor = UIColor(hex: 0xffcc00, alpha: 0.1)//Choose your colour here
    button.isSelected = true
    if (self.email?.text?.count)! > 0 && (self.password?.text?.count)! > 0  {
      self.sendData()
    }else{
      button.backgroundColor = UIColor(hex: 0xffcc00, alpha: 1.0)//Choose your colour here
      button.isSelected = false
    }
    
  }
  
  private func sendData() -> Void {
    if self.isNetworkReachable(){
      self.showSpinner()
      User.login((self.email?.text)!, password: (self.password?.text)!, completion: {
        self.hideSpinner()
      }) { (error) in
        self.hideSpinner()
      }
    }else{
      self.noInternetAlert()
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 20
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = UIColor.clear
    return view
  }
  
  
  private func showSpinner() -> Void {
    self.activityIndicator?.isHidden = false
    self.activityIndicator?.startAnimating()
    self.backButton?.isEnabled = false
  }
  
  private func hideSpinner() -> Void {
    self.activityIndicator?.isHidden = true
    self.activityIndicator?.stopAnimating()
    self.backButton?.isEnabled = true
  }
  
  
  @objc func setupNotification() -> Void {
    let showPreludeNotification = Notification.Name("showPreludeViewController")
    NotificationCenter.default.addObserver(self, selector: #selector(self.showPreludeViewController), name: showPreludeNotification, object: nil)
    
  }
  
  @objc func showPreludeViewController() -> Void {
    NotificationCenter.default.post(name: Notification.Name("showPreludeLoginViewController"), object: nil)
    self.navigationController?.popToRootViewController(animated: true)
  }
  
  @objc func forgotPassword() -> Void {
    self.performSegue(withIdentifier: "kRecoverPasswordSegue", sender: nil)
  }
}

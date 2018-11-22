//
//  RecoverPasswordViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/9/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class RecoverPasswordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  
  weak var email: UITextField?
  weak var loginButton: UIButton?
  var backButton: UIBarButtonItem?
  var activityIndicator: UIActivityIndicatorView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    
  }
  
  
  func setupView() -> Void {
    self.backBtn()
    self.title = "RECOVER_PASSWORD".localized
    self.view.backgroundColor = UIColor(hex: 0x313131)
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.backgroundColor = UIColor.clear
    self.tableView.tableFooterView = UIView()
    self.tableView.separatorColor = UIColor(hex: 0x313131)
    
    
    self.backButton = UIBarButtonItem(image: UIImage(named:"left-arrow"), style: .plain, target: self, action: #selector(self.popViewController))
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
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.selectionStyle = .none
    switch indexPath.section {
    case 0:
      cell.backgroundColor = UIColor.black
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
        _email.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
        let string = NSMutableAttributedString(string: "SIGN_UP_FORM_EMAIL".localized)
        string.montserratBold(18, color: UIColor(hex: 0x2a2a2a)!)
        _email.attributedPlaceholder = string
        //_email.addTarget(self, action: #selector(SignUpFormController.validate), for: .editingChanged)
        _email.tintColor = UIColor.rocketYellow()
        
        _email.keyboardType = .emailAddress
        _email.autocapitalizationType = .none
        self.email = _email
      }
    default:
      cell.backgroundColor = UIColor.clear
      if let loginButton = self.loginButton {
        loginButton.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60)
        cell.addSubview(loginButton)
      }else {
        let _loginButton = UIButton()
        _loginButton.frame =  CGRect(x: 10, y: 0, width: view.frame.size.width - 20, height: 60)
        _loginButton.setTitle("RECOVER".localized, for: .normal)
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
        self.validateButton()
        
        cell.addSubview(_loginButton)
      }
    }
    return cell
  }
  
  @objc func validateData(_ sender: UIButton) -> Void {
    let button = sender
    button.backgroundColor = UIColor(hex: 0xffcc00, alpha: 0.1)//Choose your colour here
    button.isSelected = true
    
    if self.isValidEmail(emailString: (self.email?.text)!){
      self.sendData()
    }
  }
  
  private func sendData() -> Void {
    if self.isNetworkReachable() {
      self.hideSendButton()
      self.showSpinner()
      User.recoverPassword((self.email?.text)!, completion: {
        self.showSendButton()
        self.hideSpinner()
        self.recoverPasswordAlert(email: (self.email?.text)!)
      }) { (error) in
        self.hideSpinner()
        self.showSendButton()
        if let error = error as? NSError {
          if error.code == 500{
            self.internalServerError()
          }else{
            self.noRegisterEmailAlert(email: (self.email?.text)!)
          }
        }
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
  
  
  func isValidEmail(emailString:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: emailString)
  }
  
  @objc func textChanged(_ sender:UITextField) {
    self.validateButton()
  }
  
  
  func validateButton() -> Void {
    
      if validate() {
        self.loginButton?.isEnabled = true
        self.loginButton?.alpha = 1.0
      } else {
        self.loginButton?.isEnabled = false
        self.loginButton?.alpha = 0.3
      }
    
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
  
  
  private func showSendButton() -> Void {
    self.loginButton?.isHidden = false
    self.loginButton?.backgroundColor = UIColor(hex: 0xffcc00, alpha: 1.0)//Choose your colour here
    self.loginButton?.isSelected = false
    self.loginButton?.isEnabled = true
  }
  
  private func hideSendButton() -> Void {
    self.loginButton?.backgroundColor = UIColor(hex: 0xffcc00, alpha: 0.1)//Choose your colour here
    self.loginButton?.isSelected = true
    self.loginButton?.isHidden = true
    self.loginButton?.isEnabled = false
  }
  
  
  fileprivate func validate()->Bool {
    if self.email != nil {
      if let text = self.email?.text {
        return self.isValidEmail(emailString: text)
      }
    }
    return false
  }
  
  
  func noRegisterEmailAlert(email: String) -> Void {
    let alertController = UIAlertController(title: "EMAIL_SENT".localized, message: "EMAIL_SENT_TEXT".localized, preferredStyle: UIAlertController.Style.alert)
    
    let alertAction = UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.default, handler: { (handler) in
            
    })
    alertController.addAction(alertAction)
    self.present(alertController, animated: true, completion: nil)
  }
  
  
  func recoverPasswordAlert(email: String) -> Void {
    let alertController = UIAlertController(title: "EMAIL_NOT_REGISTERED".localized, message: "EMAIL_NOT_REGISTERED_TEXT".localized, preferredStyle: UIAlertController.Style.alert)
    
    let alertAction = UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.default, handler: { (handler) in
      self.dismissView()
      
    })
    alertController.addAction(alertAction)
    self.present(alertController, animated: true, completion: nil)
  }
}

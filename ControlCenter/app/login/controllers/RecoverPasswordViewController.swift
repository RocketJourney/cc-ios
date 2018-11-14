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
        
        self.loginButton = _loginButton
        
        cell.addSubview(_loginButton)
      }
    }
    return cell
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
}

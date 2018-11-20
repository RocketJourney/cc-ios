//
//  CreateAccountViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/9/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  weak var email: UITextField?
  weak var nextButton: UIButton?
  weak var showButton: UIButton?
  weak var name: UITextField?
  weak var lastName: UITextField?
  weak var password: UITextField?
  
  
  var showPassword = false
  var emailString: String?
  var invitationCode: String?
  var activityIndicator: UIActivityIndicatorView?
  
  var backButton: UIBarButtonItem?
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    // Do any additional setup after loading the view.
  }
  
  private func setupView() -> Void {
    self.view.backgroundColor = UIColor(hex: 0x313131)
    
    self.title = "CREATE_ACCOUNT".localized
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
    self.navigationController?.popViewController(animated: true)
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 4
    default:
      return 1
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
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.selectionStyle = .none
    
    switch indexPath.section {
    case 0:
      
      switch (indexPath.row) {
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
          let string = NSMutableAttributedString(string: "EMAIL".localized)
          string.montserratBold(18, color: UIColor(hex: 0x2a2a2a)!)
          _email.attributedPlaceholder = string
          //_email.addTarget(self, action: #selector(SignUpFormController.validate), for: .editingChanged)
          _email.tintColor = UIColor.rocketYellow()
          
          _email.keyboardType = .emailAddress
          _email.autocapitalizationType = .none
          self.email = _email
          self.email?.text = self.emailString
          self.email?.isEnabled = false
        }
      case 1:
        cell.backgroundColor = UIColor.black
        if let name = self.name {
          name.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 60)
          cell.addSubview(name)
        }else {
          let _name = UITextField()
          _name.keyboardAppearance = .dark
          _name.autocorrectionType = .no
          _name.leftViewMode = .always
          let xview = UIView()
          xview.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
          _name.leftView = xview
          //_email.accessibilityLabel = "SIGN_UP_FORM_EMAIL".localized
          _name.font = UIFont.montserratBold(19)
          _name.textColor = UIColor(hex: 0xeaeaea)
          _name.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60)
          cell.addSubview(_name)
          let string = NSMutableAttributedString(string: "NAME".localized)
          string.montserratBold(18, color: UIColor(hex: 0x2a2a2a)!)
          _name.attributedPlaceholder = string
          //_email.addTarget(self, action: #selector(SignUpFormController.validate), for: .editingChanged)
          _name.tintColor = UIColor.rocketYellow()
          
          _name.keyboardType = .namePhonePad
          _name.autocapitalizationType = .none
          self.name = _name
        }
      case 2:
        cell.backgroundColor = UIColor.black
        if let lastName = self.lastName {
          lastName.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 60)
          cell.addSubview(lastName)
        }else {
          let _lastName = UITextField()
          _lastName.keyboardAppearance = .dark
          _lastName.autocorrectionType = .no
          _lastName.leftViewMode = .always
          let xview = UIView()
          xview.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
          _lastName.leftView = xview
          //_email.accessibilityLabel = "SIGN_UP_FORM_EMAIL".localized
          _lastName.font = UIFont.montserratBold(19)
          _lastName.textColor = UIColor(hex: 0xeaeaea)
          _lastName.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60)
          cell.addSubview(_lastName)
          let string = NSMutableAttributedString(string: "LAST_NAME".localized)
          string.montserratBold(18, color: UIColor(hex: 0x2a2a2a)!)
          _lastName.attributedPlaceholder = string
          //_email.addTarget(self, action: #selector(SignUpFormController.validate), for: .editingChanged)
          _lastName.tintColor = UIColor.rocketYellow()
          
          _lastName.keyboardType = .namePhonePad
          _lastName.autocapitalizationType = .none
          self.lastName = _lastName
        }
      default:
        self.showPassword = true
        cell.backgroundColor = UIColor.black
        if let password = self.password {
          password.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 60)
          cell.addSubview(password)
        }else {
          let _password = UITextField()
          _password.keyboardAppearance = .dark
          _password.autocorrectionType = .no
          _password.leftViewMode = .always
          let xview = UIView()
          xview.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
          _password.leftView = xview
          //_email.accessibilityLabel = "SIGN_UP_FORM_EMAIL".localized
          _password.font = UIFont.montserratBold(19)
          _password.textColor = UIColor(hex: 0xeaeaea)
          _password.isSecureTextEntry = self.showPassword
          _password.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60)
          cell.addSubview(_password)
          let string = NSMutableAttributedString(string: "PASSWORD".localized)
          string.montserratBold(18, color: UIColor(hex: 0x2a2a2a)!)
          _password.attributedPlaceholder = string
          //_email.addTarget(self, action: #selector(SignUpFormController.validate), for: .editingChanged)
          _password.tintColor = UIColor.rocketYellow()
          
          _password.keyboardType = .default
          _password.autocapitalizationType = .none
          self.password = _password
        }
        let btn = UIButton()
        btn.setTitle("SHOW".localized, for: UIControl.State())
        btn.addTarget(self, action: #selector(self.toggleShowPassword(_:)), for: .touchUpInside)
        btn.setTitleColor(UIColor.rocketYellow(), for: .normal)
        btn.titleLabel!.font = UIFont.montserratBold(14)
        btn.sizeToFit()
        btn.center = CGPoint(x: view.frame.size.width - (btn.frame.size.width / 2) - 12, y: 30)
        cell.addSubview(btn)
      }
      
    default:
      cell.backgroundColor = UIColor.clear
      if let nextButton = self.nextButton {
        nextButton.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60)
        cell.addSubview(nextButton)
      }else {
        let _nextButton = UIButton()
        _nextButton.frame =  CGRect(x: 10, y: 0, width: view.frame.size.width - 20, height: 60)
        _nextButton.setTitle("CREATE_ACCOUNT".localized, for: .normal)
        _nextButton.setTitleColor(UIColor(hex: 0x1a1a1a), for: .normal)
        _nextButton.backgroundColor = UIColor(hex: 0xffcc00)
        _nextButton.layer.cornerRadius = 12
        _nextButton.titleLabel?.font = UIFont.montserratBold(20)
        _nextButton.addTarget(self, action: #selector(self.validateData(_:)), for: .touchUpInside)
        self.nextButton = _nextButton
        let _activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        _activityIndicator.color = UIColor.white
        cell.addSubview(_nextButton)
        cell.addSubview(_activityIndicator)
        _activityIndicator.center = _nextButton.center
        self.activityIndicator = _activityIndicator
      }
    }
    
    return cell
  }
  
  
  @objc func toggleShowPassword(_ sender: UIButton) {
    self.showPassword = !self.showPassword
    self.password?.isSecureTextEntry = self.showPassword
    if !showPassword {
      sender.setTitle("HIDE".localized, for: .normal)
    } else {
      sender.setTitle("SHOW".localized, for: .normal)
    }
  }
  
  
  @objc func validateData(_ sender: UIButton) -> Void {
    let button = sender
    button.backgroundColor = UIColor(hex: 0xffcc00, alpha: 0.1)//Choose your colour here
    button.isSelected = true
    if (self.emailString?.count)! > 0 && (self.name?.text?.count)! > 0 && (self.lastName?.text?.count)! > 0 && (self.password?.text?.count)! > 0 {
        self.sendData()
    }else{
      button.backgroundColor = UIColor(hex: 0xffcc00, alpha: 1.0)//Choose your colour here
      button.isSelected = false
    }
    
  }
  
  
  private func sendData() -> Void {
    if self.isNetworkReachable(){
      self.showSpinner()
      self.hideSendButton()
      User.signUp(self.emailString!, name: (self.name?.text)!, lastName: (self.lastName?.text)!, password: (self.password?.text)!, invitationCode: self.invitationCode!, completion: {
        self.hideSpinner()
        self.showSendButton()
        self.performSegue(withIdentifier: "kSignUpHomeSegue", sender: nil)
      }) { (error) in
        self.hideSpinner()
        self.showSendButton()
        if let error = error as? NSError {
          if error.code == 500{
            self.internalServerError()
          }
        }
      }
    }else{
      self.noInternetAlert()
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
    self.nextButton?.isHidden = false
    self.nextButton?.backgroundColor = UIColor(hex: 0xffcc00, alpha: 1.0)//Choose your colour here
    self.nextButton?.isSelected = false
  }
  
  private func hideSendButton() -> Void {
    self.nextButton?.backgroundColor = UIColor(hex: 0xffcc00, alpha: 0.1)//Choose your colour here
    self.nextButton?.isSelected = true
    self.nextButton?.isHidden = true
  }
  
}

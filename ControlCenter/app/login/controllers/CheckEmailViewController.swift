//
//  CheckEmailViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/8/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class CheckEmailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  
  @IBOutlet weak var tableView: UITableView!
  
  weak var email: UITextField?
  weak var nextButton: UIButton?
  var backButton: UIBarButtonItem?
  var invitationCode: String?
  var activityIndicator: UIActivityIndicatorView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupView()
    self.setupNotification()
    // Do any additional setup after loading the view.
  }
  
  
  private func setupView() -> Void {
    self.view.backgroundColor = UIColor(hex: 0x313131)
    self.setupbackCross()
    self.title = "CREATE_ACCOUNT".localized
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.backgroundColor = UIColor.clear
    self.tableView.tableFooterView = UIView()
    self.tableView.separatorColor = UIColor(hex: 0x313131)
  }
  
  func setupbackCross() {
    self.backButton = UIBarButtonItem(image: UIImage(named:"cross-image"), style: .plain, target: self, action: #selector(self.dismissViewController))
    self.navigationItem.leftBarButtonItem = backButton
    self.navigationItem.leftBarButtonItem?.tintColor = UIColor.rocketYellow()
  }
  
  
  @objc func dismissViewController() -> Void {
    self.dismissView()
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      NotificationCenter.default.post(name: NSNotification.Name("showIntroViewController"), object: nil)
    }
    
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
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
        _email.addTarget(self, action: #selector(self.validateForm), for: .editingChanged)
        _email.tintColor = UIColor.rocketYellow()
        
        _email.keyboardType = .emailAddress
        _email.autocapitalizationType = .none
        self.email = _email
      }
    default:
      cell.backgroundColor = UIColor.clear
      if let nextButton = self.nextButton {
        nextButton.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60)
        cell.addSubview(nextButton)
      }else {
        let _nextButton = UIButton()
        _nextButton.frame =  CGRect(x: 10, y: 0, width: view.frame.size.width - 20, height: 60)
        _nextButton.setTitle("NEXT".localized, for: .normal)
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
        self.validateForm()
      }
    }
    
    return cell
  }
  
  private func setupNotification() -> Void {
    let invitationCodeNotification = Notification.Name("dismissCheckEmailNotification")
    NotificationCenter.default.addObserver(self, selector: #selector(self.dismissViewController), name: invitationCodeNotification, object: nil)
  }
  
  
  @objc func validateData(_ sender: UIButton) -> Void {
    let button = sender
    button.backgroundColor = UIColor(hex: 0xffcc00, alpha: 1.0)//Choose your colour here
    button.isSelected = true    
    self.sendData()
  }
  
  
  private func showSpinner() -> Void {
    self.activityIndicator?.isHidden = false
    self.activityIndicator?.startAnimating()
  }
  
  
  private func hideSpinner() -> Void {
    self.activityIndicator?.isHidden = true
    self.activityIndicator?.stopAnimating()
  }
  
  
  
  private func sendData() -> Void {
    if self.isValidEmail(emailString: (self.email?.text)!){
      self.backButton?.isEnabled = false
      self.nextButton?.isEnabled = true
      self.nextButton?.isHidden = true
      self.showSpinner()
      
      if self.isNetworkReachable() {
        
        User.validateInvitationWhitEmail(self.invitationCode!, email: (self.email?.text)!, completion: { (statusCode) in
          self.backButton?.isEnabled = true
          self.nextButton?.isEnabled = true
          self.nextButton?.isHidden = false
          self.nextButton?.isSelected = false
          self.hideSpinner()
          
          if statusCode == 200 {
            self.performSegue(withIdentifier: "kCreateAccountSegue", sender: nil)
          }else if statusCode == 201 {
            let alertController = UIAlertController(title: "ACCOUNT_ALREADY_LINKED".localized, message: "ACCOUNT_ALREADY_LINKED_TEXT".localized, preferredStyle: UIAlertController.Style.alert)
            
            let alertAction = UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.default, handler: { (handler) in
              self.dismissViewController()
            })
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
          }
          
        }) { (error) in
          self.hideSpinner()
          self.backButton?.isEnabled = true
          self.nextButton?.isEnabled = true
          self.nextButton?.isHidden = false
          self.nextButton?.isSelected = false
          
          if let error = error as? NSError {
            if error.code == 500{
              self.internalServerError()
            }
          }
        }
        
        
        
      }else{
        self.hideSpinner()
        self.backButton?.isEnabled = true
        self.nextButton?.isEnabled = true
        self.nextButton?.isHidden = false
        self.nextButton?.isSelected = false
        self.noInternetAlert()
      }
    }
  }
  
  @objc private func validateForm() -> Void {
    if let _ = self.email {
      if isValidEmail(emailString: self.email!.text ?? "") {
        self.nextButton?.alpha = 1.0
        self.nextButton?.isEnabled = true
      } else {
        self.nextButton?.alpha = 0.1
        self.nextButton?.isEnabled = false
      }
    }
  }
  
  
  func isValidEmail(emailString:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: emailString)
  }
  
  

  
}

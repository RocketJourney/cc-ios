//
//  UIViewController+extension.swift
//  ControlCenter
//
//  Created by Erik on 11/6/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit
import Reachability

extension UIViewController {
  
  func backBtn() {
    let backBtn = UIBarButtonItem(image: UIImage(named:"left-arrow"), style: .plain, target: self, action: #selector(UIViewController.pushBack))
    self.navigationItem.leftBarButtonItem = backBtn
    self.navigationItem.rightBarButtonItem?.tintColor = UIColor.rocketYellow()
  }
  
  
  func backCross() {
    let backBtn = UIBarButtonItem(image: UIImage(named:"cross-image"), style: .plain, target: self, action: #selector(UIViewController.dismissView))
    self.navigationItem.leftBarButtonItem = backBtn
    self.navigationItem.leftBarButtonItem?.tintColor = UIColor.rocketYellow()
  }
  
  @objc func pushBack() {
    self.navigationController?.popViewController(animated: true)
  }
  
  func isNetworkReachable()->Bool{
    let reachability = Reachability()
    return reachability?.connection != Reachability.Connection.none
  }
  
  func noInternetAlert() {
    let alertController = UIAlertController(title: NSLocalizedString("NO_NETWORK_ERROR_TITLE", comment: "No network error title."), message: NSLocalizedString("NO_NETWORK_ERROR_MESSAGE", comment: "No network message"), preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
    alertController.addAction(alertAction)
    self.present(alertController, animated: true, completion: nil)
  }
  
  
  func internalServerError() {
    let alertController = UIAlertController(title: NSLocalizedString("INTERNAL_SERVER_ERROR_TITLE", comment: "internal server error"), message: NSLocalizedString("INTERNAL_SERVER_ERROR_MESSAGE", comment: "Internal server error message"), preferredStyle: .alert)
    let alertAction = UIAlertAction(title: NSLocalizedString("DISMISS", comment: "Dismiss"), style: .default, handler: nil)
    alertController.addAction(alertAction)
    present(alertController, animated: true, completion: nil)
  }
  
  
  @objc func dismissView() {
    self.dismiss(animated: true, completion: nil)
  }
  
}

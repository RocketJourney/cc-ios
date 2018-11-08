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
  
  func isNetworkReachable()->Bool{
    let reachability = Reachability()
    return reachability?.connection != Reachability.Connection.none
  }
    
  func noInternetAlert() {
    let alertController = UIAlertController(title: NSLocalizedString("NO_NETWORK_ERROR_TITLE", comment: "No network error title."), message: NSLocalizedString("NO_NETWORK_ERROR_MESSAGE", comment: "No network message"), preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(alertAction)
    present(alertController, animated: true, completion: nil)
  }
  
}

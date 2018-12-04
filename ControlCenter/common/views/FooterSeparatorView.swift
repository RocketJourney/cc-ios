//
//  FooterSeparatorView.swift
//  ControlCenter
//
//  Created by Erik on 12/3/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class FooterSeparatorView: UIView {

  @IBOutlet weak var separatorView: UIView!
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.backgroundColor = UIColor(hex: 0x4a4a4a)
    self.separatorView.backgroundColor = UIColor(hex: 0x5b5b5b)
  }
  

}

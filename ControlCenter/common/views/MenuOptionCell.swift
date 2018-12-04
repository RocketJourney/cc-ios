//
//  MenuOptionCell.swift
//  ControlCenter
//
//  Created by Erik on 12/3/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class MenuOptionCell: UITableViewCell {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var optionLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setupView()
  }
  
  
  func setupView() -> Void {
    self.contentView.backgroundColor = UIColor(hex: 0x4a4a4a)
    self.backgroundColor = UIColor(hex: 0x4a4a4a)
    self.containerView.backgroundColor = UIColor(hex: 0x4a4a4a)
    self.containerView.layer.cornerRadius = 8.5
    
    self.optionLabel.font = UIFont.montserratRegular(15)
    self.optionLabel.textColor = UIColor(hex: 0xe1e1e1, alpha: 0.87)
  }
  
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    super.setHighlighted(highlighted, animated: animated)
    
    if highlighted {
      self.contentView.backgroundColor = UIColor(hex: 0x4a4a4a)
      self.containerView.backgroundColor = UIColor(hex: 0x5a5a5a)
      self.optionLabel.textColor = UIColor(hex: 0xe1e1e1, alpha: 0.87)
    }else {
      self.contentView.backgroundColor = UIColor(hex: 0x4a4a4a)
      self.containerView.backgroundColor = UIColor(hex: 0x4a4a4a)
      self.optionLabel.textColor = UIColor(hex: 0xe1e1e1, alpha: 0.87)
    }
  }
  
}

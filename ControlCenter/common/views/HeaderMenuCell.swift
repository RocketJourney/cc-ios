//
//  HeaderMenuCell.swift
//  ControlCenter
//
//  Created by Erik on 12/4/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class HeaderMenuCell: UITableViewCell {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var headerTitleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setupView()
  }
  
  
  
  func setupView() -> Void {
    self.contentView.backgroundColor = UIColor(hex: 0x4a4a4a)
    self.backgroundColor = UIColor(hex: 0x4a4a4a)
    self.containerView.backgroundColor = UIColor(hex: 0x4a4a4a)
    self.containerView.layer.cornerRadius = 8.5
    
    self.headerTitleLabel.font = UIFont.montserratRegular(17)
    self.headerTitleLabel.textColor = UIColor.white
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    if selected {
      self.contentView.backgroundColor = UIColor(hex: 0x4a4a4a)
      self.containerView.backgroundColor = UIColor(hex: 0xa1a1a1)
      self.headerTitleLabel.textColor = UIColor(hex: 0x4a4a4a)
    }else {
      self.contentView.backgroundColor = UIColor(hex: 0x4a4a4a)
      self.containerView.backgroundColor = UIColor(hex: 0x4a4a4a)
      self.headerTitleLabel.textColor = UIColor.white
    }
    self.setNeedsDisplay()
  }
  
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    super.setHighlighted(highlighted, animated: animated)
    
    if highlighted {
      self.contentView.backgroundColor = UIColor(hex: 0x4a4a4a)
      self.containerView.backgroundColor = UIColor(hex: 0x5a5a5a)
      self.headerTitleLabel.textColor = UIColor.white
    }else {
      self.contentView.backgroundColor = UIColor(hex: 0x4a4a4a)
      self.containerView.backgroundColor = UIColor(hex: 0x4a4a4a)
      self.headerTitleLabel.textColor = UIColor.white
    }
  }
  
}

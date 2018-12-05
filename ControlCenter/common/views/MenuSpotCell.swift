//
//  MenuSpotCell.swift
//  ControlCenter
//
//  Created by Erik on 11/28/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class MenuSpotCell: UITableViewCell {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var spotNameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setupView()
  }
  
  
  
  func setupView() -> Void {
    self.contentView.backgroundColor = UIColor(hex: 0x4a4a4a)
    self.backgroundColor = UIColor(hex: 0x4a4a4a)
    self.containerView.backgroundColor = UIColor(hex: 0x4a4a4a)
    self.containerView.layer.cornerRadius = 8.5
    
    self.spotNameLabel.font = UIFont.montserratRegular(17)
    self.spotNameLabel.textColor = UIColor.white
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    if selected {
      self.contentView.backgroundColor = UIColor(hex: 0x4a4a4a)
      self.containerView.backgroundColor = UIColor(hex: 0xa1a1a1)
      self.spotNameLabel.textColor = UIColor(hex: 0x4a4a4a)
    }else {
      self.contentView.backgroundColor = UIColor(hex: 0x4a4a4a)
      self.containerView.backgroundColor = UIColor(hex: 0x4a4a4a)
      self.spotNameLabel.textColor = UIColor.white
    }
    self.setNeedsDisplay()
  }
  
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    super.setHighlighted(highlighted, animated: animated)
    
    if highlighted {
      self.contentView.backgroundColor = UIColor(hex: 0x4a4a4a)
      self.containerView.backgroundColor = UIColor(hex: 0x5a5a5a)
      self.spotNameLabel.textColor = UIColor.white
    }else {
      self.contentView.backgroundColor = UIColor(hex: 0x4a4a4a)
      self.containerView.backgroundColor = UIColor(hex: 0x4a4a4a)
      self.spotNameLabel.textColor = UIColor.white
    }
  }
  
}

//
//  StatusCell.swift
//  ControlCenter
//
//  Created by Erik on 11/29/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var counterStatusLabel: UILabel!
  @IBOutlet weak var textStatusLabel: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setupView()
  }
  
  func setupView() -> Void {
    self.backgroundColor = UIColor(hex: 0x212121)    
    self.contentView.backgroundColor = UIColor(hex: 0x212121)
    self.containerView.backgroundColor = UIColor(hex: 0x2d2d2d)
    self.containerView.layer.cornerRadius = 4.0
    
    self.counterStatusLabel.font = UIFont.montserratBold(40)
    self.counterStatusLabel.textColor = UIColor.white
    
    self.textStatusLabel.font = UIFont.montserratBold(13)
    self.textStatusLabel.textColor = UIColor(hex: 0xb9b9b9)
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    if selected{
      self.backgroundColor = UIColor(hex: 0x212121)
      self.containerView.backgroundColor = UIColor(hex: 0x2d2d2d)
    }else {
      self.backgroundColor = UIColor(hex: 0x212121)
      self.containerView.backgroundColor = UIColor(hex: 0x2d2d2d)
    }
  }
  
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    super.setHighlighted(highlighted, animated: animated)
    if highlighted {
      self.backgroundColor = UIColor(hex: 0x212121)
      self.containerView.backgroundColor = UIColor(hex: 0x2d2d2d)
    }else{
      self.backgroundColor = UIColor(hex: 0x212121)
      self.containerView.backgroundColor = UIColor(hex: 0x2d2d2d)
    }
    
  }
  
}

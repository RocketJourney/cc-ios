//
//  LinkCell.swift
//  ControlCenter
//
//  Created by Erik on 12/12/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class LinkCell: UITableViewCell {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setupView()
  }
  
  private func setupView() -> Void {
    self.backgroundColor = UIColor(hex: 0x1A1A1A)
    self.textLabel?.textColor = UIColor.white
    self.selectionStyle = .none
    self.textLabel?.font = UIFont.montserratRegular(18)
    self.accessoryView = UIImageView(image: UIImage(named: "option-arrow"), highlightedImage:  UIImage(named: "option-arrow"))
    self.tintColor = UIColor(hex: 0x212121)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    if selected {
      backgroundColor = UIColor(hex: 0x1a1a1a)!
    } else {
      backgroundColor = UIColor(hex: 0x2a2a2a)!
    }
  }
  
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    if highlighted {
      backgroundColor = UIColor(hex: 0x1a1a1a)!
    } else {
      backgroundColor = UIColor(hex: 0x2a2a2a)!
    }
  }
  
}

//
//  InviteCell.swift
//  ControlCenter
//
//  Created by Erik on 12/11/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class InviteCell: UITableViewCell {
  
  @IBOutlet weak var toogleView: UIView!
  @IBOutlet weak var toogleInsideView: UIView!
  @IBOutlet weak var inviteLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setupView()
  }
  
  private func setupView() -> Void {
    self.backgroundColor = UIColor(hex: 0x333333)
    self.contentView.backgroundColor = UIColor.clear
    
    self.toogleView.backgroundColor = UIColor(hex: 0x1a1a1a)
    self.toogleView.layer.cornerRadius = AppDelegate.ratioImages * self.toogleView.frame.width
    
    self.toogleInsideView.backgroundColor = UIColor(hex: 0xffcc00)
    self.toogleInsideView.layer.cornerRadius = AppDelegate.ratioImages * self.toogleInsideView.frame.width
    
    self.inviteLabel.textColor = UIColor.white
    self.inviteLabel.font = UIFont.montserratRegular(18)
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    self.toogleInsideView.isHidden = !selected    
  }
  
}

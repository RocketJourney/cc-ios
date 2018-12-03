//
//  UserCell.swift
//  ControlCenter
//
//  Created by Erik on 11/30/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
  
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var streakLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setupView()
  }
  
  private func setupView() -> Void {
    self.backgroundColor = UIColor(hex: 0x2a2a2a)
    self.contentView.backgroundColor = UIColor(hex: 0x2a2a2a)
    
    
    self.profileImage.backgroundColor = UIColor(hex: 0x3a3a3a)
    self.profileImage.clipsToBounds = true
    self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
    self.userNameLabel.font = UIFont.montserratBold(16)
    self.userNameLabel.textColor = UIColor(hex: 0xeaeaea)
    
    self.streakLabel.font = UIFont.montserratBold(16)
    self.streakLabel.textColor = UIColor(hex: 0xeaeaea)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    if selected {
      self.backgroundColor = UIColor(hex: 0x2a2a2a)
      self.contentView.backgroundColor = UIColor(hex: 0x2a2a2a)
    }else {
      self.backgroundColor = UIColor(hex: 0x2a2a2a)
      self.contentView.backgroundColor = UIColor(hex: 0x2a2a2a)
    }
    
  }
  
  
  func bind(assistant: UserAssistant) -> Void {
    self.profileImage.sd_setImage(with: URL(string: assistant.profilePicture))
    self.userNameLabel.text = assistant.fullName
    self.streakLabel.text = String(assistant.streak)
  }
  
}

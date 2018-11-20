//
//  ClubTableViewCell.swift
//  ControlCenter
//
//  Created by Erik on 11/9/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class ClubTableViewCell: UITableViewCell {
  
  @IBOutlet weak var clubImageView: UIImageView!
  @IBOutlet weak var titleClubLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.backgroundColor = UIColor(hex: 0x333333)
    self.clubImageView.backgroundColor = UIColor(hex: 0x4a4a4a)
    self.clubImageView.layer.cornerRadius = AppDelegate.ratioImages * self.clubImageView.frame.height
    self.clubImageView.layer.masksToBounds = true
    
    self.titleClubLabel.textColor = UIColor.white
    self.titleClubLabel.font = UIFont.montserratRegular(18)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    if selected {
      backgroundColor = UIColor(hex: 0x1a1a1a)!
    } else {
      backgroundColor = UIColor(hex: 0x333333)!
    }
  }
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    super.setHighlighted(highlighted, animated: animated)
    if highlighted {
      backgroundColor = UIColor(hex: 0x1a1a1a)!
    } else {
      backgroundColor = UIColor(hex: 0x333333)!
    }
  }
  
  
  func bind(club: Club) -> Void {
    <#function body#>
  }
  
}

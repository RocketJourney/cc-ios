//
//  UIFont+extension.swift
//  ControlCenter
//
//  Created by Erik on 11/6/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

extension UIFont {
  
  class func montserratLight(_ size: CGFloat) -> UIFont {
    return UIFont(name: "Montserrat-Light", size: size)!
  }
  class func montserratBold(_ size: CGFloat) -> UIFont {
    return UIFont(name: "Montserrat-Bold", size: size)!
  }
  class func montserratBlack(_ size: CGFloat) -> UIFont {
    return UIFont(name: "Montserrat-Black", size: size)!
  }
  class func montserratRegular(_ size: CGFloat) -> UIFont {
    return UIFont(name: "Montserrat-Medium", size: size)!
  }
  class func montserratMedium(_ size: CGFloat) -> UIFont {
    return UIFont(name: "Montserrat-Medium", size: size)!
  }
  
}

extension NSMutableAttributedString {
  
  func montserratBold(_ size:CGFloat, color: UIColor) {
    self.setAttributes([NSAttributedString.Key.font : UIFont.montserratBold(size),
                        NSAttributedString.Key.foregroundColor : color]
      , range: NSRange(location: 0, length: self.mutableString.length))
  }
  
  func montserratBlack(_ size:CGFloat, color: UIColor) {
    self.setAttributes([NSAttributedString.Key.font : UIFont.montserratBlack(size),
                        NSAttributedString.Key.foregroundColor : color]
      , range: NSRange(location: 0, length: self.mutableString.length))
  }
  
  func montserratRegular(_ size:CGFloat, color: UIColor) {
    self.setAttributes([NSAttributedString.Key.font : UIFont.montserratRegular(size),
                        NSAttributedString.Key.foregroundColor : color]
      , range: NSRange(location: 0, length: self.mutableString.length))
  }
  
  func montserratLight(_ size:CGFloat, color: UIColor, kerning: CGFloat) {
    self.setAttributes([NSAttributedString.Key.font : UIFont.montserratLight(size),
                        NSAttributedString.Key.foregroundColor : color,
                        NSAttributedString.Key.kern : kerning]
      , range: NSRange(location: 0, length: self.mutableString.length))
  }
  
  func montserratBold(_ size:CGFloat, color: UIColor, kerning: CGFloat) {
    self.setAttributes([NSAttributedString.Key.font : UIFont.montserratBold(size),
                        NSAttributedString.Key.foregroundColor : color,
                        NSAttributedString.Key.kern : kerning]
      , range: NSRange(location: 0, length: self.mutableString.length))
  }
  
  func montserratBlack(_ size:CGFloat, color: UIColor, kerning: CGFloat) {
    self.setAttributes([NSAttributedString.Key.font : UIFont.montserratBlack(size),
                        NSAttributedString.Key.foregroundColor : color,
                        NSAttributedString.Key.kern : kerning]
      , range: NSRange(location: 0, length: self.mutableString.length))
  }
  
  func montserratRegular(_ size:CGFloat, color: UIColor, kerning: CGFloat) {
    self.setAttributes([NSAttributedString.Key.font : UIFont.montserratRegular(size),
                        NSAttributedString.Key.foregroundColor : color,
                        NSAttributedString.Key.kern : kerning]
      , range: NSRange(location: 0, length: self.mutableString.length))
  }
  
  func titleStyle() {
    self.montserratBold(18.0, color: UIColor.white, kerning:1.4)
  }
  
}

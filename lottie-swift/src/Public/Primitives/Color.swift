//
//  Color.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 2/4/19.
//

import Foundation

public enum ColorFormatDenominator {
  case One
  case OneHundred
  case TwoFiftyFive
  
  var value: Double {
    switch self {
    case .One:
      return 1.0
    case .OneHundred:
      return 100.0
    case .TwoFiftyFive:
      return 255.0
    }
  }
}

final public class Color: NSObject, NSCoding, AutoCoding {
  
  public var r: Double
  public var g: Double
  public var b: Double
  public var a: Double
  
  public init(r: Double, g: Double, b: Double, a: Double, denominator: ColorFormatDenominator = .One) {
    self.r = r / denominator.value
    self.g = g / denominator.value
    self.b = b / denominator.value
    self.a = a / denominator.value
  }
    
    required public init(from decoder: Decoder) throws {
      var container = try decoder.unkeyedContainer()
      
      var r1: Double
      if !container.isAtEnd {
        r1 = try container.decode(Double.self)
      } else {
        r1 = 0
      }
      
      var g1: Double
      if !container.isAtEnd {
        g1 = try container.decode(Double.self)
      } else {
        g1 = 0
      }
      
      var b1: Double
      if !container.isAtEnd {
        b1 = try container.decode(Double.self)
      } else {
        b1 = 0
      }
      
      var a1: Double
      if !container.isAtEnd {
        a1 = try container.decode(Double.self)
      } else {
        a1 = 1
      }
      if r1 > 1, g1 > 1, b1 > 1, a1 > 1 {
        r1 = r1 / 255
        g1 = g1 / 255
        b1 = b1 / 255
        a1 = a1 / 255
      }
      self.r = r1
      self.g = g1
      self.b = b1
      self.a = a1
    }
    
    /// Initialize a new color with Hue Saturation and Value
    init(h: Double, s: Double, v: Double, a: Double) {
      
      let i = floor(h * 6)
      let f = h * 6 - i
      let p = v * (1 - s);
      let q = v * (1 - f * s)
      let t = v * (1 - (1 - f) * s)
      
      switch (i.truncatingRemainder(dividingBy: 6)) {
      case 0:
        self.r = v
        self.g = t
        self.b = p
      case 1:
        self.r = q
        self.g = v
        self.b = p
      case 2:
        self.r = p
        self.g = v
        self.b = t
      case 3:
        self.r = p
        self.g = q
        self.b = v
      case 4:
        self.r = t
        self.g = p
        self.b = v
      case 5:
        self.r = v
        self.g = p
        self.b = q
      default:
        self.r = 0
        self.g = 0
        self.b = 0
      }
      self.a = a
    }
    
    init(y: Double, u: Double, v: Double, a: Double) {
      // From https://www.fourcc.org/fccyvrgb.php
      self.r = y + 1.403 * v
      self.g = y - 0.344 * u
      self.b = y + 1.770 * u
      self.a = a
    }
    
    /// :nodoc:
        required public init?(coder aDecoder: NSCoder) {
            self.r = aDecoder.decode(forKey: "r")
            self.g = aDecoder.decode(forKey: "g")
            self.b = aDecoder.decode(forKey: "b")
            self.a = aDecoder.decode(forKey: "a")
        }

        /// :nodoc:
        public func encode(with aCoder: NSCoder) {
            aCoder.encode(self.r, forKey: "r")
            aCoder.encode(self.g, forKey: "g")
            aCoder.encode(self.b, forKey: "b")
            aCoder.encode(self.a, forKey: "a")
        }
    // sourcery:end
  
}

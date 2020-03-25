//
//  Color.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/14/19.
//

import Foundation
import CoreGraphics

extension Color: Codable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    try container.encode(r)
    try container.encode(g)
    try container.encode(b)
    try container.encode(a)
  }
  
}

extension Color {
  
  static var clearColor: CGColor {
    return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0, 0, 0, 0])!
  }
  
  var cgColorValue: CGColor {
    // TODO: Fix color spaces
    let colorspace = CGColorSpaceCreateDeviceRGB()
    return CGColor(colorSpace: colorspace, components: [CGFloat(r), CGFloat(g), CGFloat(b), CGFloat(a)]) ?? Color.clearColor
  }
}

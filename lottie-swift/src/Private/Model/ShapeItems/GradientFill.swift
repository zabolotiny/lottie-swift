//
//  GradientFill.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/8/19.
//

import Foundation

enum GradientType: Int, Codable, AutoCoding {
  case none
  case linear
  case radial
}

/// An item that define a gradient fill
final class GradientFill: ShapeItem {
  
  /// The opacity of the fill
  let opacity: KeyframeGroup<Vector1D>
  
  /// The start of the gradient
  let startPoint: KeyframeGroup<Vector3D>
  
  /// The end of the gradient
  let endPoint: KeyframeGroup<Vector3D>
  
  /// The type of gradient
  let gradientType: GradientType
  
  /// Gradient Highlight Length. Only if type is Radial
  let highlightLength: KeyframeGroup<Vector1D>?
  
  /// Highlight Angle. Only if type is Radial
  let highlightAngle: KeyframeGroup<Vector1D>?
  
  /// The number of color points in the gradient
  let numberOfColors: Int
  
  /// The Colors of the gradient.
  let colors: KeyframeGroup<[Double]>
  
  private enum CodingKeys : String, CodingKey {
    case opacity = "o"
    case startPoint = "s"
    case endPoint = "e"
    case gradientType = "t"
    case highlightLength = "h"
    case highlightAngle = "a"
    case colors = "g"
  }
  
  private enum GradientDataKeys : String, CodingKey {
    case numberOfColors = "p"
    case colors = "k"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: GradientFill.CodingKeys.self)
    self.opacity = try container.decode(KeyframeGroup<Vector1D>.self, forKey: .opacity)
    self.startPoint = try container.decode(KeyframeGroup<Vector3D>.self, forKey: .startPoint)
    self.endPoint = try container.decode(KeyframeGroup<Vector3D>.self, forKey: .endPoint)
    self.gradientType = try container.decode(GradientType.self, forKey: .gradientType)
    self.highlightLength = try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .highlightLength)
    self.highlightAngle = try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .highlightAngle)
    let colorsContainer = try container.nestedContainer(keyedBy: GradientDataKeys.self, forKey: .colors)
    self.colors = try colorsContainer.decode(KeyframeGroup<[Double]>.self, forKey: .colors)
    self.numberOfColors = try colorsContainer.decode(Int.self, forKey: .numberOfColors)
    try super.init(from: decoder)
  }
  
  override func encode(to encoder: Encoder) throws {
    try super.encode(to: encoder)
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(opacity, forKey: .opacity)
    try container.encode(startPoint, forKey: .startPoint)
    try container.encode(endPoint, forKey: .endPoint)
    try container.encode(gradientType, forKey: .gradientType)
    try container.encodeIfPresent(highlightLength, forKey: .highlightLength)
    try container.encodeIfPresent(highlightAngle, forKey: .highlightAngle)
    var colorsContainer = container.nestedContainer(keyedBy: GradientDataKeys.self, forKey: .colors)
    try colorsContainer.encode(numberOfColors, forKey: .numberOfColors)
    try colorsContainer.encode(colors, forKey: .colors)
  }
    
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let opacity: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "opacity") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["opacity"])); fatalError() }; self.opacity = opacity
        guard let startPoint: KeyframeGroup<Vector3D> = aDecoder.decode(forKey: "startPoint") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["startPoint"])); fatalError() }; self.startPoint = startPoint
        guard let endPoint: KeyframeGroup<Vector3D> = aDecoder.decode(forKey: "endPoint") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["endPoint"])); fatalError() }; self.endPoint = endPoint
        guard let gradientType: GradientType = GradientType(rawValue: aDecoder.decode(forKey: "gradientType")) else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["gradientType"])); fatalError() }; self.gradientType = gradientType
        self.highlightLength = aDecoder.decode(forKey: "highlightLength")
        self.highlightAngle = aDecoder.decode(forKey: "highlightAngle")
        self.numberOfColors = aDecoder.decode(forKey: "numberOfColors")
        guard let colors: KeyframeGroup<[Double]> = aDecoder.decode(forKey: "colors") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["colors"])); fatalError() }; self.colors = colors
        super.init(coder: aDecoder)
    }

    /// :nodoc:
    override internal func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(self.opacity, forKey: "opacity")
        aCoder.encode(self.startPoint, forKey: "startPoint")
        aCoder.encode(self.endPoint, forKey: "endPoint")
        aCoder.encode(self.gradientType.rawValue, forKey: "gradientType")
        aCoder.encode(self.highlightLength, forKey: "highlightLength")
        aCoder.encode(self.highlightAngle, forKey: "highlightAngle")
        aCoder.encode(self.numberOfColors, forKey: "numberOfColors")
        aCoder.encode(self.colors, forKey: "colors")
    }
  
}

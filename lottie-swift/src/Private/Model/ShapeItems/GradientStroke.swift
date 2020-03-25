//
//  GradientStroke.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/8/19.
//

import Foundation

enum LineCap: Int, Codable, AutoCoding {
  case none
  case butt
  case round
  case square
}

enum LineJoin: Int, Codable, AutoCoding {
  case none
  case miter
  case round
  case bevel
}

/// An item that define an ellipse shape
final class GradientStroke: ShapeItem {
  
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
  
  /// The width of the stroke
  let width: KeyframeGroup<Vector1D>
  
  /// Line Cap
  let lineCap: LineCap
  
  /// Line Join
  let lineJoin: LineJoin
  
  /// Miter Limit
  let miterLimit: Double
  
  /// The dash pattern of the stroke
  let dashPattern: [DashElement]?
  
  private enum CodingKeys : String, CodingKey {
    case opacity = "o"
    case startPoint = "s"
    case endPoint = "e"
    case gradientType = "t"
    case highlightLength = "h"
    case highlightAngle = "a"
    case colors = "g"
    case width = "w"
    case lineCap = "lc"
    case lineJoin = "lj"
    case miterLimit = "ml"
    case dashPattern = "d"
  }
  
  private enum GradientDataKeys : String, CodingKey {
    case numberOfColors = "p"
    case colors = "k"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: GradientStroke.CodingKeys.self)
    self.opacity = try container.decode(KeyframeGroup<Vector1D>.self, forKey: .opacity)
    self.startPoint = try container.decode(KeyframeGroup<Vector3D>.self, forKey: .startPoint)
    self.endPoint = try container.decode(KeyframeGroup<Vector3D>.self, forKey: .endPoint)
    self.gradientType = try container.decode(GradientType.self, forKey: .gradientType)
    self.highlightLength = try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .highlightLength)
    self.highlightAngle = try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .highlightAngle)
    self.width = try container.decode(KeyframeGroup<Vector1D>.self, forKey: .width)
    self.lineCap = try container.decodeIfPresent(LineCap.self, forKey: .lineCap) ?? .round
    self.lineJoin = try container.decodeIfPresent(LineJoin.self, forKey: .lineJoin) ?? .round
    self.miterLimit = try container.decodeIfPresent(Double.self, forKey: .miterLimit) ?? 4
    // TODO Decode Color Objects instead of array.
    let colorsContainer = try container.nestedContainer(keyedBy: GradientDataKeys.self, forKey: .colors)
    self.colors = try colorsContainer.decode(KeyframeGroup<[Double]>.self, forKey: .colors)
    self.numberOfColors = try colorsContainer.decode(Int.self, forKey: .numberOfColors)
    self.dashPattern = try container.decodeIfPresent([DashElement].self, forKey: .dashPattern)
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
    try container.encode(width, forKey: .width)
    try container.encode(lineCap, forKey: .lineCap)
    try container.encode(lineJoin, forKey: .lineJoin)
    try container.encode(miterLimit, forKey: .miterLimit)
    var colorsContainer = container.nestedContainer(keyedBy: GradientDataKeys.self, forKey: .colors)
    try colorsContainer.encode(numberOfColors, forKey: .numberOfColors)
    try colorsContainer.encode(colors, forKey: .colors)
    try container.encodeIfPresent(dashPattern, forKey: .dashPattern)
  }
  
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let opacity: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "opacity") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["opacity"])); fatalError() }; self.opacity = opacity
        guard let startPoint: KeyframeGroup<Vector3D> = aDecoder.decode(forKey: "startPoint") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["startPoint"])); fatalError() }; self.startPoint = startPoint
        guard let endPoint: KeyframeGroup<Vector3D> = aDecoder.decode(forKey: "endPoint") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["endPoint"])); fatalError() }; self.endPoint = endPoint
        guard let gradientType: GradientType = aDecoder.decode(forKey: "gradientType") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["gradientType"])); fatalError() }; self.gradientType = gradientType
        self.highlightLength = aDecoder.decode(forKey: "highlightLength")
        self.highlightAngle = aDecoder.decode(forKey: "highlightAngle")
        self.numberOfColors = aDecoder.decode(forKey: "numberOfColors")
        guard let colors: KeyframeGroup<[Double]> = aDecoder.decode(forKey: "colors") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["colors"])); fatalError() }; self.colors = colors
        guard let width: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "width") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["width"])); fatalError() }; self.width = width
        guard let lineCap: LineCap = aDecoder.decode(forKey: "lineCap") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["lineCap"])); fatalError() }; self.lineCap = lineCap
        guard let lineJoin: LineJoin = aDecoder.decode(forKey: "lineJoin") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["lineJoin"])); fatalError() }; self.lineJoin = lineJoin
        self.miterLimit = aDecoder.decode(forKey: "miterLimit")
        self.dashPattern = aDecoder.decode(forKey: "dashPattern")
        super.init(coder: aDecoder)
    }

    /// :nodoc:
    override internal func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(self.opacity, forKey: "opacity")
        aCoder.encode(self.startPoint, forKey: "startPoint")
        aCoder.encode(self.endPoint, forKey: "endPoint")
        aCoder.encode(self.gradientType, forKey: "gradientType")
        aCoder.encode(self.highlightLength, forKey: "highlightLength")
        aCoder.encode(self.highlightAngle, forKey: "highlightAngle")
        aCoder.encode(self.numberOfColors, forKey: "numberOfColors")
        aCoder.encode(self.colors, forKey: "colors")
        aCoder.encode(self.width, forKey: "width")
        aCoder.encode(self.lineCap, forKey: "lineCap")
        aCoder.encode(self.lineJoin, forKey: "lineJoin")
        aCoder.encode(self.miterLimit, forKey: "miterLimit")
        aCoder.encode(self.dashPattern, forKey: "dashPattern")
    }
}

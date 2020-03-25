//
//  Stroke.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/8/19.
//

import Foundation

/// An item that define an ellipse shape
final class Stroke: ShapeItem, AutoCoding {
  
  /// The opacity of the stroke
  let opacity: KeyframeGroup<Vector1D>
  
  /// The Color of the stroke
  let color: KeyframeGroup<Color>
  
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
    case color = "c"
    case width = "w"
    case lineCap = "lc"
    case lineJoin = "lj"
    case miterLimit = "ml"
    case dashPattern = "d"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Stroke.CodingKeys.self)
    self.opacity = try container.decode(KeyframeGroup<Vector1D>.self, forKey: .opacity)
    self.color = try container.decode(KeyframeGroup<Color>.self, forKey: .color)
    self.width = try container.decode(KeyframeGroup<Vector1D>.self, forKey: .width)
    self.lineCap = try container.decodeIfPresent(LineCap.self, forKey: .lineCap) ?? .round
    self.lineJoin = try container.decodeIfPresent(LineJoin.self, forKey: .lineJoin) ?? .round
    self.miterLimit = try container.decodeIfPresent(Double.self, forKey: .miterLimit) ?? 4
    self.dashPattern = try container.decodeIfPresent([DashElement].self, forKey: .dashPattern)
    try super.init(from: decoder)
  }
  
  override func encode(to encoder: Encoder) throws {
    try super.encode(to: encoder)
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(opacity, forKey: .opacity)
    try container.encode(color, forKey: .color)
    try container.encode(width, forKey: .width)
    try container.encode(lineCap, forKey: .lineCap)
    try container.encode(lineJoin, forKey: .lineJoin)
    try container.encode(miterLimit, forKey: .miterLimit)
    try container.encodeIfPresent(dashPattern, forKey: .dashPattern)
    }
    
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let opacity: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "opacity") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["opacity"])); fatalError() }; self.opacity = opacity
        guard let color: KeyframeGroup<Color> = aDecoder.decode(forKey: "color") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["color"])); fatalError() }; self.color = color
        guard let width: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "width") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["width"])); fatalError() }; self.width = width
        guard let lineCap: LineCap = LineCap(rawValue: aDecoder.decode(forKey: "lineCap")) else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["lineCap"])); fatalError() }; self.lineCap = lineCap
        guard let lineJoin: LineJoin = LineJoin(rawValue: aDecoder.decode(forKey: "lineJoin")) else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["lineJoin"])); fatalError() }; self.lineJoin = lineJoin
        self.miterLimit = aDecoder.decode(forKey: "miterLimit")
        self.dashPattern = aDecoder.decode(forKey: "dashPattern")
        super.init(coder: aDecoder)
    }
    
    /// :nodoc:
    internal override func encode(with aCoder: NSCoder) {
        aCoder.encode(self.opacity, forKey: "opacity")
        aCoder.encode(self.color, forKey: "color")
        aCoder.encode(self.width, forKey: "width")
        aCoder.encode(self.lineCap.rawValue, forKey: "lineCap")
        aCoder.encode(self.lineJoin.rawValue, forKey: "lineJoin")
        aCoder.encode(self.miterLimit, forKey: "miterLimit")
        aCoder.encode(self.dashPattern, forKey: "dashPattern")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.type.rawValue, forKey: "type")
        aCoder.encode(self.hidden, forKey: "hidden")
    }
    // sourcery:end
}

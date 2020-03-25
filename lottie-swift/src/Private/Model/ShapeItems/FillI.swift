//
//  FillShape.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/8/19.
//

import Foundation

enum FillRule: Int, Codable, AutoCoding {
  case none
  case nonZeroWinding
  case evenOdd
}

/// An item that defines a fill render
final class Fill: ShapeItem {
  
  /// The opacity of the fill
  let opacity: KeyframeGroup<Vector1D>
  
  /// The color keyframes for the fill
  let color: KeyframeGroup<Color>
  
  let fillRule: FillRule
  
  private enum CodingKeys : String, CodingKey {
    case opacity = "o"
    case color = "c"
    case fillRule = "r"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Fill.CodingKeys.self)
    self.opacity = try container.decode(KeyframeGroup<Vector1D>.self, forKey: .opacity)
    self.color = try container.decode(KeyframeGroup<Color>.self, forKey: .color)
    self.fillRule = try container.decodeIfPresent(FillRule.self, forKey: .fillRule) ?? .nonZeroWinding
    try super.init(from: decoder)
  }
  
  override func encode(to encoder: Encoder) throws {
    try super.encode(to: encoder)
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(opacity, forKey: .opacity)
    try container.encode(color, forKey: .color)
    try container.encode(fillRule, forKey: .fillRule)
  }
  
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let opacity: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "opacity") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["opacity"])); fatalError() }; self.opacity = opacity
        guard let color: KeyframeGroup<Color> = aDecoder.decode(forKey: "color") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["color"])); fatalError() }; self.color = color
        guard let fillRule: FillRule = FillRule(rawValue: aDecoder.decode(forKey: "fillRule")) else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["fillRule"])); fatalError() }; self.fillRule = fillRule
        super.init(coder: aDecoder)
    }

    /// :nodoc:
    override internal func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(self.opacity, forKey: "opacity")
        aCoder.encode(self.color, forKey: "color")
        aCoder.encode(self.fillRule.rawValue, forKey: "fillRule")
    }
}

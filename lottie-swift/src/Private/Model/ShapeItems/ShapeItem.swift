//
//  ShapeItem.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/8/19.
//

import Foundation

/// Used for mapping a heterogeneous list to classes for parsing.
extension ShapeType: ClassFamily {

  static var discriminator: Discriminator = .type
  
  func getType() -> AnyObject.Type {
    switch self {
    case .ellipse:
      return Ellipse.self
    case .fill:
      return Fill.self
    case .gradientFill:
      return GradientFill.self
    case .group:
      return Group.self
    case .gradientStroke:
      return GradientStroke.self
    case .merge:
      return Merge.self
    case .rectangle:
      return Rectangle.self
    case .repeater:
      return Repeater.self
    case .shape:
      return Shape.self
    case .star:
      return Star.self
    case .stroke:
      return Stroke.self
    case .trim:
      return Trim.self
    case .transform:
      return ShapeTransform.self
    default:
      return ShapeItem.self
    }
  }
}

enum ShapeType: String, Codable, AutoCoding {
  case ellipse = "el"
  case fill = "fl"
  case gradientFill = "gf"
  case group = "gr"
  case gradientStroke = "gs"
  case merge = "mm"
  case rectangle = "rc"
  case repeater = "rp"
  case round = "rd"
  case shape = "sh"
  case star = "sr"
  case stroke = "st"
  case trim = "tm"
  case transform = "tr"
  case unknown
  
  public init(from decoder: Decoder) throws {
    self = try ShapeType(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
  }
}

/// An item belonging to a Shape Layer
class ShapeItem: NSObject, Codable, NSCoding {
  
  /// The name of the shape
  let name: String
  
  /// The type of shape
  let type: ShapeType
  
  let hidden: Bool
  
  private enum CodingKeys : String, CodingKey {
    case name = "nm"
    case type = "ty"
    case hidden = "hd"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: ShapeItem.CodingKeys.self)
    self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Layer"
    self.type = try container.decode(ShapeType.self, forKey: .type)
    self.hidden = try container.decodeIfPresent(Bool.self, forKey: .hidden) ?? false
  }
    
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let name: String = aDecoder.decode(forKey: "name") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["name"])); fatalError() }; self.name = name
        guard let type: ShapeType = ShapeType(rawValue: aDecoder.decode(forKey: "type")!)  else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["type"])); fatalError() }; self.type = type
        self.hidden = aDecoder.decode(forKey: "hidden")
    }

    /// :nodoc:
    internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.type.rawValue, forKey: "type")
        aCoder.encode(self.hidden, forKey: "hidden")
    }

}

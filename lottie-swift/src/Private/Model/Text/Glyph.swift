//
//  Glyph.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/9/19.
//

import Foundation

/// A model that holds a vector character
final class Glyph: Codable, NSCoding {
  
  /// The character
  let character: String
  
  /// The font size of the character
  let fontSize: Double
  
  /// The font family of the character
  let fontFamily: String
  
  /// The Style of the character
  let fontStyle: String
  
  /// The Width of the character
  let width: Double
  
  /// The Shape Data of the Character
  let shapes: [ShapeItem]
  
  private enum CodingKeys: String, CodingKey {
    case character = "ch"
    case fontSize = "size"
    case fontFamily = "fFamily"
    case fontStyle = "style"
    case width = "w"
    case shapeWrapper = "data"
  }
  
  private enum ShapeKey: String, CodingKey {
    case shapes = "shapes"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Glyph.CodingKeys.self)
    self.character = try container.decode(String.self, forKey: .character)
    self.fontSize = try container.decode(Double.self, forKey: .fontSize)
    self.fontFamily = try container.decode(String.self, forKey: .fontFamily)
    self.fontStyle = try container.decode(String.self, forKey: .fontStyle)
    self.width = try container.decode(Double.self, forKey: .width)
    if container.contains(.shapeWrapper),
      let shapeContainer = try? container.nestedContainer(keyedBy: ShapeKey.self, forKey: .shapeWrapper),
      shapeContainer.contains(.shapes) {
      self.shapes = try shapeContainer.decode([ShapeItem].self, ofFamily: ShapeType.self, forKey: .shapes)
    } else {
      self.shapes = []
    }
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(character, forKey: .character)
    try container.encode(fontSize, forKey: .fontSize)
    try container.encode(fontFamily, forKey: .fontFamily)
    try container.encode(fontStyle, forKey: .fontStyle)
    try container.encode(width, forKey: .width)
    
    var shapeContainer = container.nestedContainer(keyedBy: ShapeKey.self, forKey: .shapeWrapper)
    try shapeContainer.encode(shapes, forKey: .shapes)
  }
    
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let character: String = aDecoder.decode(forKey: "character") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["character"])); fatalError() }; self.character = character
        self.fontSize = aDecoder.decode(forKey: "fontSize")
        guard let fontFamily: String = aDecoder.decode(forKey: "fontFamily") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["fontFamily"])); fatalError() }; self.fontFamily = fontFamily
        guard let fontStyle: String = aDecoder.decode(forKey: "fontStyle") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["fontStyle"])); fatalError() }; self.fontStyle = fontStyle
        self.width = aDecoder.decode(forKey: "width")
        guard let shapes: [ShapeItem] = aDecoder.decode(forKey: "shapes") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["shapes"])); fatalError() }; self.shapes = shapes
    }

    /// :nodoc:
    internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.character, forKey: "character")
        aCoder.encode(self.fontSize, forKey: "fontSize")
        aCoder.encode(self.fontFamily, forKey: "fontFamily")
        aCoder.encode(self.fontStyle, forKey: "fontStyle")
        aCoder.encode(self.width, forKey: "width")
        aCoder.encode(self.shapes, forKey: "shapes")
    }
}

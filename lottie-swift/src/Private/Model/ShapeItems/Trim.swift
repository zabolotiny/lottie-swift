//
//  Trim.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/8/19.
//

import Foundation

enum TrimType: Int, Codable, AutoCoding {
  case simultaneously = 1
  case individually = 2
}
/// An item that define an ellipse shape
final class Trim: ShapeItem, AutoCoding {
  
  /// The start of the trim
  let start: KeyframeGroup<Vector1D>
  
  /// The end of the trim
  let end: KeyframeGroup<Vector1D>
  
  /// The offset of the trim
  let offset: KeyframeGroup<Vector1D>
  
  let trimType: TrimType
  
  private enum CodingKeys : String, CodingKey {
    case start = "s"
    case end = "e"
    case offset = "o"
    case trimType = "m"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Trim.CodingKeys.self)
        self.start = try container.decode(KeyframeGroup<Vector1D>.self, forKey: .start)
        self.end = try container.decode(KeyframeGroup<Vector1D>.self, forKey: .end)
        self.offset = try container.decode(KeyframeGroup<Vector1D>.self, forKey: .offset)
        self.trimType = try container.decode(TrimType.self, forKey: .trimType)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(start, forKey: .start)
        try container.encode(end, forKey: .end)
        try container.encode(offset, forKey: .offset)
        try container.encode(trimType, forKey: .trimType)
    }
    
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let start: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "start") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["start"])); fatalError() }; self.start = start
        guard let end: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "end") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["end"])); fatalError() }; self.end = end
        guard let offset: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "offset") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["offset"])); fatalError() }; self.offset = offset
        guard let trimType: TrimType = TrimType(rawValue: aDecoder.decode(forKey: "trimType")) else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["trimType"])); fatalError() }; self.trimType = trimType
        super.init(coder: aDecoder)
    }
    
    /// :nodoc:
    internal override func encode(with aCoder: NSCoder) {
        aCoder.encode(self.start, forKey: "start")
        aCoder.encode(self.end, forKey: "end")
        aCoder.encode(self.offset, forKey: "offset")
        aCoder.encode(self.trimType.rawValue, forKey: "trimType")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.type.rawValue, forKey: "type")
        aCoder.encode(self.hidden, forKey: "hidden")
    }
    // sourcery:end

  
}

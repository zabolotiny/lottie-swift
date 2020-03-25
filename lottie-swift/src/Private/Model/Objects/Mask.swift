//
//  Mask.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/8/19.
//

import Foundation

enum MaskMode: String, Codable, AutoCoding {
  case add = "a"
  case subtract = "s"
  case intersect = "i"
  case lighten = "l"
  case darken = "d"
  case difference = "f"
  case none = "n"
}

final class Mask: NSObject, Codable, NSCoding {
  
  let mode: MaskMode
  
  let opacity: KeyframeGroup<Vector1D>
  
  let shape: KeyframeGroup<BezierPath>
  
  let inverted: Bool
  
  let expansion: KeyframeGroup<Vector1D>
  
  enum CodingKeys : String, CodingKey {
    case mode = "mode"
    case opacity = "o"
    case inverted = "inv"
    case shape = "pt"
    case expansion = "x"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Mask.CodingKeys.self)
    self.mode = try container.decodeIfPresent(MaskMode.self, forKey: .mode) ?? .add
    self.opacity = try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .opacity) ?? KeyframeGroup(Vector1D(100))
    self.shape = try container.decode(KeyframeGroup<BezierPath>.self, forKey: .shape)
    self.inverted = try container.decodeIfPresent(Bool.self, forKey: .inverted) ?? false
    self.expansion = try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .expansion) ?? KeyframeGroup(Vector1D(0))
  }
    
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let mode: MaskMode = MaskMode(rawValue: aDecoder.decode(forKey: "mode") ?? "") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["mode"])); fatalError() }; self.mode = mode
        guard let opacity: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "opacity") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["opacity"])); fatalError() }; self.opacity = opacity
        guard let shape: KeyframeGroup<BezierPath> = aDecoder.decode(forKey: "shape") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["shape"])); fatalError() }; self.shape = shape
        self.inverted = aDecoder.decode(forKey: "inverted")
        guard let expansion: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "expansion") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["expansion"])); fatalError() }; self.expansion = expansion
    }

    /// :nodoc:
    internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.mode.rawValue, forKey: "mode")
        aCoder.encode(self.opacity, forKey: "opacity")
        aCoder.encode(self.shape, forKey: "shape")
        aCoder.encode(self.inverted, forKey: "inverted")
        aCoder.encode(self.expansion, forKey: "expansion")
    }
}

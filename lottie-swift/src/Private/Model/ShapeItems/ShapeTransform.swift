//
//  TransformItem.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/8/19.
//

import Foundation

/// An item that define an ellipse shape
final class ShapeTransform: ShapeItem {
  
  /// Anchor Point
  let anchor: KeyframeGroup<Vector3D>
  
  /// Position
  let position: KeyframeGroup<Vector3D>
  
  /// Scale
  let scale: KeyframeGroup<Vector3D>
  
  /// Rotation
  let rotation: KeyframeGroup<Vector1D>
  
  /// opacity
  let opacity: KeyframeGroup<Vector1D>
  
  /// Skew
  let skew: KeyframeGroup<Vector1D>
  
  /// Skew Axis
  let skewAxis: KeyframeGroup<Vector1D>
  
  private enum CodingKeys : String, CodingKey {
    case anchor = "a"
    case position = "p"
    case scale = "s"
    case rotation = "r"
    case opacity = "o"
    case skew = "sk"
    case skewAxis = "sa"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: ShapeTransform.CodingKeys.self)
    self.anchor = try container.decodeIfPresent(KeyframeGroup<Vector3D>.self, forKey: .anchor) ?? KeyframeGroup(Vector3D(x: Double(0), y: 0, z: 0))
    self.position = try container.decodeIfPresent(KeyframeGroup<Vector3D>.self, forKey: .position) ?? KeyframeGroup(Vector3D(x: Double(0), y: 0, z: 0))
    self.scale = try container.decodeIfPresent(KeyframeGroup<Vector3D>.self, forKey: .scale) ?? KeyframeGroup(Vector3D(x: Double(100), y: 100, z: 100))
    self.rotation = try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .rotation) ?? KeyframeGroup(Vector1D(0))
    self.opacity = try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .opacity) ?? KeyframeGroup(Vector1D(100))
    self.skew = try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .skew) ?? KeyframeGroup(Vector1D(0))
    self.skewAxis =  try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .skewAxis) ?? KeyframeGroup(Vector1D(0))
    try super.init(from: decoder)
  }
  
  override func encode(to encoder: Encoder) throws {
    try super.encode(to: encoder)
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(anchor, forKey: .anchor)
    try container.encode(position, forKey: .position)
    try container.encode(scale, forKey: .scale)
    try container.encode(rotation, forKey: .rotation)
    try container.encode(opacity, forKey: .opacity)
    try container.encode(skew, forKey: .skew)
    try container.encode(skewAxis, forKey: .skewAxis)
  }
    
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let anchor: KeyframeGroup<Vector3D> = aDecoder.decode(forKey: "anchor") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["anchor"])); fatalError() }; self.anchor = anchor
        guard let position: KeyframeGroup<Vector3D> = aDecoder.decode(forKey: "position") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["position"])); fatalError() }; self.position = position
        guard let scale: KeyframeGroup<Vector3D> = aDecoder.decode(forKey: "scale") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["scale"])); fatalError() }; self.scale = scale
        guard let rotation: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "rotation") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["rotation"])); fatalError() }; self.rotation = rotation
        guard let opacity: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "opacity") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["opacity"])); fatalError() }; self.opacity = opacity
        guard let skew: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "skew") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["skew"])); fatalError() }; self.skew = skew
        guard let skewAxis: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "skewAxis") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["skewAxis"])); fatalError() }; self.skewAxis = skewAxis
        super.init(coder: aDecoder)
    }

    /// :nodoc:
    override internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.type.rawValue, forKey: "type")
        aCoder.encode(self.hidden, forKey: "hidden")
        aCoder.encode(self.anchor, forKey: "anchor")
        aCoder.encode(self.position, forKey: "position")
        aCoder.encode(self.scale, forKey: "scale")
        aCoder.encode(self.rotation, forKey: "rotation")
        aCoder.encode(self.opacity, forKey: "opacity")
        aCoder.encode(self.skew, forKey: "skew")
        aCoder.encode(self.skewAxis, forKey: "skewAxis")
    }
  
}

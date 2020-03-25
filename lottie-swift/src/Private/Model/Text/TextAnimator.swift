//
//  TextAnimator.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/9/19.
//

import Foundation

final class TextAnimator: Codable, NSCoding {
  
  let name: String
  
  /// Anchor
  let anchor: KeyframeGroup<Vector3D>?
  
  /// Position
  let position: KeyframeGroup<Vector3D>?
  
  /// Scale
  let scale: KeyframeGroup<Vector3D>?
  
  /// Skew
  let skew: KeyframeGroup<Vector1D>?
  
  /// Skew Axis
  let skewAxis: KeyframeGroup<Vector1D>?
  
  /// Rotation
  let rotation: KeyframeGroup<Vector1D>?
  
  /// Opacity
  let opacity: KeyframeGroup<Vector1D>?
  
  /// Stroke Color
  let strokeColor: KeyframeGroup<Color>?
  
  /// Fill Color
  let fillColor: KeyframeGroup<Color>?
  
  /// Stroke Width
  let strokeWidth: KeyframeGroup<Vector1D>?
  
  /// Tracking
  let tracking: KeyframeGroup<Vector1D>?
  
  private enum CodingKeys: String, CodingKey {
//    case textSelector = "s" TODO
    case textAnimator = "a"
    case name = "nm"
  }
  
  private enum TextSelectorKeys: String, CodingKey {
    case start = "s"
    case end = "e"
    case offset = "o"
  }
  
  private enum TextAnimatorKeys: String, CodingKey {
    case fillColor = "fc"
    case strokeColor = "sc"
    case strokeWidth = "sw"
    case tracking = "t"
    case anchor = "a"
    case position = "p"
    case scale = "s"
    case skew = "sk"
    case skewAxis = "sa"
    case rotation = "r"
    case opacity = "o"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: TextAnimator.CodingKeys.self)
    self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    let animatorContainer = try container.nestedContainer(keyedBy: TextAnimatorKeys.self, forKey: .textAnimator)
    self.fillColor = try animatorContainer.decodeIfPresent(KeyframeGroup<Color>.self, forKey: .fillColor)
    self.strokeColor = try animatorContainer.decodeIfPresent(KeyframeGroup<Color>.self, forKey: .strokeColor)
    self.strokeWidth = try animatorContainer.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .strokeWidth)
    self.tracking = try animatorContainer.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .tracking)
    self.anchor = try animatorContainer.decodeIfPresent(KeyframeGroup<Vector3D>.self, forKey: .anchor)
    self.position = try animatorContainer.decodeIfPresent(KeyframeGroup<Vector3D>.self, forKey: .position)
    self.scale = try animatorContainer.decodeIfPresent(KeyframeGroup<Vector3D>.self, forKey: .scale)
    self.skew = try animatorContainer.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .skew)
    self.skewAxis = try animatorContainer.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .skewAxis)
    self.rotation = try animatorContainer.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .rotation)
    self.opacity = try animatorContainer.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .opacity)
    
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    var animatorContainer = container.nestedContainer(keyedBy: TextAnimatorKeys.self, forKey: .textAnimator)
    try animatorContainer.encodeIfPresent(fillColor, forKey: .fillColor)
    try animatorContainer.encodeIfPresent(strokeColor, forKey: .strokeColor)
    try animatorContainer.encodeIfPresent(strokeWidth, forKey: .strokeWidth)
    try animatorContainer.encodeIfPresent(tracking, forKey: .tracking)
  }
    
    required internal init?(coder aDecoder: NSCoder) {
        guard let name: String = aDecoder.decode(forKey: "name") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["name"])); fatalError() }; self.name = name
        self.anchor = aDecoder.decode(forKey: "anchor")
        self.position = aDecoder.decode(forKey: "position")
        self.scale = aDecoder.decode(forKey: "scale")
        self.skew = aDecoder.decode(forKey: "skew")
        self.skewAxis = aDecoder.decode(forKey: "skewAxis")
        self.rotation = aDecoder.decode(forKey: "rotation")
        self.opacity = aDecoder.decode(forKey: "opacity")
        self.strokeColor = aDecoder.decode(forKey: "strokeColor")
        self.fillColor = aDecoder.decode(forKey: "fillColor")
        self.strokeWidth = aDecoder.decode(forKey: "strokeWidth")
        self.tracking = aDecoder.decode(forKey: "tracking")
    }

    /// :nodoc:
    internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.anchor, forKey: "anchor")
        aCoder.encode(self.position, forKey: "position")
        aCoder.encode(self.scale, forKey: "scale")
        aCoder.encode(self.skew, forKey: "skew")
        aCoder.encode(self.skewAxis, forKey: "skewAxis")
        aCoder.encode(self.rotation, forKey: "rotation")
        aCoder.encode(self.opacity, forKey: "opacity")
        aCoder.encode(self.strokeColor, forKey: "strokeColor")
        aCoder.encode(self.fillColor, forKey: "fillColor")
        aCoder.encode(self.strokeWidth, forKey: "strokeWidth")
        aCoder.encode(self.tracking, forKey: "tracking")
    }
}

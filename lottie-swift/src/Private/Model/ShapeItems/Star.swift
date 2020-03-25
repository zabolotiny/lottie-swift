//
//  Star.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/8/19.
//

import Foundation

enum StarType: Int, Codable, AutoCoding {
  case none
  case star
  case polygon
}

/// An item that define an ellipse shape
final class Star: ShapeItem {
  
  /// The direction of the star.
  let direction: PathDirection
  
  /// The position of the star
  let position: KeyframeGroup<Vector3D>
  
  /// The outer radius of the star
  let outerRadius: KeyframeGroup<Vector1D>
  
  /// The outer roundness of the star
  let outerRoundness: KeyframeGroup<Vector1D>
  
  /// The outer radius of the star
  let innerRadius: KeyframeGroup<Vector1D>?
  
  /// The outer roundness of the star
  let innerRoundness: KeyframeGroup<Vector1D>?
  
  /// The rotation of the star
  let rotation: KeyframeGroup<Vector1D>
  
  /// The number of points on the star
  let points: KeyframeGroup<Vector1D>
  
  /// The type of star
  let starType: StarType
  
  private enum CodingKeys : String, CodingKey {
    case direction = "d"
    case position = "p"
    case outerRadius = "or"
    case outerRoundness = "os"
    case innerRadius = "ir"
    case innerRoundness = "is"
    case rotation = "r"
    case points = "pt"
    case starType = "sy"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Star.CodingKeys.self)
    self.direction = try container.decodeIfPresent(PathDirection.self, forKey: .direction) ?? .clockwise
    self.position = try container.decode(KeyframeGroup<Vector3D>.self, forKey: .position)
    self.outerRadius = try container.decode(KeyframeGroup<Vector1D>.self, forKey: .outerRadius)
    self.outerRoundness = try container.decode(KeyframeGroup<Vector1D>.self, forKey: .outerRoundness)
    self.innerRadius = try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .innerRadius)
    self.innerRoundness = try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .innerRoundness)
    self.rotation = try container.decode(KeyframeGroup<Vector1D>.self, forKey: .rotation)
    self.points = try container.decode(KeyframeGroup<Vector1D>.self, forKey: .points)
    self.starType = try container.decode(StarType.self, forKey: .starType)
    try super.init(from: decoder)
  }
  
  override func encode(to encoder: Encoder) throws {
    try super.encode(to: encoder)
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(direction, forKey: .direction)
    try container.encode(position, forKey: .position)
    try container.encode(outerRadius, forKey: .outerRadius)
    try container.encode(outerRoundness, forKey: .outerRoundness)
    try container.encode(innerRadius, forKey: .innerRadius)
    try container.encode(innerRoundness, forKey: .innerRoundness)
    try container.encode(rotation, forKey: .rotation)
    try container.encode(points, forKey: .points)
    try container.encode(starType, forKey: .starType)
  }
    
    required internal init?(coder aDecoder: NSCoder) {
        guard let direction: PathDirection = aDecoder.decode(forKey: "direction") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["direction"])); fatalError() }; self.direction = direction
        guard let position: KeyframeGroup<Vector3D> = aDecoder.decode(forKey: "position") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["position"])); fatalError() }; self.position = position
        guard let outerRadius: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "outerRadius") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["outerRadius"])); fatalError() }; self.outerRadius = outerRadius
        guard let outerRoundness: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "outerRoundness") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["outerRoundness"])); fatalError() }; self.outerRoundness = outerRoundness
        self.innerRadius = aDecoder.decode(forKey: "innerRadius")
        self.innerRoundness = aDecoder.decode(forKey: "innerRoundness")
        guard let rotation: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "rotation") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["rotation"])); fatalError() }; self.rotation = rotation
        guard let points: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "points") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["points"])); fatalError() }; self.points = points
        guard let starType: StarType = aDecoder.decode(forKey: "starType") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["starType"])); fatalError() }; self.starType = starType
        super.init(coder: aDecoder)
    }

    /// :nodoc:
    override internal func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(self.direction, forKey: "direction")
        aCoder.encode(self.position, forKey: "position")
        aCoder.encode(self.outerRadius, forKey: "outerRadius")
        aCoder.encode(self.outerRoundness, forKey: "outerRoundness")
        aCoder.encode(self.innerRadius, forKey: "innerRadius")
        aCoder.encode(self.innerRoundness, forKey: "innerRoundness")
        aCoder.encode(self.rotation, forKey: "rotation")
        aCoder.encode(self.points, forKey: "points")
        aCoder.encode(self.starType, forKey: "starType")
    }
  
}

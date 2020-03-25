//
//  Transform.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/7/19.
//

import Foundation

/// The animatable transform for a layer. Controls position, rotation, scale, and opacity.
final class Transform: NSObject, Codable, NSCoding {
  
  /// The anchor point of the transform.
  let anchorPoint: KeyframeGroup<Vector3D>
  
  /// The position of the transform. This is nil if the position data was split.
  let position: KeyframeGroup<Vector3D>?
  
  /// The positionX of the transform. This is nil if the position property is set.
  let positionX: KeyframeGroup<Vector1D>?
  
  /// The positionY of the transform. This is nil if the position property is set.
  let positionY: KeyframeGroup<Vector1D>?
  
  /// The scale of the transform
  let scale: KeyframeGroup<Vector3D>
  
  /// The rotation of the transform. Note: This is single dimensional rotation.
  let rotation: KeyframeGroup<Vector1D>
  
  /// The opacity of the transform.
  let opacity: KeyframeGroup<Vector1D>
  
  /// Should always be nil.
  let rotationZ: KeyframeGroup<Vector1D>?
  
  enum CodingKeys : String, CodingKey {
    case anchorPoint = "a"
    case position = "p"
    case positionX = "px"
    case positionY = "py"
    case scale = "s"
    case rotation = "r"
    case rotationZ = "rz"
    case opacity = "o"
  }

  enum PositionCodingKeys : String, CodingKey {
    case split = "s"
    case positionX = "x"
    case positionY = "y"
  }
  
  
  required init(from decoder: Decoder) throws {
    /**
     This manual override of decode is required because we want to throw an error
     in the case that there is not position data.
     */
    let container = try decoder.container(keyedBy: Transform.CodingKeys.self)
    
    // AnchorPoint
    self.anchorPoint = try container.decodeIfPresent(KeyframeGroup<Vector3D>.self, forKey: .anchorPoint) ?? KeyframeGroup(Vector3D(x: Double(0), y: 0, z: 0))
    
    // Position
    if container.contains(.positionX), container.contains(.positionY) {
      // Position dimensions are split into two keyframe groups
      self.positionX = try container.decode(KeyframeGroup<Vector1D>.self, forKey: .positionX)
      self.positionY = try container.decode(KeyframeGroup<Vector1D>.self, forKey: .positionY)
      self.position = nil
    } else if let positionKeyframes = try? container.decode(KeyframeGroup<Vector3D>.self, forKey: .position) {
      // Position dimensions are a single keyframe group.
      self.position = positionKeyframes
      self.positionX = nil
      self.positionY = nil
    } else if let positionContainer = try? container.nestedContainer(keyedBy: PositionCodingKeys.self, forKey: .position),
      let positionX = try? positionContainer.decode(KeyframeGroup<Vector1D>.self, forKey: .positionX),
      let positionY = try? positionContainer.decode(KeyframeGroup<Vector1D>.self, forKey: .positionY) {
      /// Position keyframes are split and nested.
      self.positionX = positionX
      self.positionY = positionY
      self.position = nil
    } else {
      /// Default value.
      self.position = KeyframeGroup(Vector3D(x: Double(0), y: 0, z: 0))
      self.positionX = nil
      self.positionY = nil
    }
    
    
    // Scale
    self.scale = try container.decodeIfPresent(KeyframeGroup<Vector3D>.self, forKey: .scale) ?? KeyframeGroup(Vector3D(x: Double(100), y: 100, z: 100))
    
    // Rotation
    if let rotationZ = try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .rotationZ) {
      self.rotation = rotationZ
    } else {
       self.rotation = try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .rotation) ?? KeyframeGroup(Vector1D(0))
    }
    self.rotationZ = nil
    
    // Opacity
    self.opacity = try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .opacity) ?? KeyframeGroup(Vector1D(100))
  }
    
    // sourcery:inline:Transform.AutoCoding
            /// :nodoc:
            required internal init?(coder aDecoder: NSCoder) {
                guard let anchorPoint: KeyframeGroup<Vector3D> = aDecoder.decode(forKey: "anchorPoint") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["anchorPoint"])); fatalError() }; self.anchorPoint = anchorPoint
                self.position = aDecoder.decode(forKey: "position")
                self.positionX = aDecoder.decode(forKey: "positionX")
                self.positionY = aDecoder.decode(forKey: "positionY")
                guard let scale: KeyframeGroup<Vector3D> = aDecoder.decode(forKey: "scale") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["scale"])); fatalError() }; self.scale = scale
                guard let rotation: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "rotation") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["rotation"])); fatalError() }; self.rotation = rotation
                guard let opacity: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "opacity") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["opacity"])); fatalError() }; self.opacity = opacity
                self.rotationZ = aDecoder.decode(forKey: "rotationZ")
            }

            /// :nodoc:
            internal func encode(with aCoder: NSCoder) {
                aCoder.encode(self.anchorPoint, forKey: "anchorPoint")
                aCoder.encode(self.position, forKey: "position")
                aCoder.encode(self.positionX, forKey: "positionX")
                aCoder.encode(self.positionY, forKey: "positionY")
                aCoder.encode(self.scale, forKey: "scale")
                aCoder.encode(self.rotation, forKey: "rotation")
                aCoder.encode(self.opacity, forKey: "opacity")
                aCoder.encode(self.rotationZ, forKey: "rotationZ")
            }
    // sourcery:end

}

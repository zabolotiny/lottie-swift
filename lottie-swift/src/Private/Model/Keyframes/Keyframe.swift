//
//  Keyframe.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/7/19.
//

import Foundation
import CoreGraphics

/**
 Keyframe represents a point in time and is the container for datatypes.
 Note: This is a parent class and should not be used directly.
 */
final public class Keyframe<T: Interpolatable>: NSObject, NSCoding, AutoCoding {
  
  /// The value of the keyframe
  let value: T
  /// The time in frames of the keyframe.
  let time: CGFloat
  /// A hold keyframe freezes interpolation until the next keyframe that is not a hold.
  let isHold: Bool
  /// The in tangent for the time interpolation curve.
  let inTangent: Vector2D?
  /// The out tangent for the time interpolation curve.
  let outTangent: Vector2D?
  
  /// The spacial in tangent of the vector.
  let spatialInTangent: Vector3D?
  /// The spacial out tangent of the vector.
  let spatialOutTangent: Vector3D?
  
  /// Initialize a value-only keyframe with no time data.
  init(_ value: T,
       spatialInTangent: Vector3D? = nil,
       spatialOutTangent: Vector3D? = nil) {
    self.value = value
    self.time = 0
    self.isHold = true
    self.inTangent = nil
    self.outTangent = nil
    self.spatialInTangent = spatialInTangent
    self.spatialOutTangent = spatialOutTangent
  }
  
  /// Initialize a keyframe
  init(value: T,
       time: Double,
       isHold: Bool,
       inTangent: Vector2D?,
       outTangent: Vector2D?,
       spatialInTangent: Vector3D? = nil,
       spatialOutTangent: Vector3D? = nil) {
    self.value = value
    self.time = CGFloat(time)
    self.isHold = isHold
    self.outTangent = outTangent
    self.inTangent = inTangent
    self.spatialInTangent = spatialInTangent
    self.spatialOutTangent = spatialOutTangent
  }
    
    /// :nodoc:
    required public init?(coder aDecoder: NSCoder) {
        guard let value: T = aDecoder.decode(forKey: "value") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["value"])); fatalError() }; self.value = value
        guard let time: CGFloat = aDecoder.decode(forKey: "time") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["time"])); fatalError() }; self.time = time
        self.isHold = aDecoder.decode(forKey: "isHold")
        self.inTangent = aDecoder.decode(forKey: "inTangent")
        self.outTangent = aDecoder.decode(forKey: "outTangent")
        self.spatialInTangent = aDecoder.decode(forKey: "spatialInTangent")
        self.spatialOutTangent = aDecoder.decode(forKey: "spatialOutTangent")
    }
    
    /// :nodoc:
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.value, forKey: "value")
        aCoder.encode(self.time, forKey: "time")
        aCoder.encode(self.isHold, forKey: "isHold")
        aCoder.encode(self.inTangent, forKey: "inTangent")
        aCoder.encode(self.outTangent, forKey: "outTangent")
        aCoder.encode(self.spatialInTangent, forKey: "spatialInTangent")
        aCoder.encode(self.spatialOutTangent, forKey: "spatialOutTangent")
    }
  
}

/**
 A generic class used to parse and remap keyframe json.
 
 Keyframe json has a couple of different variations and formats depending on the
 type of keyframea and also the version of the JSON. By parsing the raw data
 we can reconfigure it into a constant format.
 */
final public class KeyframeData<T: Codable>: Codable, NSCoding {
  
  /// The start value of the keyframe
  let startValue: T?
  /// The End value of the keyframe. Note: Newer versions animation json do not have this field.
  let endValue: T?
  /// The time in frames of the keyframe.
  let time: Double?
  /// A hold keyframe freezes interpolation until the next keyframe that is not a hold.
  let hold: Int?
  
  /// The in tangent for the time interpolation curve.
  let inTangent: Vector2D?
  /// The out tangent for the time interpolation curve.
  let outTangent: Vector2D?
  
  /// The spacial in tangent of the vector.
  let spatialInTangent: Vector3D?
  /// The spacial out tangent of the vector.
  let spatialOutTangent:Vector3D?
  
  init(startValue: T?,
       endValue: T?,
       time: Double?,
       hold: Int?,
       inTangent: Vector2D?,
       outTangent: Vector2D?,
       spatialInTangent: Vector3D?,
       spatialOutTangent: Vector3D?) {
    self.startValue = startValue
    self.endValue = endValue
    self.time = time
    self.hold = hold
    self.inTangent = inTangent
    self.outTangent = outTangent
    self.spatialInTangent = spatialInTangent
    self.spatialOutTangent = spatialOutTangent
  }
  
  enum CodingKeys : String, CodingKey {
    case startValue = "s"
    case endValue = "e"
    case time = "t"
    case hold = "h"
    case inTangent = "i"
    case outTangent = "o"
    case spatialInTangent = "ti"
    case spatialOutTangent = "to"
  }
  
  var isHold: Bool {
    if let hold = hold {
      return hold > 0
    }
    return false
  }
    
    /// :nodoc:
    public required init?(coder aDecoder: NSCoder) {
        self.startValue = aDecoder.decode(forKey: "startValue")
        self.endValue = aDecoder.decode(forKey: "endValue")
        self.time = aDecoder.decode(forKey: "time")
        self.hold = aDecoder.decode(forKey: "hold")
        self.inTangent = aDecoder.decode(forKey: "inTangent")
        self.outTangent = aDecoder.decode(forKey: "outTangent")
        self.spatialInTangent = aDecoder.decode(forKey: "spatialInTangent")
        self.spatialOutTangent = aDecoder.decode(forKey: "spatialOutTangent")
    }

    /// :nodoc:
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.startValue, forKey: "startValue")
        aCoder.encode(self.endValue, forKey: "endValue")
        aCoder.encode(self.time, forKey: "time")
        aCoder.encode(self.hold, forKey: "hold")
        aCoder.encode(self.inTangent, forKey: "inTangent")
        aCoder.encode(self.outTangent, forKey: "outTangent")
        aCoder.encode(self.spatialInTangent, forKey: "spatialInTangent")
        aCoder.encode(self.spatialOutTangent, forKey: "spatialOutTangent")
    }
}

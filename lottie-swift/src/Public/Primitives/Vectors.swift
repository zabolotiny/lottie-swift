//
//  Vectors.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 2/4/19.
//

import Foundation

final public class Vector1D: NSObject, NSCoding, AutoCoding {
  
  public init(_ value: Double) {
    self.value = value
  }
    /// :nodoc:
    required public init?(coder aDecoder: NSCoder) {
            self.value = aDecoder.decode(forKey: "value")
        }

        /// :nodoc:
    public func encode(with aCoder: NSCoder) {
            aCoder.encode(self.value, forKey: "value")
        }
    // sourcery:end
  
  let value: Double
    
    required public init(from decoder: Decoder) throws {
    /// Try to decode an array of doubles
    do {
      var container = try decoder.unkeyedContainer()
      self.value = try container.decode(Double.self)
    } catch {
      self.value = try decoder.singleValueContainer().decode(Double.self)
    }
  }
}


/**
 A three dimensional vector.
 These vectors are encoded and decoded from [Double]
 */
final public class Vector3D: NSObject, NSCoding {
  
  var x: Double
  var y: Double
  var z: Double
  
  public init(x: Double, y: Double, z: Double) {
    self.x = x
    self.y = y
    self.z = z
  }
  
    init(x: CGFloat, y: CGFloat, z: CGFloat) {
        self.x = Double(x)
        self.y = Double(y)
        self.z = Double(z)
    }
    
    /// :nodoc:
        required public init?(coder aDecoder: NSCoder) {
            self.x = aDecoder.decode(forKey: "x")
            self.y = aDecoder.decode(forKey: "y")
            self.z = aDecoder.decode(forKey: "z")
        }

        /// :nodoc:
        public func encode(with aCoder: NSCoder) {
            aCoder.encode(self.x, forKey: "x")
            aCoder.encode(self.y, forKey: "y")
            aCoder.encode(self.z, forKey: "z")
        }
    // sourcery:end
    
    required public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
        if !container.isAtEnd {
            self.x = try container.decode(Double.self)
        } else {
            self.x = 0
        }
        
        if !container.isAtEnd {
            self.y = try container.decode(Double.self)
        } else {
            self.y = 0
        }
        
        if !container.isAtEnd {
            self.z = try container.decode(Double.self)
        } else {
            self.z = 0
        }
    }
}

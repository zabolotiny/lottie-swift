//
//  Marker.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/9/19.
//

import Foundation

/// A time marker
final class Marker: Codable, NSCoding {
  
  /// The Marker Name
  let name: String
  
  /// The Frame time of the marker
  let frameTime: AnimationFrameTime
  
  enum CodingKeys : String, CodingKey {
    case name = "cm"
    case frameTime = "tm"
  }
    
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let name: String = aDecoder.decode(forKey: "name") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["name"])); fatalError() }; self.name = name
        guard let frameTime: AnimationFrameTime = aDecoder.decode(forKey: "frameTime") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["frameTime"])); fatalError() }; self.frameTime = frameTime
    }

    /// :nodoc:
    internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.frameTime, forKey: "frameTime")
    }
}

//
//  DashPattern.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/22/19.
//

import Foundation

enum DashElementType: String, Codable, AutoCoding {
  case offset = "o"
  case dash = "d"
  case gap = "g"
}

final class DashElement: Codable, NSCoding {
  let type: DashElementType
  let value: KeyframeGroup<Vector1D>
  
  enum CodingKeys : String, CodingKey {
    case type = "n"
    case value = "v"
  }
    
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let type: DashElementType = DashElementType(rawValue: aDecoder.decode(forKey: "type")!) else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["type"])); fatalError() }; self.type = type
        guard let value: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "value") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["value"])); fatalError() }; self.value = value
    }

    /// :nodoc:
    internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.type.rawValue, forKey: "type")
        aCoder.encode(self.value, forKey: "value")
    }
}

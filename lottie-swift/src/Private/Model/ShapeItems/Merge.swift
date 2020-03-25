//
//  Merge.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/8/19.
//

import Foundation

enum MergeMode: Int, Codable, AutoCoding {
  case none
  case merge
  case add
  case subtract
  case intersect
  case exclude
}

/// An item that define an ellipse shape
final class Merge: ShapeItem {
  
  /// The mode of the merge path
  let mode: MergeMode
  
  private enum CodingKeys : String, CodingKey {
    case mode = "mm"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Merge.CodingKeys.self)
    self.mode = try container.decode(MergeMode.self, forKey: .mode)
    try super.init(from: decoder)
  }
  
  override func encode(to encoder: Encoder) throws {
    try super.encode(to: encoder)
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(mode, forKey: .mode)
  }
    
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let mode: MergeMode = MergeMode(rawValue: aDecoder.decode(forKey: "mode")) else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["mode"])); fatalError() }; self.mode = mode
        super.init(coder: aDecoder)
    }

    /// :nodoc:
    override internal func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(self.mode.rawValue, forKey: "mode")
    }
  
}

//
//  PreCompLayer.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/8/19.
//

import Foundation

/// A layer that holds another animation composition.
final class PreCompLayerModel: LayerModel {
  
  /// The reference ID of the precomp.
  let referenceID: String
  
  /// A value that remaps time over time.
  let timeRemapping: KeyframeGroup<Vector1D>?
  
  /// Precomp Width
  let width: Double
  
  /// Precomp Height
  let height: Double
  
  private enum CodingKeys : String, CodingKey {
    case referenceID = "refId"
    case timeRemapping = "tm"
    case width = "w"
    case height = "h"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: PreCompLayerModel.CodingKeys.self)
    self.referenceID = try container.decode(String.self, forKey: .referenceID)
    self.timeRemapping = try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .timeRemapping)
    self.width = try container.decode(Double.self, forKey: .width)
    self.height = try container.decode(Double.self, forKey: .height)
    try super.init(from: decoder)
  }
  
  override func encode(to encoder: Encoder) throws {
    try super.encode(to: encoder)
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(referenceID, forKey: .referenceID)
    try container.encode(timeRemapping, forKey: .timeRemapping)
    try container.encode(width, forKey: .width)
    try container.encode(height, forKey: .height)
  }
    
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let referenceID: String = aDecoder.decode(forKey: "referenceID") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["referenceID"])); fatalError() }; self.referenceID = referenceID
        self.timeRemapping = aDecoder.decode(forKey: "timeRemapping")
        self.width = aDecoder.decode(forKey: "width")
        self.height = aDecoder.decode(forKey: "height")
        super.init(coder: aDecoder)
    }

    /// :nodoc:
    override internal func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(self.referenceID, forKey: "referenceID")
        aCoder.encode(self.timeRemapping, forKey: "timeRemapping")
        aCoder.encode(self.width, forKey: "width")
        aCoder.encode(self.height, forKey: "height")
    }
  
}

//
//  ImageLayer.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/8/19.
//

import Foundation

/// A layer that holds an image.
final class ImageLayerModel: LayerModel {
  
  /// The reference ID of the image.
  let referenceID: String
  
  private enum CodingKeys : String, CodingKey {
    case referenceID = "refId"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: ImageLayerModel.CodingKeys.self)
    self.referenceID = try container.decode(String.self, forKey: .referenceID)
    try super.init(from: decoder)
  }
  
  override func encode(to encoder: Encoder) throws {
    try super.encode(to: encoder)
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(referenceID, forKey: .referenceID)
  }
    
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let referenceID: String = aDecoder.decode(forKey: "referenceID") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["referenceID"])); fatalError() }; self.referenceID = referenceID
        super.init(coder: aDecoder)
    }

    /// :nodoc:
    override internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.index, forKey: "index")
        aCoder.encode(self.type.rawValue, forKey: "type")
        aCoder.encode(self.coordinateSpace.rawValue, forKey: "coordinateSpace")
        aCoder.encode(self.inFrame, forKey: "inFrame")
        aCoder.encode(self.outFrame, forKey: "outFrame")
        aCoder.encode(self.startTime, forKey: "startTime")
        aCoder.encode(self.transform, forKey: "transform")
        aCoder.encode(self.parent, forKey: "parent")
        aCoder.encode(self.blendMode.rawValue, forKey: "blendMode")
        aCoder.encode(self.masks, forKey: "masks")
        aCoder.encode(self.timeStretch, forKey: "timeStretch")
        aCoder.encode(self.matte?.rawValue ?? 99, forKey: "matte")
        aCoder.encode(self.hidden, forKey: "hidden")
        aCoder.encode(self.referenceID, forKey: "referenceID")
    }
  
}

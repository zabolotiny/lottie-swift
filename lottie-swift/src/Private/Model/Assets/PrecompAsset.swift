//
//  PrecompAsset.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/9/19.
//

import Foundation

final class PrecompAsset: Asset {
  
  /// Layers of the precomp
  let layers: [LayerModel]
  
  enum CodingKeys : String, CodingKey {
    case layers = "layers"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: PrecompAsset.CodingKeys.self)
    self.layers = try container.decode([LayerModel].self, ofFamily: LayerType.self, forKey: .layers)
    try super.init(from: decoder)
  }
  
  override func encode(to encoder: Encoder) throws {
    try super.encode(to: encoder)
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(layers, forKey: .layers)
  }
    
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let layers: [LayerModel] = aDecoder.decode(forKey: "layers") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["layers"])); fatalError() }; self.layers = layers
        super.init(coder: aDecoder)
    }

    /// :nodoc:
    override internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.layers, forKey: "layers")
    }
}

//
//  AssetLibrary.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/9/19.
//

import Foundation

final class AssetLibrary: NSObject, Codable, NSCoding {
  
  /// The Assets
  let assets: [String : Asset]
  
  let imageAssets: [String : ImageAsset]
  let precompAssets: [String : PrecompAsset]
  
  required init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    var containerForKeys = container
    
    var decodedAssets = [String : Asset]()
    
    var imageAssets = [String : ImageAsset]()
    var precompAssets = [String : PrecompAsset]()
    
    while !container.isAtEnd {
      let keyContainer = try containerForKeys.nestedContainer(keyedBy: PrecompAsset.CodingKeys.self)
      if keyContainer.contains(.layers) {
        let precompAsset = try container.decode(PrecompAsset.self)
        decodedAssets[precompAsset.id] = precompAsset
        precompAssets[precompAsset.id] = precompAsset
      } else {
        let imageAsset = try container.decode(ImageAsset.self)
        decodedAssets[imageAsset.id] = imageAsset
        imageAssets[imageAsset.id] = imageAsset
      }
    }
    self.assets = decodedAssets
    self.precompAssets = precompAssets
    self.imageAssets = imageAssets
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    try container.encode(contentsOf: Array(assets.values))
  }

    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let assets: [String : Asset] = aDecoder.decode(forKey: "assets") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["assets"])); fatalError() }; self.assets = assets
        guard let imageAssets: [String : ImageAsset] = aDecoder.decode(forKey: "imageAssets") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["imageAssets"])); fatalError() }; self.imageAssets = imageAssets
        guard let precompAssets: [String : PrecompAsset] = aDecoder.decode(forKey: "precompAssets") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["precompAssets"])); fatalError() }; self.precompAssets = precompAssets
    }

    /// :nodoc:
    internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.assets, forKey: "assets")
        aCoder.encode(self.imageAssets, forKey: "imageAssets")
        aCoder.encode(self.precompAssets, forKey: "precompAssets")
    }
}

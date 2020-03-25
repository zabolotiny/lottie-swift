//
//  Layer.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/7/19.
//

import Foundation

/// Used for mapping a heterogeneous list to classes for parsing.
extension LayerType: ClassFamily {
  static var discriminator: Discriminator = .type
  
  func getType() -> AnyObject.Type {
    switch self {
    case .precomp:
      return PreCompLayerModel.self
    case .solid:
      return SolidLayerModel.self
    case .image:
      return ImageLayerModel.self
    case .null:
      return LayerModel.self
    case .shape:
      return ShapeLayerModel.self
    case .text:
      return TextLayerModel.self
    }
  }
}

public enum LayerType: Int, Codable, AutoCoding {
  case precomp
  case solid
  case image
  case null
  case shape
  case text
  
  public init(from decoder: Decoder) throws {
    self = try LayerType(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .null
  }
}

public enum MatteType: Int, Codable, AutoCoding {
  case none
  case add
  case invert
  case unknown
}

public enum BlendMode: Int, Codable, AutoCoding {
  case normal
  case multiply
  case screen
  case overlay
  case darken
  case lighten
  case colorDodge
  case colorBurn
  case hardLight
  case softLight
  case difference
  case exclusion
  case hue
  case saturation
  case color
  case luminosity
}

/**
 A base top container for shapes, images, and other view objects.
 */
class LayerModel: NSObject, Codable, NSCoding {
  
  /// The readable name of the layer
  let name: String
  
  /// The index of the layer
  let index: Int
  
  /// The type of the layer.
  let type: LayerType
  
  /// The coordinate space
  let coordinateSpace: CoordinateSpace
  
  /// The in time of the layer in frames.
  let inFrame: Double
  /// The out time of the layer in frames.
  let outFrame: Double
  
  /// The start time of the layer in frames.
  let startTime: Double
  
  /// The transform of the layer
  let transform: Transform
  
  /// The index of the parent layer, if applicable.
  let parent: Int?
  
  /// The blending mode for the layer
  let blendMode: BlendMode
  
  /// An array of masks for the layer.
  let masks: [Mask]?
  
  /// A number that stretches time by a multiplier
  let timeStretch: Double
  
  /// The type of matte if any.
  let matte: MatteType?
  
  let hidden: Bool
  
  private enum CodingKeys : String, CodingKey {
    case name = "nm"
    case index = "ind"
    case type = "ty"
    case coordinateSpace = "ddd"
    case inFrame = "ip"
    case outFrame = "op"
    case startTime = "st"
    case transform = "ks"
    case parent = "parent"
    case blendMode = "bm"
    case masks = "masksProperties"
    case timeStretch = "sr"
    case matte = "tt"
    case hidden = "hd"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: LayerModel.CodingKeys.self)
    self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Layer"
    self.index = try container.decode(Int.self, forKey: .index)
    self.type = try container.decode(LayerType.self, forKey: .type)
    self.coordinateSpace = try container.decodeIfPresent(CoordinateSpace.self, forKey: .coordinateSpace) ?? .type2d
    self.inFrame = try container.decode(Double.self, forKey: .inFrame)
    self.outFrame = try container.decode(Double.self, forKey: .outFrame)
    self.startTime = try container.decode(Double.self, forKey: .startTime)
    self.transform = try container.decode(Transform.self, forKey: .transform)
    self.parent = try container.decodeIfPresent(Int.self, forKey: .parent)
    self.blendMode = try container.decodeIfPresent(BlendMode.self, forKey: .blendMode) ?? .normal
    self.masks = try container.decodeIfPresent([Mask].self, forKey: .masks)
    self.timeStretch = try container.decodeIfPresent(Double.self, forKey: .timeStretch) ?? 1
    self.matte = try container.decodeIfPresent(MatteType.self, forKey: .matte)
    self.hidden = try container.decodeIfPresent(Bool.self, forKey: .hidden) ?? false
  }
    
    // sourcery:inline:LayerModel.AutoCoding
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let name: String = aDecoder.decode(forKey: "name") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["name"])); fatalError() }; self.name = name
        self.index = aDecoder.decode(forKey: "index")
        guard let type: LayerType = LayerType(rawValue: aDecoder.decode(forKey: "type")) else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["type"])); fatalError() }; self.type = type
        guard let coordinateSpace: CoordinateSpace = CoordinateSpace(rawValue: aDecoder.decode(forKey: "coordinateSpace")) else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["coordinateSpace"])); fatalError() }; self.coordinateSpace = coordinateSpace
        self.inFrame = aDecoder.decode(forKey: "inFrame")
        self.outFrame = aDecoder.decode(forKey: "outFrame")
        self.startTime = aDecoder.decode(forKey: "startTime")
        guard let transform: Transform = aDecoder.decode(forKey: "transform") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["transform"])); fatalError() }; self.transform = transform
        self.parent = aDecoder.decode(forKey: "parent")
        guard let blendMode: BlendMode = BlendMode(rawValue: aDecoder.decode(forKey: "blendMode")) else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["blendMode"])); fatalError() }; self.blendMode = blendMode
        self.masks = aDecoder.decode(forKey: "masks")
        self.timeStretch = aDecoder.decode(forKey: "timeStretch")
        let matteRaw: Int = aDecoder.decode(forKey: "matte")
        self.matte = MatteType(rawValue: matteRaw)
        self.hidden = aDecoder.decode(forKey: "hidden")
    }

    /// :nodoc:
    internal func encode(with aCoder: NSCoder) {
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
    }
}

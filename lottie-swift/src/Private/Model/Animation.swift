//
//  Animation.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/7/19.
//

import Foundation

public enum CoordinateSpace: Int, Codable, AutoCoding {
  case type2d
  case type3d
}

/**
 The `Animation` model is the top level model object in Lottie.
 
 An `Animation` holds all of the animation data backing a Lottie Animation.
 Codable, see JSON schema [here](https://github.com/airbnb/lottie-web/tree/master/docs/json).
 */
public final class Animation: NSObject, Codable, NSCoding {
  
  /// The version of the JSON Schema.
  let version: String
  
  /// The coordinate space of the composition.
  let type: CoordinateSpace
  
  /// The start time of the composition in frameTime.
  public let startFrame: AnimationFrameTime
  
  /// The end time of the composition in frameTime.
  public let endFrame: AnimationFrameTime
  
  /// The frame rate of the composition.
  public let framerate: Double
  
  /// The height of the composition in points.
  let width: Int
  
  /// The width of the composition in points.
  let height: Int
  
  /// The list of animation layers
  let layers: [LayerModel]
  
  /// The list of glyphs used for text rendering
  let glyphs: [Glyph]?
  
  /// The list of fonts used for text rendering
  let fonts: FontList?
  
  /// Asset Library
  let assetLibrary: AssetLibrary?
  
  /// Markers
  let markers: [Marker]?
  let markerMap: [String : Marker]?
  
  /// Return all marker names, in order, or an empty list if none are specified
  public var markerNames: [String] {
    guard let markers = markers else { return [] }
    return markers.map { $0.name }
  }
  
  enum CodingKeys : String, CodingKey {
    case version = "v"
    case type = "ddd"
    case startFrame = "ip"
    case endFrame = "op"
    case framerate = "fr"
    case width = "w"
    case height = "h"
    case layers = "layers"
    case glyphs = "chars"
    case fonts = "fonts"
    case assetLibrary = "assets"
    case markers = "markers"
  }
  
  required public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Animation.CodingKeys.self)
    self.version = try container.decode(String.self, forKey: .version)
    self.type = try container.decodeIfPresent(CoordinateSpace.self, forKey: .type) ?? .type2d
    self.startFrame = try container.decode(AnimationFrameTime.self, forKey: .startFrame)
    self.endFrame = try container.decode(AnimationFrameTime.self, forKey: .endFrame)
    self.framerate = try container.decode(Double.self, forKey: .framerate)
    self.width = try container.decode(Int.self, forKey: .width)
    self.height = try container.decode(Int.self, forKey: .height)
    self.layers = try container.decode([LayerModel].self, ofFamily: LayerType.self, forKey: .layers)
    self.glyphs = try container.decodeIfPresent([Glyph].self, forKey: .glyphs)
    self.fonts = try container.decodeIfPresent(FontList.self, forKey: .fonts)
    self.assetLibrary = try container.decodeIfPresent(AssetLibrary.self, forKey: .assetLibrary)
    self.markers = try container.decodeIfPresent([Marker].self, forKey: .markers)
    
    if let markers = markers {
      var markerMap: [String : Marker] = [:]
      for marker in markers {
        markerMap[marker.name] = marker
      }
      self.markerMap = markerMap
    } else {
      self.markerMap = nil
    }
  }
    
    /// :nodoc:
    required public init?(coder aDecoder: NSCoder) {
        guard let version: String = aDecoder.decode(forKey: "version") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["version"])); fatalError() }; self.version = version
        guard let type: CoordinateSpace = CoordinateSpace(rawValue: aDecoder.decode(forKey: "type"))  else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["type"])); fatalError() }; self.type = type
        guard let startFrame: AnimationFrameTime = aDecoder.decode(forKey: "startFrame") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["startFrame"])); fatalError() }; self.startFrame = startFrame
        guard let endFrame: AnimationFrameTime = aDecoder.decode(forKey: "endFrame") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["endFrame"])); fatalError() }; self.endFrame = endFrame
        self.framerate = aDecoder.decodeDouble(forKey: "framerate")
        self.width = aDecoder.decode(forKey: "width")
        self.height = aDecoder.decode(forKey: "height")
        guard let layers: [LayerModel] = aDecoder.decode(forKey: "layers") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["layers"])); fatalError() }; self.layers = layers
        self.glyphs = aDecoder.decode(forKey: "glyphs")
        self.fonts = aDecoder.decode(forKey: "fonts")
        self.assetLibrary = aDecoder.decode(forKey: "assetLibrary")
        self.markers = aDecoder.decode(forKey: "markers")
        self.markerMap = aDecoder.decode(forKey: "markerMap")
    }

    /// :nodoc:
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.version, forKey: "version")
        aCoder.encode(self.type.rawValue, forKey: "type")
        aCoder.encode(self.startFrame, forKey: "startFrame")
        aCoder.encode(self.endFrame, forKey: "endFrame")
        aCoder.encode(self.framerate, forKey: "framerate")
        aCoder.encode(self.width, forKey: "width")
        aCoder.encode(self.height, forKey: "height")
        aCoder.encode(self.layers, forKey: "layers")
        aCoder.encode(self.glyphs, forKey: "glyphs")
        aCoder.encode(self.fonts, forKey: "fonts")
        aCoder.encode(self.assetLibrary, forKey: "assetLibrary")
        aCoder.encode(self.markers, forKey: "markers")
        aCoder.encode(self.markerMap, forKey: "markerMap")
    }

}

extension NSCoder {

    @nonobjc func decode(forKey: String) -> String? {
        return self.maybeDecode(forKey: forKey) as String?
    }

//    @nonobjc func decode(forKey: String) -> TypeName? {
//        return self.maybeDecode(forKey: forKey) as TypeName?
//    }
//
//    @nonobjc func decode(forKey: String) -> AccessLevel? {
//        return self.maybeDecode(forKey: forKey) as AccessLevel?
//    }

    @nonobjc func decode(forKey: String) -> Bool {
        return self.decodeBool(forKey: forKey)
    }

    @nonobjc func decode(forKey: String) -> Int {
        return self.decodeInteger(forKey: forKey)
    }
    
    @nonobjc func decode(forKey: String) -> Double {
        return self.decodeDouble(forKey: forKey)
    }

    func decode<E>(forKey: String) -> E? {
        return maybeDecode(forKey: forKey) as E?
    }

    fileprivate func maybeDecode<E>(forKey: String) -> E? {
        guard let object = self.decodeObject(forKey: forKey) else {
            return nil
        }

        return object as? E
    }
    

}

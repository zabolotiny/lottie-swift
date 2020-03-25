//
//  TextLayer.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/8/19.
//

import Foundation

/// A layer that holds text.
final class TextLayerModel: LayerModel {

  /// The text for the layer
  let text: KeyframeGroup<TextDocument>
  
  /// Text animators
  let animators: [TextAnimator]
  
  private enum CodingKeys : String, CodingKey {
    case textGroup = "t"
  }
  
  private enum TextCodingKeys : String, CodingKey {
    case text = "d"
    case animators = "a"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: TextLayerModel.CodingKeys.self)
    let textContainer = try container.nestedContainer(keyedBy: TextCodingKeys.self, forKey: .textGroup)
    self.text = try textContainer.decode(KeyframeGroup<TextDocument>.self, forKey: .text)
    self.animators = try textContainer.decode([TextAnimator].self, forKey: .animators)
    try super.init(from: decoder)
  }
  
  override func encode(to encoder: Encoder) throws {
    try super.encode(to: encoder)
    var container = encoder.container(keyedBy: CodingKeys.self)
    var textContainer = container.nestedContainer(keyedBy: TextCodingKeys.self, forKey: .textGroup)
    try textContainer.encode(text, forKey: .text)
    try textContainer.encode(animators, forKey: .animators)
  }
    
    // sourcery:inline:TextLayerModel.AutoCoding
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let text: KeyframeGroup<TextDocument> = aDecoder.decode(forKey: "text") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["text"])); fatalError() }; self.text = text
        guard let animators: [TextAnimator] = aDecoder.decode(forKey: "animators") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["animators"])); fatalError() }; self.animators = animators
        super.init(coder: aDecoder)
    }
    
    /// :nodoc:
    internal override func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.index, forKey: "index")
        aCoder.encode(self.type, forKey: "type")
        aCoder.encode(self.coordinateSpace, forKey: "coordinateSpace")
        aCoder.encode(self.inFrame, forKey: "inFrame")
        aCoder.encode(self.outFrame, forKey: "outFrame")
        aCoder.encode(self.startTime, forKey: "startTime")
        aCoder.encode(self.transform, forKey: "transform")
        aCoder.encode(self.parent, forKey: "parent")
        aCoder.encode(self.blendMode, forKey: "blendMode")
        aCoder.encode(self.masks, forKey: "masks")
        aCoder.encode(self.timeStretch, forKey: "timeStretch")
        aCoder.encode(self.matte?.rawValue ?? 99, forKey: "matte")
        aCoder.encode(self.hidden, forKey: "hidden")
        aCoder.encode(self.text, forKey: "text")
        aCoder.encode(self.animators, forKey: "animators")
    }
    // sourcery:end
  
}

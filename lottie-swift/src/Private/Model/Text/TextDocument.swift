//
//  TextDocument.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/9/19.
//

import Foundation

enum TextJustification: Int, Codable, AutoCoding {
  case left
  case right
  case center
}

final class TextDocument: Codable, NSCoding {
  
  /// The Text
  let text: String
  
  /// The Font size
  let fontSize: Double
  
  /// The Font Family
  let fontFamily: String
  
  /// Justification
  let justification: TextJustification
  
  /// Tracking
  let tracking: Int
  
  /// Line Height
  let lineHeight: Double
  
  /// Baseline
  let baseline: Double?
  
  /// Fill Color data
  let fillColorData: Color
  
  /// Scroke Color data
  let strokeColorData: Color?
  
  /// Stroke Width
  let strokeWidth: Double?
  
  /// Stroke Over Fill
  let strokeOverFill: Bool?
  
  let textFramePosition: Vector3D?
  
  let textFrameSize: Vector3D?
  
  private enum CodingKeys : String, CodingKey {
    case text = "t"
    case fontSize = "s"
    case fontFamily = "f"
    case justification = "j"
    case tracking = "tr"
    case lineHeight = "lh"
    case baseline = "ls"
    case fillColorData = "fc"
    case strokeColorData = "sc"
    case strokeWidth = "sw"
    case strokeOverFill = "of"
    case textFramePosition = "ps"
    case textFrameSize = "sz"
  }
    
    required internal init?(coder aDecoder: NSCoder) {
            guard let text: String = aDecoder.decode(forKey: "text") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["text"])); fatalError() }; self.text = text
            self.fontSize = aDecoder.decode(forKey: "fontSize")
            guard let fontFamily: String = aDecoder.decode(forKey: "fontFamily") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["fontFamily"])); fatalError() }; self.fontFamily = fontFamily
            guard let justification: TextJustification = aDecoder.decode(forKey: "justification") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["justification"])); fatalError() }; self.justification = justification
            self.tracking = aDecoder.decode(forKey: "tracking")
            self.lineHeight = aDecoder.decode(forKey: "lineHeight")
            self.baseline = aDecoder.decode(forKey: "baseline")
            guard let fillColorData: Color = aDecoder.decode(forKey: "fillColorData") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["fillColorData"])); fatalError() }; self.fillColorData = fillColorData
            self.strokeColorData = aDecoder.decode(forKey: "strokeColorData")
            self.strokeWidth = aDecoder.decode(forKey: "strokeWidth")
            self.strokeOverFill = aDecoder.decode(forKey: "strokeOverFill")
            self.textFramePosition = aDecoder.decode(forKey: "textFramePosition")
            self.textFrameSize = aDecoder.decode(forKey: "textFrameSize")
        }

        /// :nodoc:
        internal func encode(with aCoder: NSCoder) {
            aCoder.encode(self.text, forKey: "text")
            aCoder.encode(self.fontSize, forKey: "fontSize")
            aCoder.encode(self.fontFamily, forKey: "fontFamily")
            aCoder.encode(self.justification, forKey: "justification")
            aCoder.encode(self.tracking, forKey: "tracking")
            aCoder.encode(self.lineHeight, forKey: "lineHeight")
            aCoder.encode(self.baseline, forKey: "baseline")
            aCoder.encode(self.fillColorData, forKey: "fillColorData")
            aCoder.encode(self.strokeColorData, forKey: "strokeColorData")
            aCoder.encode(self.strokeWidth, forKey: "strokeWidth")
            aCoder.encode(self.strokeOverFill, forKey: "strokeOverFill")
            aCoder.encode(self.textFramePosition, forKey: "textFramePosition")
            aCoder.encode(self.textFrameSize, forKey: "textFrameSize")
        }
}

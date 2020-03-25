//
//  Font.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/9/19.
//

import Foundation

final class Font: Codable, NSCoding {
  
  let name: String
  let familyName: String
  let style: String
  let ascent: Double
  
  private enum CodingKeys: String, CodingKey {
    case name = "fName"
    case familyName = "fFamily"
    case style = "fStyle"
    case ascent = "ascent"
  }
    
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let name: String = aDecoder.decode(forKey: "name") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["name"])); fatalError() }; self.name = name
        guard let familyName: String = aDecoder.decode(forKey: "familyName") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["familyName"])); fatalError() }; self.familyName = familyName
        guard let style: String = aDecoder.decode(forKey: "style") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["style"])); fatalError() }; self.style = style
        self.ascent = aDecoder.decode(forKey: "ascent")
    }

    /// :nodoc:
    internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.familyName, forKey: "familyName")
        aCoder.encode(self.style, forKey: "style")
        aCoder.encode(self.ascent, forKey: "ascent")
    }
  
}

/// A list of fonts
final class FontList: Codable, NSCoding {
  
  let fonts: [Font]
  
  enum CodingKeys : String, CodingKey {
    case fonts = "list"
  }
    
    // sourcery:inline:FontList.AutoCoding
    /// :nodoc:
    required internal init?(coder aDecoder: NSCoder) {
        guard let fonts: [Font] = aDecoder.decode(forKey: "fonts") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["fonts"])); fatalError() }; self.fonts = fonts
    }

    /// :nodoc:
    internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.fonts, forKey: "fonts")
    }
  
}

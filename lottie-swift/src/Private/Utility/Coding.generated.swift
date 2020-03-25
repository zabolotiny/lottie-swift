// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable vertical_whitespace trailing_newline

import Foundation


extension NSCoder {

    @nonobjc func decode(forKey: String) -> String? {
        return self.maybeDecode(forKey: forKey) as String?
    }

    @nonobjc func decode(forKey: String) -> TypeName? {
        return self.maybeDecode(forKey: forKey) as TypeName?
    }

    @nonobjc func decode(forKey: String) -> AccessLevel? {
        return self.maybeDecode(forKey: forKey) as AccessLevel?
    }

    @nonobjc func decode(forKey: String) -> Bool {
        return self.decodeBool(forKey: forKey)
    }

    @nonobjc func decode(forKey: String) -> Int {
        return self.decodeInteger(forKey: forKey)
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

extension BezierPath: NSCoding {}
    // sourcery:inline:BezierPath.AutoCoding
        /// :nodoc:
        required internal init?(coder aDecoder: NSCoder) {
            guard let elements: [PathElement] = aDecoder.decode(forKey: "elements") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["elements"])); fatalError() }; self.elements = elements
            self.closed = aDecoder.decode(forKey: "closed")
            guard let length: CGFloat = aDecoder.decode(forKey: "length") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["length"])); fatalError() }; self.length = length
        }

        /// :nodoc:
        internal func encode(with aCoder: NSCoder) {
            aCoder.encode(self.elements, forKey: "elements")
            aCoder.encode(self.closed, forKey: "closed")
            aCoder.encode(self.length, forKey: "length")
        }
    // sourcery:end
extension Color: NSCoding {}
    // sourcery:inline:Color.AutoCoding
        /// :nodoc:
        required public init?(coder aDecoder: NSCoder) {
            guard let r: Double = aDecoder.decode(forKey: "r") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["r"])); fatalError() }; self.r = r
            guard let g: Double = aDecoder.decode(forKey: "g") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["g"])); fatalError() }; self.g = g
            guard let b: Double = aDecoder.decode(forKey: "b") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["b"])); fatalError() }; self.b = b
            guard let a: Double = aDecoder.decode(forKey: "a") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["a"])); fatalError() }; self.a = a
        }

        /// :nodoc:
        public func encode(with aCoder: NSCoder) {
            aCoder.encode(self.r, forKey: "r")
            aCoder.encode(self.g, forKey: "g")
            aCoder.encode(self.b, forKey: "b")
            aCoder.encode(self.a, forKey: "a")
        }
    // sourcery:end
extension Keyframe: NSCoding {}
    // sourcery:inline:Keyframe.AutoCoding
        /// :nodoc:
        required internal init?(coder aDecoder: NSCoder) {
            guard let value: T = aDecoder.decode(forKey: "value") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["value"])); fatalError() }; self.value = value
            guard let time: CGFloat = aDecoder.decode(forKey: "time") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["time"])); fatalError() }; self.time = time
            self.isHold = aDecoder.decode(forKey: "isHold")
            self.inTangent = aDecoder.decode(forKey: "inTangent")
            self.outTangent = aDecoder.decode(forKey: "outTangent")
            self.spatialInTangent = aDecoder.decode(forKey: "spatialInTangent")
            self.spatialOutTangent = aDecoder.decode(forKey: "spatialOutTangent")
        }

        /// :nodoc:
        internal func encode(with aCoder: NSCoder) {
            aCoder.encode(self.value, forKey: "value")
            aCoder.encode(self.time, forKey: "time")
            aCoder.encode(self.isHold, forKey: "isHold")
            aCoder.encode(self.inTangent, forKey: "inTangent")
            aCoder.encode(self.outTangent, forKey: "outTangent")
            aCoder.encode(self.spatialInTangent, forKey: "spatialInTangent")
            aCoder.encode(self.spatialOutTangent, forKey: "spatialOutTangent")
        }
    // sourcery:end
extension Stroke: NSCoding {}
    // sourcery:inline:Stroke.AutoCoding
        /// :nodoc:
        required internal init?(coder aDecoder: NSCoder) {
            guard let opacity: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "opacity") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["opacity"])); fatalError() }; self.opacity = opacity
            guard let color: KeyframeGroup<Color> = aDecoder.decode(forKey: "color") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["color"])); fatalError() }; self.color = color
            guard let width: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "width") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["width"])); fatalError() }; self.width = width
            guard let lineCap: LineCap = aDecoder.decode(forKey: "lineCap") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["lineCap"])); fatalError() }; self.lineCap = lineCap
            guard let lineJoin: LineJoin = aDecoder.decode(forKey: "lineJoin") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["lineJoin"])); fatalError() }; self.lineJoin = lineJoin
            guard let miterLimit: Double = aDecoder.decode(forKey: "miterLimit") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["miterLimit"])); fatalError() }; self.miterLimit = miterLimit
            self.dashPattern = aDecoder.decode(forKey: "dashPattern")
        }

        /// :nodoc:
        internal func encode(with aCoder: NSCoder) {
            aCoder.encode(self.opacity, forKey: "opacity")
            aCoder.encode(self.color, forKey: "color")
            aCoder.encode(self.width, forKey: "width")
            aCoder.encode(self.lineCap, forKey: "lineCap")
            aCoder.encode(self.lineJoin, forKey: "lineJoin")
            aCoder.encode(self.miterLimit, forKey: "miterLimit")
            aCoder.encode(self.dashPattern, forKey: "dashPattern")
        }
    // sourcery:end
extension Trim: NSCoding {}
    // sourcery:inline:Trim.AutoCoding
        /// :nodoc:
        required internal init?(coder aDecoder: NSCoder) {
            guard let start: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "start") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["start"])); fatalError() }; self.start = start
            guard let end: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "end") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["end"])); fatalError() }; self.end = end
            guard let offset: KeyframeGroup<Vector1D> = aDecoder.decode(forKey: "offset") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["offset"])); fatalError() }; self.offset = offset
            guard let trimType: TrimType = aDecoder.decode(forKey: "trimType") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["trimType"])); fatalError() }; self.trimType = trimType
        }

        /// :nodoc:
        internal func encode(with aCoder: NSCoder) {
            aCoder.encode(self.start, forKey: "start")
            aCoder.encode(self.end, forKey: "end")
            aCoder.encode(self.offset, forKey: "offset")
            aCoder.encode(self.trimType, forKey: "trimType")
        }
    // sourcery:end
extension Vector1D: NSCoding {}
    // sourcery:inline:Vector1D.AutoCoding
        /// :nodoc:
        required public init?(coder aDecoder: NSCoder) {
            guard let value: Double = aDecoder.decode(forKey: "value") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["value"])); fatalError() }; self.value = value
        }

        /// :nodoc:
        public func encode(with aCoder: NSCoder) {
            aCoder.encode(self.value, forKey: "value")
        }
    // sourcery:end
extension Vector3D: NSCoding {}
    // sourcery:inline:Vector3D.AutoCoding
        /// :nodoc:
        required public init?(coder aDecoder: NSCoder) {
            guard let x: Double = aDecoder.decode(forKey: "x") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["x"])); fatalError() }; self.x = x
            guard let y: Double = aDecoder.decode(forKey: "y") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["y"])); fatalError() }; self.y = y
            guard let z: Double = aDecoder.decode(forKey: "z") else { NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: getVaList(["z"])); fatalError() }; self.z = z
        }

        /// :nodoc:
        public func encode(with aCoder: NSCoder) {
            aCoder.encode(self.x, forKey: "x")
            aCoder.encode(self.y, forKey: "y")
            aCoder.encode(self.z, forKey: "z")
        }
    // sourcery:end

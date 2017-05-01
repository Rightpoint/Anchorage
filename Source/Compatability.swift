//
//  Compatability.swift
//  Anchorage
//
//  Created by Rob Visentin on 5/1/17.
//
//  Copyright 2016 Raizlabs and other contributors
//  http://raizlabs.com/
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#if os(macOS)
    import Cocoa

    public typealias LayoutPriority = NSLayoutPriority
#else
    import UIKit

    public typealias LayoutPriority = UILayoutPriority
#endif

public extension BinaryFloatingPoint {

    public static var exponentBias: Int {
        return (1 << (Self.exponentBitCount - 1)) - 1
    }

    public init<T: BinaryFloatingPoint>(_ value: T) {
        assert(Self.radix == T.radix)

        let exp = value.exponent.toIntMax()
        let convertedExp = UIntMax(exp + IntMax(Self.exponentBias))

        let sig = value.significandBitPattern.toUIntMax()
        let sigBitDiff = IntMax(Self.significandBitCount - T.significandBitCount)
        let convertedSig = (sigBitDiff >= 0) ? (sig << UIntMax(sigBitDiff)) : (sig >> UIntMax(-sigBitDiff))

        self.init(
            sign: value.sign,
            exponentBitPattern: RawExponent(convertedExp),
            significandBitPattern: RawSignificand(convertedSig)
        )
    }
    
}

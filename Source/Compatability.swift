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
    public typealias EdgeInsets = UIEdgeInsets
#endif

public extension BinaryFloatingPoint {

    public static var exponentBias: Int {
        return (1 << (Self.exponentBitCount - 1)) - 1
    }

    public static var exponentMax: Int {
        return (1 << exponentBitCount) - 1
    }

    public init<T: BinaryFloatingPoint>(_ value: T) {
        assert(Self.radix == T.radix)

        let pattern: (exp: UIntMax, sig: UIntMax)

        switch value.floatingPointClass {
        case .positiveZero, .negativeZero:
            pattern = (exp: 0, sig: 0)
        case .positiveInfinity, .negativeInfinity:
            pattern = (exp: UIntMax(bitPattern: IntMax(Self.exponentMax)), sig: 0)
        case .signalingNaN:
            pattern = (exp: UIntMax(bitPattern: IntMax(Self.exponentMax)), sig: 1)
        case .quietNaN:
            pattern = (exp: UIntMax(bitPattern: IntMax(Self.exponentMax)), sig: UIntMax(bitPattern: IntMax(1 << (Self.significandBitCount - 1))))
        default:
            pattern.exp = UIntMax(bitPattern: value.exponent.toIntMax() + IntMax(Self.exponentBias))

            let sig = value.significandBitPattern.toUIntMax()
            if Self.significandBitCount >= T.significandBitCount {
                pattern.sig = sig << UIntMax(bitPattern: IntMax(Self.significandBitCount - T.significandBitCount))
            }
            else {
                pattern.sig = sig >> UIntMax(bitPattern: IntMax(T.significandBitCount - Self.significandBitCount))
            }
        }

        self.init(
            sign: value.sign,
            exponentBitPattern: RawExponent(pattern.exp),
            significandBitPattern: RawSignificand(pattern.sig)
        )
    }

}

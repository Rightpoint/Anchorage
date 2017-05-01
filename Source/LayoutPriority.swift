//
//  LayoutPriority.swift
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
#else
    import UIKit
#endif

public enum LayoutPriority: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral, Equatable {

    case required
    case high
    case low
    case fittingSize
    case custom(Alias.LayoutPriority)

    public var value: Alias.LayoutPriority {
        switch self {
        case .required: return Alias.LayoutPriorityRequired
        case .high: return Alias.LayoutPriorityHigh
        case .low: return Alias.LayoutPriorityLow
        case .fittingSize: return Alias.LayoutPriorityFittingSize
        case .custom(let priority): return priority
        }
    }

    public init(floatLiteral value: Alias.LayoutPriority) {
        self.init(value)
    }

    public init(integerLiteral value: Int) {
        self.init(value)
    }

    public init(_ value: Int) {
        self = .custom(Alias.LayoutPriority(value))
    }

    public init<T: BinaryFloatingPoint>(_ value: T) {
        self = .custom(Alias.LayoutPriority(value))
    }

}

public func == (lhs: LayoutPriority, rhs: LayoutPriority) -> Bool {
    return lhs.value == rhs.value
}

public func + <T: BinaryFloatingPoint>(lhs: LayoutPriority, rhs: T) -> LayoutPriority {
    return .custom(lhs.value + Alias.LayoutPriority(CGFloat(rhs)))
}

public func + <T: BinaryFloatingPoint>(lhs: T, rhs: LayoutPriority) -> LayoutPriority {
    return .custom(Alias.LayoutPriority(CGFloat(lhs)) + rhs.value)
}

public func - <T: BinaryFloatingPoint>(lhs: LayoutPriority, rhs: T) -> LayoutPriority {
    return .custom(lhs.value - Alias.LayoutPriority(CGFloat(rhs)))
}

public func - <T: BinaryFloatingPoint>(lhs: T, rhs: LayoutPriority) -> LayoutPriority {
    return .custom(Alias.LayoutPriority(CGFloat(lhs)) - rhs.value)
}

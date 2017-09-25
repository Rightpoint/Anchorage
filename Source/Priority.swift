//
//  Priority.swift
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

public enum Priority: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral, Equatable {

    case required
    case high
    case low
    case fittingSize
    case custom(LayoutPriority)

    public var value: LayoutPriority {
        switch self {
        case .required: return LayoutPriorityRequired
        case .high: return LayoutPriorityHigh
        case .low: return LayoutPriorityLow
        case .fittingSize: return LayoutPriorityFittingSize
        case .custom(let priority): return priority
        }
    }

    public init(floatLiteral value: Float) {
        self = .custom(LayoutPriority(value))
    }

    public init(integerLiteral value: Int) {
        self.init(value)
    }

    public init(_ value: Int) {
        self = .custom(LayoutPriority(Float(value)))
    }

    public init<T: BinaryFloatingPoint>(_ value: T) {
        self = .custom(LayoutPriority(Float(value)))
    }

}

public func == (lhs: Priority, rhs: Priority) -> Bool {
    return lhs.value == rhs.value
}

public func + <T: BinaryFloatingPoint>(lhs: Priority, rhs: T) -> Priority {
    return .custom(LayoutPriority(rawValue: lhs.value.rawValue + Float(rhs)))
}

public func + <T: BinaryFloatingPoint>(lhs: T, rhs: Priority) -> Priority {
    return .custom(LayoutPriority(rawValue: Float(lhs) + rhs.value.rawValue))
}

public func - <T: BinaryFloatingPoint>(lhs: Priority, rhs: T) -> Priority {
    return .custom(LayoutPriority(rawValue: lhs.value.rawValue - Float(rhs)))
}

public func - <T: BinaryFloatingPoint>(lhs: T, rhs: Priority) -> Priority {
    return .custom(LayoutPriority(rawValue: Float(lhs) - rhs.value.rawValue))
}

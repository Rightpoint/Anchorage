//
//  Anchorage.swift
//  Anchorage
//
//  Created by Rob Visentin on 2/6/16.
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

    public enum Alias {
        public typealias View = NSView
        public typealias ViewController = NSViewController
        public typealias LayoutPriority = NSLayoutPriority
        public typealias LayoutGuide = NSLayoutGuide

        public static let LayoutPriorityRequired = NSLayoutPriorityRequired
        public static let LayoutPriorityHigh = NSLayoutPriorityDefaultHigh
        public static let LayoutPriorityLow = NSLayoutPriorityDefaultLow
        public static let LayoutPriorityFittingSize = NSLayoutPriorityFittingSizeCompression
    }
#else
    import UIKit

    public enum Alias {
        public typealias View = UIView
        public typealias ViewController = UIViewController
        public typealias LayoutPriority = UILayoutPriority
        public typealias LayoutGuide = UILayoutGuide

        public static let LayoutPriorityRequired = UILayoutPriorityRequired
        public static let LayoutPriorityHigh = UILayoutPriorityDefaultHigh
        public static let LayoutPriorityLow = UILayoutPriorityDefaultLow
        public static let LayoutPriorityFittingSize = UILayoutPriorityFittingSizeLevel
    }
#endif

public protocol LayoutAnchorType {}
extension NSLayoutDimension : LayoutAnchorType {}
extension NSLayoutXAxisAnchor : LayoutAnchorType {}
extension NSLayoutYAxisAnchor : LayoutAnchorType {}

public protocol LayoutAxisType {}
extension NSLayoutXAxisAnchor : LayoutAxisType {}
extension NSLayoutYAxisAnchor : LayoutAxisType {}

extension BinaryFloatingPoint {

    init<T: BinaryFloatingPoint>(_ binaryFloatingPoint: T) {
        let exponentPattern = RawExponent(binaryFloatingPoint.exponentBitPattern.toUIntMax())
        let significandPattern = RawSignificand(binaryFloatingPoint.significandBitPattern.toUIntMax())
        self.init(sign: binaryFloatingPoint.sign, exponentBitPattern: exponentPattern, significandBitPattern: significandPattern)
    }

}

// MARK: - Equality Constraints

@discardableResult public func == <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(equalToConstant: CGFloat(rhs)))
}

@discardableResult public func == (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult public func == (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult public func == (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult public func == <T: NSLayoutDimension>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(equalTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func == <T: NSLayoutXAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(equalTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func == <T: NSLayoutYAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(equalTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func == (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return activate(constraint: lhs.constraint(equalTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return activate(constraint: lhs.constraint(equalToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult public func == (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeGroup {
    return lhs.activate(constraintsEqualToEdges: rhs)
}

@discardableResult public func == (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeGroup {
    return lhs.activate(constraintsEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func == <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> AxisGroup {
    return lhs.activate(constraintsEqualToEdges: rhs)
}

@discardableResult public func == <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>>) -> AxisGroup {
    return lhs.activate(constraintsEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

// MARK: - Inequality Constraints

@discardableResult public func <= <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(lessThanOrEqualToConstant: CGFloat(rhs)))
}

@discardableResult public func <= <T: NSLayoutDimension>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
}

@discardableResult public func <= <T: NSLayoutXAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
}

@discardableResult public func <= <T: NSLayoutYAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
}

@discardableResult public func <= <T: NSLayoutDimension>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func <= <T: NSLayoutXAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func <= <T: NSLayoutYAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func <= (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return activate(constraint: lhs.constraint(lessThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return activate(constraint: lhs.constraint(lessThanOrEqualToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult public func <= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeGroup {
    return lhs.activate(constraintsLessThanOrEqualToEdges: rhs)
}

@discardableResult public func <= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeGroup {
    return lhs.activate(constraintsLessThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func <= <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> AxisGroup {
    return lhs.activate(constraintsLessThanOrEqualToEdges: rhs)
}

@discardableResult public func <= <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>>) -> AxisGroup {
    return lhs.activate(constraintsLessThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func >= <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(greaterThanOrEqualToConstant: CGFloat(rhs)))
}

@discardableResult public func >=<T: NSLayoutDimension>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
}

@discardableResult public func >=<T: NSLayoutXAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
}

@discardableResult public func >=<T: NSLayoutYAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
}

@discardableResult public func >= <T: NSLayoutDimension>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func >= <T: NSLayoutXAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func >= <T: NSLayoutYAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func >= (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return activate(constraint: lhs.constraint(greaterThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return activate(constraint: lhs.constraint(greaterThanOrEqualToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult public func >= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeGroup {
    return lhs.activate(constraintsGreaterThanOrEqualToEdges: rhs)
}

@discardableResult public func >= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeGroup {
    return lhs.activate(constraintsGreaterThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func >= <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> AxisGroup {
    return lhs.activate(constraintsGreaterThanOrEqualToEdges: rhs)
}

@discardableResult public func >= <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>>) -> AxisGroup {
    return lhs.activate(constraintsGreaterThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

// MARK: - Priority

precedencegroup PriorityPrecedence {
    associativity: none
    higherThan: ComparisonPrecedence
    lowerThan: AdditionPrecedence
}

infix operator ~: PriorityPrecedence

// LayoutPriority

@discardableResult public func ~ <T: BinaryFloatingPoint>(lhs: T, rhs: LayoutPriority) -> LayoutExpression<NSLayoutDimension> {
    return LayoutExpression(constant: CGFloat(lhs), priority: rhs)
}

@discardableResult public func ~ <T: LayoutAnchorType>(lhs: T, rhs: LayoutPriority) -> LayoutExpression<T> {
    return LayoutExpression(anchor: lhs, priority: rhs)
}

@discardableResult public func ~ <T: LayoutAnchorType>(lhs: LayoutExpression<T>, rhs: LayoutPriority) -> LayoutExpression<T> {
    var expr = lhs
    expr.priority = rhs
    return expr
}

// UILayoutPriority

@discardableResult public func ~ <T: BinaryFloatingPoint, U: BinaryFloatingPoint>(lhs: T, rhs: U) -> LayoutExpression<NSLayoutDimension> {
    return lhs ~ LayoutPriority(rhs)
}

@discardableResult public func ~ <T: LayoutAnchorType, U: BinaryFloatingPoint>(lhs: T, rhs: U) -> LayoutExpression<T> {
    return lhs ~ LayoutPriority(rhs)
}

@discardableResult public func ~ <T: LayoutAnchorType, U: BinaryFloatingPoint>(lhs: LayoutExpression<T>, rhs: U) -> LayoutExpression<T> {
    return lhs ~ LayoutPriority(rhs)
}

// MARK: Layout Expressions

@discardableResult public func * <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> LayoutExpression<NSLayoutDimension> {
    return LayoutExpression(anchor: lhs, multiplier: CGFloat(rhs))
}

@discardableResult public func * <T: BinaryFloatingPoint>(lhs: T, rhs: NSLayoutDimension) -> LayoutExpression<NSLayoutDimension> {
    return LayoutExpression(anchor: rhs, multiplier: CGFloat(lhs))
}

@discardableResult public func * <T: BinaryFloatingPoint>(lhs: LayoutExpression<NSLayoutDimension>, rhs: T) -> LayoutExpression<NSLayoutDimension> {
    var expr = lhs
    expr.multiplier *= CGFloat(rhs)
    return expr
}

@discardableResult public func * <T: BinaryFloatingPoint>(lhs: T, rhs: LayoutExpression<NSLayoutDimension>) -> LayoutExpression<NSLayoutDimension> {
    var expr = rhs
    expr.multiplier *= CGFloat(lhs)
    return expr
}

@discardableResult public func / <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> LayoutExpression<NSLayoutDimension> {
    return LayoutExpression(anchor: lhs, multiplier: 1.0 / CGFloat(rhs))
}

@discardableResult public func / <T: BinaryFloatingPoint>(lhs: LayoutExpression<NSLayoutDimension>, rhs: T) -> LayoutExpression<NSLayoutDimension> {
    var expr = lhs
    expr.multiplier /= CGFloat(rhs)
    return expr
}

@discardableResult public func + <T: LayoutAnchorType, U: BinaryFloatingPoint>(lhs: T, rhs: U) -> LayoutExpression<T> {
    return LayoutExpression(anchor: lhs, constant: CGFloat(rhs))
}

@discardableResult public func + <T: BinaryFloatingPoint, U: LayoutAnchorType>(lhs: T, rhs: U) -> LayoutExpression<U> {
    return LayoutExpression(anchor: rhs, constant: CGFloat(lhs))
}

@discardableResult public func + <T: LayoutAnchorType, U: BinaryFloatingPoint>(lhs: LayoutExpression<T>, rhs: U) -> LayoutExpression<T> {
    var expr = lhs
    expr.constant += CGFloat(rhs)
    return expr
}

@discardableResult public func + <T: BinaryFloatingPoint, U: LayoutAnchorType>(lhs: T, rhs: LayoutExpression<U>) -> LayoutExpression<U> {
    var expr = rhs
    expr.constant += CGFloat(lhs)
    return expr
}

@discardableResult public func - <T: LayoutAnchorType, U: BinaryFloatingPoint>(lhs: T, rhs: U) -> LayoutExpression<T> {
    return LayoutExpression(anchor: lhs, constant: -CGFloat(rhs))
}

@discardableResult public func - <T: BinaryFloatingPoint, U: LayoutAnchorType>(lhs: T, rhs: U) -> LayoutExpression<U> {
    return LayoutExpression(anchor: rhs, constant: -CGFloat(lhs))
}

@discardableResult public func - <T: LayoutAnchorType>(lhs: LayoutExpression<T>, rhs: CGFloat) -> LayoutExpression<T> {
    var expr = lhs
    expr.constant -= rhs
    return expr
}

@discardableResult public func - <T: BinaryFloatingPoint, U: LayoutAnchorType>(lhs: T, rhs: LayoutExpression<U>) -> LayoutExpression<U> {
    var expr = rhs
    expr.constant -= CGFloat(lhs)
    return expr
}

// Adding to and subtracting from LayoutPriority

public func + <T: BinaryFloatingPoint>(lhs: LayoutPriority, rhs: T) -> LayoutPriority {
    return .custom(lhs.value + Alias.LayoutPriority(rhs))
}

public func + <T: BinaryFloatingPoint>(lhs: T, rhs: LayoutPriority) -> LayoutPriority {
    return .custom(Alias.LayoutPriority(lhs) + rhs.value)
}

public func - <T: BinaryFloatingPoint>(lhs: LayoutPriority, rhs: T) -> LayoutPriority {
    return .custom(lhs.value - Alias.LayoutPriority(rhs))
}

public func - <T: BinaryFloatingPoint>(lhs: T, rhs: LayoutPriority) -> LayoutPriority {
    return .custom(Alias.LayoutPriority(lhs) - rhs.value)
}

// MARK: - LayoutExpression

public struct LayoutExpression<T : LayoutAnchorType> {

    var anchor: T?
    var constant: CGFloat
    var multiplier: CGFloat
    var priority: LayoutPriority

    fileprivate init(anchor: T? = nil, constant: CGFloat = 0.0, multiplier: CGFloat = 1.0, priority: LayoutPriority = .required) {
        self.anchor = anchor
        self.constant = constant
        self.multiplier = multiplier
        self.priority = priority
    }

}

// MARK: - LayoutPriority

public enum LayoutPriority {

    case required
    case high
    case low
    case fittingSize
    case custom(Alias.LayoutPriority)

    var value: Alias.LayoutPriority {
        switch self {
        case .required: return Alias.LayoutPriorityRequired
        case .high: return Alias.LayoutPriorityHigh
        case .low: return Alias.LayoutPriorityLow
        case .fittingSize: return Alias.LayoutPriorityFittingSize
        case .custom(let priority): return priority
        }
    }

    init<T: BinaryFloatingPoint>(_ value: T) {
        self = .custom(Alias.LayoutPriority(value))
    }
}


// MARK: - EdgeAnchorsProvider

public protocol AnchorGroupProvider {

    var horizontalAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor> { get }
    var verticalAnchors: AnchorPair<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor> { get }
    var centerAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutYAxisAnchor> { get }

}

extension AnchorGroupProvider {

    public var edgeAnchors: EdgeAnchors {
        return EdgeAnchors(horizontal: horizontalAnchors, vertical: verticalAnchors)
    }

}


extension Alias.View: AnchorGroupProvider {

    public var horizontalAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor> {
        return AnchorPair(first: leadingAnchor, second: trailingAnchor)
    }
    public var verticalAnchors: AnchorPair<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor> {
        return AnchorPair(first: topAnchor, second: bottomAnchor)
    }
    public var centerAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutYAxisAnchor> {
        return AnchorPair(first: centerXAnchor, second: centerYAnchor)
    }

}

extension Alias.ViewController: AnchorGroupProvider {

    public var horizontalAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor> {
        return AnchorPair(first: view.leadingAnchor, second: view.trailingAnchor)
    }

#if os(macOS)
    public var verticalAnchors: AnchorPair<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor> {
        return AnchorPair(first: view.bottomAnchor, second: view.topAnchor)
    }
#else
    public var verticalAnchors: AnchorPair<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor> {
        return AnchorPair(first: topLayoutGuide.bottomAnchor, second: bottomLayoutGuide.topAnchor)
    }
#endif

    public var centerAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutYAxisAnchor> {
        return AnchorPair(first: view.centerXAnchor, second: view.centerYAnchor)
    }

}

extension Alias.LayoutGuide: AnchorGroupProvider {

    public var horizontalAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor> {
        return AnchorPair(first: leadingAnchor, second: trailingAnchor)
    }
    public var verticalAnchors: AnchorPair<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor> {
        return AnchorPair(first: topAnchor, second: bottomAnchor)
    }
    public var centerAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutYAxisAnchor> {
        return AnchorPair(first: centerXAnchor, second: centerYAnchor)
    }

}

// MARK: - AnchorPair

public struct AnchorPair<T: LayoutAxisType, U: LayoutAxisType>: LayoutAnchorType {

    private var first: T
    private var second: U

    init(first: T, second: U) {
        self.first = first
        self.second = second
    }

    fileprivate func activate(constraintsEqualToEdges anchor: AnchorPair<T, U>?, constant c: CGFloat = 0.0, priority: LayoutPriority = .required) -> AxisGroup {
        let builder = ConstraintBuilder(horizontal: ==, vertical: ==)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    fileprivate func activate(constraintsLessThanOrEqualToEdges anchor: AnchorPair<T, U>?, constant c: CGFloat = 0.0, priority: LayoutPriority = .required) -> AxisGroup {
        let builder = ConstraintBuilder(leading: <=, top: <=, trailing: >=, bottom: >=, centerX: <=, centerY: <=)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    fileprivate func activate(constraintsGreaterThanOrEqualToEdges anchor: AnchorPair<T, U>?, constant c: CGFloat = 0.0, priority: LayoutPriority = .required) -> AxisGroup {
        let builder = ConstraintBuilder(leading: >=, top: >=, trailing: <=, bottom: <=, centerX: >=, centerY: >=)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    fileprivate func constraints(forAnchors anchors: AnchorPair<T, U>?, constant c: CGFloat, priority: LayoutPriority, builder: ConstraintBuilder) -> AxisGroup {
        guard let anchors = anchors else {
            preconditionFailure("Encountered nil edge anchors, indicating internal inconsistency of this API.")
        }

        switch (first, anchors.first, second, anchors.second) {
        // Leading, trailing
        case let (firstX as NSLayoutXAxisAnchor, otherFirstX as NSLayoutXAxisAnchor,
                  secondX as NSLayoutXAxisAnchor, otherSecondX as NSLayoutXAxisAnchor):
            return AxisGroup(first: builder.leadingBuilder(firstX, otherFirstX + c ~ priority),
                             second: builder.trailingBuilder(secondX, otherSecondX - c ~ priority))
        //Top, bottom
        case let (firstY as NSLayoutYAxisAnchor, otherFirstY as NSLayoutYAxisAnchor,
                  secondY as NSLayoutYAxisAnchor, otherSecondY as NSLayoutYAxisAnchor):
            return AxisGroup(first: builder.topBuilder(firstY, otherFirstY + c ~ priority),
                             second: builder.bottomBuilder(secondY, otherSecondY - c ~ priority))
        //CenterX, centerY
        case let (firstX as NSLayoutXAxisAnchor, otherFirstX as NSLayoutXAxisAnchor,
                  firstY as NSLayoutYAxisAnchor, otherFirstY as NSLayoutYAxisAnchor):
            return AxisGroup(first: builder.leadingBuilder(firstX, otherFirstX + c ~ priority),
                             second: builder.topBuilder(firstY, otherFirstY - c ~ priority))
        default:
            preconditionFailure("Layout axes of constrained anchors must match.")
        }
    }
}

// MARK: - EdgeAnchors

public struct EdgeAnchors: LayoutAnchorType {

    var horizontalAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor>
    var verticalAnchors: AnchorPair<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor>

    fileprivate init(horizontal: AnchorPair<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor>, vertical: AnchorPair<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor>) {
        self.horizontalAnchors = horizontal
        self.verticalAnchors = vertical
    }

    fileprivate func activate(constraintsEqualToEdges anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: LayoutPriority = .required) -> EdgeGroup {
        let builder = ConstraintBuilder(horizontal: ==, vertical: ==)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    fileprivate func activate(constraintsLessThanOrEqualToEdges anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: LayoutPriority = .required) -> EdgeGroup {
        let builder = ConstraintBuilder(leading: <=, top: <=, trailing: >=, bottom: >=, centerX: <=, centerY: <=)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    fileprivate func activate(constraintsGreaterThanOrEqualToEdges anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: LayoutPriority = .required) -> EdgeGroup {
        let builder = ConstraintBuilder(leading: >=, top: >=, trailing: <=, bottom: <=, centerX: >=, centerY: >=)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    fileprivate func constraints(forAnchors anchors: EdgeAnchors?, constant c: CGFloat, priority: LayoutPriority, builder: ConstraintBuilder) -> EdgeGroup {
        guard let anchors = anchors else {
            preconditionFailure("Encountered nil edge anchors, indicating internal inconsistency of this API.")
        }

        let horizontalConstraints = horizontalAnchors.constraints(forAnchors: anchors.horizontalAnchors, constant: c, priority: priority, builder: builder)
        let verticalConstraints = verticalAnchors.constraints(forAnchors: anchors.verticalAnchors, constant: c, priority: priority, builder: builder)
        return EdgeGroup(top: verticalConstraints.first,
                         leading: horizontalConstraints.first,
                         bottom: verticalConstraints.second,
                         trailing: verticalConstraints.second)
    }

}

// MARK: - EdgeGroup

public struct EdgeGroup {

    var top: NSLayoutConstraint
    var leading: NSLayoutConstraint
    var bottom: NSLayoutConstraint
    var trailing: NSLayoutConstraint

    var horizontal: [NSLayoutConstraint] {
        return [leading, trailing]
    }

    var vertical: [NSLayoutConstraint] {
        return [top, bottom]
    }

    var all: [NSLayoutConstraint] {
        return [top, leading, bottom, trailing]
    }

}

// MARK: - Axis Group

public struct AxisGroup {

    var first: NSLayoutConstraint
    var second: NSLayoutConstraint

}

// MARK: - ConstraintBuilder

fileprivate struct ConstraintBuilder {

    typealias Horizontal = (NSLayoutXAxisAnchor, LayoutExpression<NSLayoutXAxisAnchor>) -> NSLayoutConstraint
    typealias Vertical = (NSLayoutYAxisAnchor, LayoutExpression<NSLayoutYAxisAnchor>) -> NSLayoutConstraint

    var topBuilder: Vertical
    var leadingBuilder: Horizontal
    var bottomBuilder: Vertical
    var trailingBuilder: Horizontal
    var centerYBuilder: Vertical
    var centerXBuilder: Horizontal

    init(horizontal: @escaping Horizontal, vertical: @escaping Vertical) {
        topBuilder = vertical
        leadingBuilder = horizontal
        bottomBuilder = vertical
        trailingBuilder = horizontal
        centerYBuilder = vertical
        centerXBuilder = horizontal
    }

    init(leading: @escaping Horizontal, top: @escaping Vertical, trailing: @escaping Horizontal,
         bottom: @escaping Vertical, centerX: @escaping Horizontal, centerY: @escaping Vertical) {
        leadingBuilder = leading
        topBuilder = top
        trailingBuilder = trailing
        bottomBuilder = bottom
        centerYBuilder = centerY
        centerXBuilder = centerX
    }
    
}

// MARK: - Constraint Activation

fileprivate func activate(constraint theConstraint: NSLayoutConstraint, withPriority priority: LayoutPriority = .required) -> NSLayoutConstraint {
    // Only disable autoresizing constraints on the LHS item, which is the one definitely intended to be governed by Auto Layout
    if let first = theConstraint.firstItem as? Alias.View{
        first.translatesAutoresizingMaskIntoConstraints = false
    }
    
    theConstraint.priority = priority.value
    theConstraint.isActive = true
    
    return theConstraint
}

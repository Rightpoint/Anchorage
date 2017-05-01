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
#else
    import UIKit
#endif

public protocol LayoutAnchorType {}
extension NSLayoutDimension : LayoutAnchorType {}
extension NSLayoutXAxisAnchor : LayoutAnchorType {}
extension NSLayoutYAxisAnchor : LayoutAnchorType {}

public protocol LayoutAxisType {}
extension NSLayoutXAxisAnchor : LayoutAxisType {}
extension NSLayoutYAxisAnchor : LayoutAxisType {}

// MARK: - Equality Constraints

@discardableResult public func == <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalToConstant: CGFloat(rhs)))
}

@discardableResult public func == (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult public func == (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult public func == (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult public func == <T: NSLayoutDimension>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func == <T: NSLayoutXAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func == <T: NSLayoutYAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func == (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return finalize(constraint: lhs.constraint(equalTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return finalize(constraint: lhs.constraint(equalToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult public func == (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeGroup {
    return lhs.finalize(constraintsEqualToEdges: rhs)
}

@discardableResult public func == (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeGroup {
    return lhs.finalize(constraintsEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func == <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> AxisGroup {
    return lhs.finalize(constraintsEqualToEdges: rhs)
}

@discardableResult public func == <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>>) -> AxisGroup {
    return lhs.finalize(constraintsEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

// MARK: - Inequality Constraints

@discardableResult public func <= <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualToConstant: CGFloat(rhs)))
}

@discardableResult public func <= <T: NSLayoutDimension>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
}

@discardableResult public func <= <T: NSLayoutXAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
}

@discardableResult public func <= <T: NSLayoutYAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
}

@discardableResult public func <= <T: NSLayoutDimension>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func <= <T: NSLayoutXAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func <= <T: NSLayoutYAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func <= (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return finalize(constraint: lhs.constraint(lessThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return finalize(constraint: lhs.constraint(lessThanOrEqualToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult public func <= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeGroup {
    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs)
}

@discardableResult public func <= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeGroup {
    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func <= <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> AxisGroup {
    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs)
}

@discardableResult public func <= <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>>) -> AxisGroup {
    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func >= <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(greaterThanOrEqualToConstant: CGFloat(rhs)))
}

@discardableResult public func >=<T: NSLayoutDimension>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
}

@discardableResult public func >=<T: NSLayoutXAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
}

@discardableResult public func >=<T: NSLayoutYAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
}

@discardableResult public func >= <T: NSLayoutDimension>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func >= <T: NSLayoutXAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func >= <T: NSLayoutYAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func >= (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return finalize(constraint: lhs.constraint(greaterThanOrEqualToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult public func >= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeGroup {
    return lhs.finalize(constraintsGreaterThanOrEqualToEdges: rhs)
}

@discardableResult public func >= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeGroup {
    return lhs.finalize(constraintsGreaterThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func >= <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> AxisGroup {
    return lhs.finalize(constraintsGreaterThanOrEqualToEdges: rhs)
}

@discardableResult public func >= <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>>) -> AxisGroup {
    return lhs.finalize(constraintsGreaterThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

// MARK: - Priority

precedencegroup PriorityPrecedence {
    associativity: none
    higherThan: ComparisonPrecedence
    lowerThan: AdditionPrecedence
}

infix operator ~: PriorityPrecedence

@discardableResult public func ~ <T: BinaryFloatingPoint>(lhs: T, rhs: Priority) -> LayoutExpression<NSLayoutDimension> {
    return LayoutExpression(constant: CGFloat(lhs), priority: rhs)
}

@discardableResult public func ~ <T: LayoutAnchorType>(lhs: T, rhs: Priority) -> LayoutExpression<T> {
    return LayoutExpression(anchor: lhs, priority: rhs)
}

@discardableResult public func ~ <T: LayoutAnchorType>(lhs: LayoutExpression<T>, rhs: Priority) -> LayoutExpression<T> {
    var expr = lhs
    expr.priority = rhs
    return expr
}

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

@discardableResult public func - <T: LayoutAnchorType, U: BinaryFloatingPoint>(lhs: LayoutExpression<T>, rhs: U) -> LayoutExpression<T> {
    var expr = lhs
    expr.constant -= CGFloat(rhs)
    return expr
}

@discardableResult public func - <T: BinaryFloatingPoint, U: LayoutAnchorType>(lhs: T, rhs: LayoutExpression<U>) -> LayoutExpression<U> {
    var expr = rhs
    expr.constant -= CGFloat(lhs)
    return expr
}

// MARK: - Batching

/// Any Anchorage constraints created inside the passed closure are returned in the array.
///
/// - Precondition: Can't be called inside or simultaneously with another batch. Batches cannot be nested.
/// - Parameter active: Whether the created constraints should be active when they are returned.
/// - Parameter closure: A closure that runs some Anchorage expressions.
/// - Returns: An array of new `NSLayoutConstraint`s.
@discardableResult public func batch(active: Bool, closure: () -> Void) -> [NSLayoutConstraint] {
    precondition(currentBatch == nil)
    defer {
        currentBatch = nil
    }

    let batch = ConstraintBatch()
    currentBatch = batch

    closure()

    if active {
        batch.activate()
    }

    return batch.constraints
}

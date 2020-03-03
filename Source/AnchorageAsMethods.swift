//
//  AnchorageAsMethods.swift
//  Anchorage
//
//  Created by Przemysław Wośko on 26/02/2020.
//
//  Copyright 2016 Rightpoint and other contributors
//  http://rightpoint.com/
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


// search: [a-w].*Anchor == (.*)Anchor.*
// replace: constraint\($1, $2\)

@discardableResult public func constraint <T: BinaryFloatingPoint>(_ lhs: NSLayoutDimension, _ rhs: T) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalToConstant: CGFloat(rhs)))
}

@discardableResult public func constraint (_ lhs: NSLayoutXAxisAnchor, _ rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult public func constraint (_ lhs: NSLayoutYAxisAnchor, _ rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult public func constraint (_ lhs: NSLayoutDimension, _ rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult public func constraint (_ lhs: NSLayoutXAxisAnchor, _ rhs: LayoutExpression<NSLayoutXAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func constraint (_ lhs: NSLayoutYAxisAnchor, _ rhs: LayoutExpression<NSLayoutYAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func constraint (_ lhs: NSLayoutDimension, _ rhs: LayoutExpression<NSLayoutDimension, CGFloat>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return finalize(constraint: lhs.constraint(equalTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return finalize(constraint: lhs.constraint(equalToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult public func constraint (_ lhs: EdgeAnchors, _ rhs: EdgeAnchors) -> ConstraintGroup {
    return lhs.finalize(constraintsEqualToEdges: rhs)
}

@discardableResult public func constraint (_ lhs: EdgeAnchors, _ rhs: LayoutExpression<EdgeAnchors, CGFloat>) -> ConstraintGroup {
    return lhs.finalize(constraintsEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func constraint (_ lhs: EdgeAnchors, _ rhs: LayoutExpression<EdgeAnchors, EdgeInsets>) -> ConstraintGroup {
    return lhs.finalize(constraintsEqualToEdges: rhs.anchor, insets: rhs.constant, priority: rhs.priority)
}

@discardableResult public func constraint <T, U>(_ lhs: AnchorPair<T, U>, _ rhs: AnchorPair<T, U>) -> ConstraintPair {
    return lhs.finalize(constraintsEqualToEdges: rhs)
}

@discardableResult public func constraint <T, U>(_ lhs: AnchorPair<T, U>, _ rhs: LayoutExpression<AnchorPair<T, U>, CGFloat>) -> ConstraintPair {
    return lhs.finalize(constraintsEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func constraint (_ lhs: AnchorPair<NSLayoutDimension, NSLayoutDimension>, _ rhs: CGSize) -> ConstraintPair {
    return lhs.finalize(constraintsEqualToConstant: rhs)
}

@discardableResult public func constraint (_ lhs: AnchorPair<NSLayoutDimension, NSLayoutDimension>, _ rhs: LayoutExpression<AnchorPair<NSLayoutDimension, NSLayoutDimension>, CGSize>) -> ConstraintPair {
    return lhs.finalize(constraintsEqualToConstant: rhs.constant, priority: rhs.priority)
}

//// MARK: - Inequality Constraints
//
//@discardableResult public func <= <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> NSLayoutConstraint {
//    return finalize(constraint: lhs.constraint(lessThanOrEqualToConstant: CGFloat(rhs)))
//}
//
//@discardableResult public func <= (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
//    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
//}
//
//@discardableResult public func <= (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
//    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
//}
//
//@discardableResult public func <= (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
//    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
//}
//
//@discardableResult public func <= (lhs: NSLayoutXAxisAnchor, rhs: LayoutExpression<NSLayoutXAxisAnchor, CGFloat>) -> NSLayoutConstraint {
//    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
//}
//
//@discardableResult public func <= (lhs: NSLayoutYAxisAnchor, rhs: LayoutExpression<NSLayoutYAxisAnchor, CGFloat>) -> NSLayoutConstraint {
//    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
//}
//
//@discardableResult public func <= (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension, CGFloat>) -> NSLayoutConstraint {
//    if let anchor = rhs.anchor {
//        return finalize(constraint: lhs.constraint(lessThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
//    }
//    else {
//        return finalize(constraint: lhs.constraint(lessThanOrEqualToConstant: rhs.constant), withPriority: rhs.priority)
//    }
//}
//
//@discardableResult public func <= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> ConstraintGroup {
//    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs)
//}
//
//@discardableResult public func <= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors, CGFloat>) -> ConstraintGroup {
//    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
//}
//
//@discardableResult public func <= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors, EdgeInsets>) -> ConstraintGroup {
//    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs.anchor, insets: rhs.constant, priority: rhs.priority)
//}
//
//@discardableResult public func <= <T, U>(lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> ConstraintPair {
//    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs)
//}
//
//@discardableResult public func <= <T, U>(lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>, CGFloat>) -> ConstraintPair {
//    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
//}
//
//@discardableResult public func <= (lhs: AnchorPair<NSLayoutDimension, NSLayoutDimension>, rhs: CGSize) -> ConstraintPair {
//    return lhs.finalize(constraintsLessThanOrEqualToConstant: rhs)
//}
//
//@discardableResult public func <= (lhs: AnchorPair<NSLayoutDimension, NSLayoutDimension>, rhs: LayoutExpression<AnchorPair<NSLayoutDimension, NSLayoutDimension>, CGSize>) -> ConstraintPair {
//    return lhs.finalize(constraintsLessThanOrEqualToConstant: rhs.constant, priority: rhs.priority)
//}
//
//@discardableResult public func >= <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> NSLayoutConstraint {
//    return finalize(constraint: lhs.constraint(greaterThanOrEqualToConstant: CGFloat(rhs)))
//}
//
//@discardableResult public func >= (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
//    return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
//}
//
//@discardableResult public func >= (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
//    return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
//}
//
//@discardableResult public func >= (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
//    return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
//}
//
//@discardableResult public func >= (lhs: NSLayoutXAxisAnchor, rhs: LayoutExpression<NSLayoutXAxisAnchor, CGFloat>) -> NSLayoutConstraint {
//    return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
//}
//
//@discardableResult public func >= (lhs: NSLayoutYAxisAnchor, rhs: LayoutExpression<NSLayoutYAxisAnchor, CGFloat>) -> NSLayoutConstraint {
//    return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
//}
//
//@discardableResult public func >= (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension, CGFloat>) -> NSLayoutConstraint {
//    if let anchor = rhs.anchor {
//        return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
//    }
//    else {
//        return finalize(constraint: lhs.constraint(greaterThanOrEqualToConstant: rhs.constant), withPriority: rhs.priority)
//    }
//}
//
//@discardableResult public func >= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> ConstraintGroup {
//    return lhs.finalize(constraintsGreaterThanOrEqualToEdges: rhs)
//}
//
//@discardableResult public func >= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors, CGFloat>) -> ConstraintGroup {
//    return lhs.finalize(constraintsGreaterThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
//}
//
//@discardableResult public func >= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors, EdgeInsets>) -> ConstraintGroup {
//    return lhs.finalize(constraintsGreaterThanOrEqualToEdges: rhs.anchor, insets: rhs.constant, priority: rhs.priority)
//}
//
//@discardableResult public func >= <T, U>(lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> ConstraintPair {
//    return lhs.finalize(constraintsGreaterThanOrEqualToEdges: rhs)
//}
//
//@discardableResult public func >= <T, U>(lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>, CGFloat>) -> ConstraintPair {
//    return lhs.finalize(constraintsGreaterThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
//}
//
//@discardableResult public func >= (lhs: AnchorPair<NSLayoutDimension, NSLayoutDimension>, rhs: CGSize) -> ConstraintPair {
//    return lhs.finalize(constraintsGreaterThanOrEqualToConstant: rhs)
//}
//
//@discardableResult public func >= (lhs: AnchorPair<NSLayoutDimension, NSLayoutDimension>, rhs: LayoutExpression<AnchorPair<NSLayoutDimension, NSLayoutDimension>, CGSize>) -> ConstraintPair {
//    return lhs.finalize(constraintsGreaterThanOrEqualToConstant: rhs.constant, priority: rhs.priority)
//}
//
//// MARK: - Priority
//
//precedencegroup PriorityPrecedence {
//    associativity: none
//    higherThan: ComparisonPrecedence
//    lowerThan: AdditionPrecedence
//}
//
//infix operator ~: PriorityPrecedence
//
//@discardableResult public func ~ <T: BinaryFloatingPoint>(lhs: T, rhs: Priority) -> LayoutExpression<NSLayoutDimension, CGFloat> {
//    return LayoutExpression(constant: CGFloat(lhs), priority: rhs)
//}
//
//@discardableResult public func ~ (lhs: CGSize, rhs: Priority) -> LayoutExpression<AnchorPair<NSLayoutDimension, NSLayoutDimension>, CGSize> {
//    return LayoutExpression(constant: lhs, priority: rhs)
//}
//
//@discardableResult public func ~ <T>(lhs: T, rhs: Priority) -> LayoutExpression<T, CGFloat> {
//    return LayoutExpression(anchor: lhs, constant: 0.0, priority: rhs)
//}
//
//@discardableResult public func ~ <T, U>(lhs: LayoutExpression<T, U>, rhs: Priority) -> LayoutExpression<T, U> {
//    var expr = lhs
//    expr.priority = rhs
//    return expr
//}
//
//@discardableResult public func * <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> LayoutExpression<NSLayoutDimension, CGFloat> {
//    return LayoutExpression(anchor: lhs, constant: 0.0, multiplier: CGFloat(rhs))
//}
//
//@discardableResult public func * <T: BinaryFloatingPoint>(lhs: T, rhs: NSLayoutDimension) -> LayoutExpression<NSLayoutDimension, CGFloat> {
//    return LayoutExpression(anchor: rhs, constant: 0.0, multiplier: CGFloat(lhs))
//}
//
//@discardableResult public func * <T: BinaryFloatingPoint>(lhs: LayoutExpression<NSLayoutDimension, CGFloat>, rhs: T) -> LayoutExpression<NSLayoutDimension, CGFloat> {
//    var expr = lhs
//    expr.multiplier *= CGFloat(rhs)
//    return expr
//}
//
//@discardableResult public func * <T: BinaryFloatingPoint>(lhs: T, rhs: LayoutExpression<NSLayoutDimension, CGFloat>) -> LayoutExpression<NSLayoutDimension, CGFloat> {
//    var expr = rhs
//    expr.multiplier *= CGFloat(lhs)
//    return expr
//}
//
//@discardableResult public func * <T: BinaryFloatingPoint>(lhs: NSLayoutXAxisAnchor, rhs: T) -> LayoutExpression<NSLayoutXAxisAnchor, CGFloat> {
//    return LayoutExpression(anchor: Optional<NSLayoutXAxisAnchor>.some(lhs), constant: 0.0, multiplier: CGFloat(rhs))
//}
//
//@discardableResult public func * <T: BinaryFloatingPoint>(lhs: T, rhs: NSLayoutXAxisAnchor) -> LayoutExpression<NSLayoutXAxisAnchor, CGFloat> {
//    return LayoutExpression(anchor: rhs, constant: 0.0, multiplier: CGFloat(lhs))
//}
//
//@discardableResult public func * <T: BinaryFloatingPoint>(lhs: LayoutExpression<NSLayoutXAxisAnchor, CGFloat>, rhs: T) -> LayoutExpression<NSLayoutXAxisAnchor, CGFloat> {
//    var expr = lhs
//    expr.multiplier *= CGFloat(rhs)
//    return expr
//}
//
//@discardableResult public func * <T: BinaryFloatingPoint>(lhs: T, rhs: LayoutExpression<NSLayoutXAxisAnchor, CGFloat>) -> LayoutExpression<NSLayoutXAxisAnchor, CGFloat> {
//    var expr = rhs
//    expr.multiplier *= CGFloat(lhs)
//    return expr
//}
//
//@discardableResult public func * <T: BinaryFloatingPoint>(lhs: NSLayoutYAxisAnchor, rhs: T) -> LayoutExpression<NSLayoutYAxisAnchor, CGFloat> {
//    return LayoutExpression(anchor: lhs, constant: 0.0, multiplier: CGFloat(rhs))
//}
//
//@discardableResult public func * <T: BinaryFloatingPoint>(lhs: T, rhs: NSLayoutYAxisAnchor) -> LayoutExpression<NSLayoutYAxisAnchor, CGFloat> {
//    return LayoutExpression(anchor: rhs, constant: 0.0, multiplier: CGFloat(lhs))
//}
//
//@discardableResult public func * <T: BinaryFloatingPoint>(lhs: LayoutExpression<NSLayoutYAxisAnchor, CGFloat>, rhs: T) -> LayoutExpression<NSLayoutYAxisAnchor, CGFloat> {
//    var expr = lhs
//    expr.multiplier *= CGFloat(rhs)
//    return expr
//}
//
//@discardableResult public func * <T: BinaryFloatingPoint>(lhs: T, rhs: LayoutExpression<NSLayoutYAxisAnchor, CGFloat>) -> LayoutExpression<NSLayoutYAxisAnchor, CGFloat> {
//    var expr = rhs
//    expr.multiplier *= CGFloat(lhs)
//    return expr
//}
//
//@discardableResult public func / <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> LayoutExpression<NSLayoutDimension, CGFloat> {
//    return LayoutExpression(anchor: lhs, constant: 0.0, multiplier: 1.0 / CGFloat(rhs))
//}
//
//@discardableResult public func / <T: BinaryFloatingPoint>(lhs: LayoutExpression<NSLayoutDimension, CGFloat>, rhs: T) -> LayoutExpression<NSLayoutDimension, CGFloat> {
//    var expr = lhs
//    expr.multiplier /= CGFloat(rhs)
//    return expr
//}
//
//@discardableResult public func / <T: BinaryFloatingPoint>(lhs: NSLayoutXAxisAnchor, rhs: T) -> LayoutExpression<NSLayoutXAxisAnchor, CGFloat> {
//    return LayoutExpression(anchor: lhs, constant: 0.0, multiplier: 1.0 / CGFloat(rhs))
//}
//
//@discardableResult public func / <T: BinaryFloatingPoint>(lhs: LayoutExpression<NSLayoutXAxisAnchor, CGFloat>, rhs: T) -> LayoutExpression<NSLayoutXAxisAnchor, CGFloat> {
//    var expr = lhs
//    expr.multiplier /= CGFloat(rhs)
//    return expr
//}
//
//@discardableResult public func / <T: BinaryFloatingPoint>(lhs: NSLayoutYAxisAnchor, rhs: T) -> LayoutExpression<NSLayoutYAxisAnchor, CGFloat> {
//    return LayoutExpression(anchor: lhs, constant: 0.0, multiplier: 1.0 / CGFloat(rhs))
//}
//
//@discardableResult public func / <T: BinaryFloatingPoint>(lhs: LayoutExpression<NSLayoutYAxisAnchor, CGFloat>, rhs: T) -> LayoutExpression<NSLayoutYAxisAnchor, CGFloat> {
//    var expr = lhs
//    expr.multiplier /= CGFloat(rhs)
//    return expr
//}
//
//@discardableResult public func + <T, U: BinaryFloatingPoint>(lhs: T, rhs: U) -> LayoutExpression<T, CGFloat> {
//    return LayoutExpression(anchor: lhs, constant: CGFloat(rhs))
//}
//
//@discardableResult public func + <T: BinaryFloatingPoint, U>(lhs: T, rhs: U) -> LayoutExpression<U, CGFloat> {
//    return LayoutExpression(anchor: rhs, constant: CGFloat(lhs))
//}
//
//@discardableResult public func + <T, U: BinaryFloatingPoint>(lhs: LayoutExpression<T, CGFloat>, rhs: U) -> LayoutExpression<T, CGFloat> {
//    var expr = lhs
//    expr.constant += CGFloat(rhs)
//    return expr
//}
//
//@discardableResult public func + <T: BinaryFloatingPoint, U>(lhs: T, rhs: LayoutExpression<U, CGFloat>) -> LayoutExpression<U, CGFloat> {
//    var expr = rhs
//    expr.constant += CGFloat(lhs)
//    return expr
//}
//
//@discardableResult public func + (lhs: EdgeAnchors, rhs: EdgeInsets) -> LayoutExpression<EdgeAnchors, EdgeInsets> {
//    return LayoutExpression(anchor: lhs, constant: rhs)
//}
//
//@discardableResult public func - <T, U: BinaryFloatingPoint>(lhs: T, rhs: U) -> LayoutExpression<T, CGFloat> {
//    return LayoutExpression(anchor: lhs, constant: -CGFloat(rhs))
//}
//
//@discardableResult public func - <T: BinaryFloatingPoint, U>(lhs: T, rhs: U) -> LayoutExpression<U, CGFloat> {
//    return LayoutExpression(anchor: rhs, constant: -CGFloat(lhs))
//}
//
//@discardableResult public func - <T, U: BinaryFloatingPoint>(lhs: LayoutExpression<T, CGFloat>, rhs: U) -> LayoutExpression<T, CGFloat> {
//    var expr = lhs
//    expr.constant -= CGFloat(rhs)
//    return expr
//}
//
//@discardableResult public func - <T: BinaryFloatingPoint, U>(lhs: T, rhs: LayoutExpression<U, CGFloat>) -> LayoutExpression<U, CGFloat> {
//    var expr = rhs
//    expr.constant -= CGFloat(lhs)
//    return expr
//}
//
//@discardableResult public func - (lhs: EdgeAnchors, rhs: EdgeInsets) -> LayoutExpression<EdgeAnchors, EdgeInsets> {
//    return LayoutExpression(anchor: lhs, constant: -rhs)
//}

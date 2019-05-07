//
//  AnchorageFast.swift
//  AnchorageDemo
//
//  Created by Chad on 5/6/19.
//  Copyright © 2019 Raizlabs. All rights reserved.
//

#if os(macOS)
import Cocoa
#else
import UIKit
#endif

//public protocol LayoutConstantType {}
//extension CGFloat: LayoutConstantType {}
//extension CGSize: LayoutConstantType {}
//extension EdgeInsets: LayoutConstantType {}

//public protocol LayoutAnchorType {}
//extension NSLayoutAnchor: LayoutAnchorType {}

// MARK: - Equality Constraints
extension NSLayoutDimension {
    @discardableResult public func match<T: BinaryFloatingPoint>(_ rhs: T) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(equalToConstant: CGFloat(rhs)))
    }

    @discardableResult public func match(_ rhs: NSLayoutDimension) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(equalTo: rhs))
    }

    @discardableResult public func match(_ rhs: LayoutExpression<NSLayoutDimension, CGFloat>) -> NSLayoutConstraint {
        if let anchor = rhs.anchor {
            return Anchorage.finalize(constraint: self.constraint(equalTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
        }
        else {
            return Anchorage.finalize(constraint: self.constraint(equalToConstant: rhs.constant), withPriority: rhs.priority)
        }
    }
}

extension NSLayoutXAxisAnchor {
    @discardableResult public func match(_ rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(equalTo: rhs))
    }

    @discardableResult public func match(_ rhs: LayoutExpression<NSLayoutXAxisAnchor, CGFloat>) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(equalTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
}

extension NSLayoutYAxisAnchor {
    @discardableResult public func match(_ rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(equalTo: rhs))
    }

    @discardableResult public func match(_ rhs: LayoutExpression<NSLayoutYAxisAnchor, CGFloat>) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(equalTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
}


extension EdgeAnchors {
    @discardableResult public func match(_ rhs: EdgeAnchors) -> ConstraintGroup {
        return self.finalize(constraintsEqualToEdges: rhs)
    }

    @discardableResult public func match(_ rhs: LayoutExpression<EdgeAnchors, CGFloat>) -> ConstraintGroup {
        return self.finalize(constraintsEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
    }

    @discardableResult public func match(_ rhs: LayoutExpression<EdgeAnchors, EdgeInsets>) -> ConstraintGroup {
        return self.finalize(constraintsEqualToEdges: rhs.anchor, insets: rhs.constant, priority: rhs.priority)
    }
}

extension AnchorPair {
    @discardableResult public func match(_ rhs: AnchorPair<T, U>) -> ConstraintPair {
        return self.finalize(constraintsEqualToEdges: rhs)
    }

    @discardableResult public func match(_ rhs: LayoutExpression<AnchorPair<T, U>, CGFloat>) -> ConstraintPair {
        return self.finalize(constraintsEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
    }
}

extension AnchorPair where T: NSLayoutDimension, U: NSLayoutDimension {
    @discardableResult public func match(_ rhs: CGSize) -> ConstraintPair {
        return self.finalize(constraintsEqualToConstant: rhs)
    }

    @discardableResult public func match(_ rhs: LayoutExpression<AnchorPair<NSLayoutDimension, NSLayoutDimension>, CGSize>) -> ConstraintPair {
        return self.finalize(constraintsEqualToConstant: rhs.constant, priority: rhs.priority)
    }
}

// MARK: - Inequality Constraints
// less than
extension NSLayoutDimension {
    @discardableResult public func matchOrLess<T: BinaryFloatingPoint>(_ rhs: T) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(lessThanOrEqualToConstant: CGFloat(rhs)))
    }

    @discardableResult public func matchOrLess(_ rhs: NSLayoutDimension) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(lessThanOrEqualTo: rhs))
    }

    @discardableResult public func matchOrLess(_ rhs: LayoutExpression<NSLayoutDimension, CGFloat>) -> NSLayoutConstraint {
        if let anchor = rhs.anchor {
            return Anchorage.finalize(constraint: self.constraint(lessThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
        }
        else {
            return Anchorage.finalize(constraint: self.constraint(lessThanOrEqualToConstant: rhs.constant), withPriority: rhs.priority)
        }
    }
}

extension NSLayoutXAxisAnchor {
    @discardableResult public func matchOrLess(_ rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(lessThanOrEqualTo: rhs))
    }

    @discardableResult public func matchOrLess(_ rhs: LayoutExpression<NSLayoutXAxisAnchor, CGFloat>) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(lessThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
}

extension NSLayoutYAxisAnchor {
    @discardableResult public func matchOrLess(_ rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(lessThanOrEqualTo: rhs))
    }

    @discardableResult public func matchOrLess(_ rhs: LayoutExpression<NSLayoutYAxisAnchor, CGFloat>) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(lessThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
}

extension EdgeAnchors {
    @discardableResult public func matchOrLess(_ rhs: EdgeAnchors) -> ConstraintGroup {
        return self.finalize(constraintsLessThanOrEqualToEdges: rhs)
    }

    @discardableResult public func matchOrLess(_ rhs: LayoutExpression<EdgeAnchors, CGFloat>) -> ConstraintGroup {
        return self.finalize(constraintsLessThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
    }

    @discardableResult public func matchOrLess(_ rhs: LayoutExpression<EdgeAnchors, EdgeInsets>) -> ConstraintGroup {
        return self.finalize(constraintsLessThanOrEqualToEdges: rhs.anchor, insets: rhs.constant, priority: rhs.priority)
    }
}

extension AnchorPair {
    @discardableResult public func matchOrLess(_ rhs: AnchorPair<T, U>) -> ConstraintPair {
        return self.finalize(constraintsLessThanOrEqualToEdges: rhs)
    }

    @discardableResult public func matchOrLess(_ rhs: LayoutExpression<AnchorPair<T, U>, CGFloat>) -> ConstraintPair {
        return self.finalize(constraintsLessThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
    }
}

extension AnchorPair where T: NSLayoutDimension, U: NSLayoutDimension {
    @discardableResult public func matchOrLess(_ rhs: CGSize) -> ConstraintPair {
        return self.finalize(constraintsLessThanOrEqualToConstant: rhs)
    }

    @discardableResult public func matchOrLess(_ rhs: LayoutExpression<AnchorPair<NSLayoutDimension, NSLayoutDimension>, CGSize>) -> ConstraintPair {
        return self.finalize(constraintsLessThanOrEqualToConstant: rhs.constant, priority: rhs.priority)
    }
}

// Greater than
extension NSLayoutDimension {
    @discardableResult public func matchOrMore<T: BinaryFloatingPoint>(_ rhs: T) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(greaterThanOrEqualToConstant: CGFloat(rhs)))
    }

    @discardableResult public func matchOrMore(_ rhs: NSLayoutDimension) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(greaterThanOrEqualTo: rhs))
    }

    @discardableResult public func matchOrMore(_ rhs: LayoutExpression<NSLayoutDimension, CGFloat>) -> NSLayoutConstraint {
        if let anchor = rhs.anchor {
            return Anchorage.finalize(constraint: self.constraint(greaterThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
        }
        else {
            return Anchorage.finalize(constraint: self.constraint(greaterThanOrEqualToConstant: rhs.constant), withPriority: rhs.priority)
        }
    }
}

extension NSLayoutXAxisAnchor {
    @discardableResult public func matchOrMore(_ rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(greaterThanOrEqualTo: rhs))
    }

    @discardableResult public func matchOrMore(_ rhs: LayoutExpression<NSLayoutXAxisAnchor, CGFloat>) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(greaterThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
}

extension NSLayoutYAxisAnchor {
    @discardableResult public func matchOrMore(_ rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(greaterThanOrEqualTo: rhs))
    }

    @discardableResult public func matchOrMore(_ rhs: LayoutExpression<NSLayoutYAxisAnchor, CGFloat>) -> NSLayoutConstraint {
        return Anchorage.finalize(constraint: self.constraint(greaterThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
}

extension EdgeAnchors {
    @discardableResult public func matchOrMore(_ rhs: EdgeAnchors) -> ConstraintGroup {
        return self.finalize(constraintsGreaterThanOrEqualToEdges: rhs)
    }

    @discardableResult public func matchOrMore(_ rhs: LayoutExpression<EdgeAnchors, CGFloat>) -> ConstraintGroup {
        return self.finalize(constraintsGreaterThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
    }

    @discardableResult public func matchOrMore(_ rhs: LayoutExpression<EdgeAnchors, EdgeInsets>) -> ConstraintGroup {
        return self.finalize(constraintsGreaterThanOrEqualToEdges: rhs.anchor, insets: rhs.constant, priority: rhs.priority)
    }
}

extension AnchorPair {
    @discardableResult public func matchOrMore(_ rhs: AnchorPair<T, U>) -> ConstraintPair {
        return self.finalize(constraintsGreaterThanOrEqualToEdges: rhs)
    }

    @discardableResult public func matchOrMore(_ rhs: LayoutExpression<AnchorPair<T, U>, CGFloat>) -> ConstraintPair {
        return self.finalize(constraintsGreaterThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
    }
}

extension AnchorPair where T: NSLayoutDimension, U: NSLayoutDimension {
    @discardableResult public func matchOrMore(_ rhs: CGSize) -> ConstraintPair {
        return self.finalize(constraintsGreaterThanOrEqualToConstant: rhs)
    }

    @discardableResult public func matchOrMore(_ rhs: LayoutExpression<AnchorPair<NSLayoutDimension, NSLayoutDimension>, CGSize>) -> ConstraintPair {
        return self.finalize(constraintsGreaterThanOrEqualToConstant: rhs.constant, priority: rhs.priority)
    }
}

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
//
//// MARK: - Batching
//
///// Any Anchorage constraints created inside the passed closure are returned in the array.
/////
///// - Parameter closure: A closure that runs some Anchorage expressions.
///// - Returns: An array of new, active `NSLayoutConstraint`s.
//@discardableResult public func batch(_ closure: () -> Void) -> [NSLayoutConstraint] {
//    return batch(active: true, closure: closure)
//}
//
///// Any Anchorage constraints created inside the passed closure are returned in the array.
/////
///// - Parameter active: Whether the created constraints should be active when they are returned.
///// - Parameter closure: A closure that runs some Anchorage expressions.
///// - Returns: An array of new `NSLayoutConstraint`s.
//public func batch(active: Bool, closure: () -> Void) -> [NSLayoutConstraint] {
//    let batch = ConstraintBatch()
//    batches.append(batch)
//    defer {
//        batches.removeLast()
//    }
//
//    closure()
//
//    if active {
//        batch.activate()
//    }
//
//    return batch.constraints
//}

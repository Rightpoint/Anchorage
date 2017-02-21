//
//  AnchorageCompatibility.swift
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
    
#if swift(>=3.0)
#else

    // MARK: - Compatability Equality Constraints

    public func == (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(equalToConstant: rhs))
    }

    public func == (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(equalTo: rhs))
    }

    public func == (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(equalTo: rhs))
    }

    public func == (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(equalTo: rhs))
    }

    public func == <T: NSLayoutDimension>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(equalTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
    }

    public func == <T: NSLayoutXAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(equalTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
    }

    public func == <T: NSLayoutYAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(equalTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
    }

    public func == (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
        if let anchor = rhs.anchor {
            return activate(constraint: lhs.constraint(equalTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
        }
        else {
            return activate(constraint: lhs.constraint(equalToConstant: rhs.constant), withPriority: rhs.priority)
        }
    }

    public func == (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeGroup {
        return lhs.activate(constraintsEqualToEdges: rhs)
    }

    public func == (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeGroup {
        return lhs.activate(constraintsEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
    }

    public func == <T: LayoutAxisType, U: LayoutAxisType> (lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> AxisGroup {
        return lhs.activate(constraintsEqualToEdges: rhs)
    }

    public func == <T: LayoutAxisType, U: LayoutAxisType> (lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>>) -> AxisGroup {
        return lhs.activate(constraintsEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
    }

    // MARK: - Compatability Inequality Constraints

    public func <= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(lessThanOrEqualToConstant: rhs))
    }

    public func <= <T: NSLayoutDimension>(lhs: T, rhs: T) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
    }

    public func <= <T: NSLayoutXAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
    }

    public func <= <T: NSLayoutYAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
    }

    public func <= <T: NSLayoutDimension>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
    }

    public func <= <T: NSLayoutXAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
    }

    public func <= <T: NSLayoutYAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
    }

    public func <= (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
        if let anchor = rhs.anchor {
            return activate(constraint: lhs.constraint(lessThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
        }
        else {
            return activate(constraint: lhs.constraint(lessThanOrEqualToConstant: rhs.constant), withPriority: rhs.priority)
        }
    }

    public func <= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeGroup {
        return lhs.activate(constraintsLessThanOrEqualToEdges: rhs)
    }

    public func <= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeGroup {
        return lhs.activate(constraintsLessThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
    }

    public func <= <T: LayoutAxisType, U: LayoutAxisType> (lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> AxisGroup {
        return lhs.activate(constraintsLessThanOrEqualToEdges: rhs)
    }

    public func <= <T: LayoutAxisType, U: LayoutAxisType> (lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>>) -> AxisGroup {
        return lhs.activate(constraintsLessThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
    }

    public func >= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(greaterThanOrEqualToConstant: rhs))
    }

    public func >= <T: NSLayoutDimension>(lhs: T, rhs: T) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
    }

    public func >= <T: NSLayoutXAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
    }

    public func >= <T: NSLayoutYAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
    }

    public func >= <T: NSLayoutDimension>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
    }

    public func >= <T: NSLayoutXAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
    }

    public func >= <T: NSLayoutYAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
        return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
    }

    public func >= (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
        if let anchor = rhs.anchor {
            return activate(constraint: lhs.constraint(greaterThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
        }
        else {
            return activate(constraint: lhs.constraint(greaterThanOrEqualToConstant: rhs.constant), withPriority: rhs.priority)
        }
    }

    public func >= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeGroup {
        return lhs.activate(constraintsGreaterThanOrEqualToEdges: rhs)
    }

    public func >= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeGroup {
        return lhs.activate(constraintsGreaterThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
    }

    public func >= <T: LayoutAxisType, U: LayoutAxisType> (lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> AxisGroup {
        return lhs.activate(constraintsGreaterThanOrEqualToEdges: rhs)
    }

    public func >= <T: LayoutAxisType, U: LayoutAxisType> (lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>>) -> AxisGroup {
        return lhs.activate(constraintsGreaterThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
    }

    // MARK: Compatability Priority

    infix operator ~ {
    associativity none
    precedence 135
    }

    public func ~ (lhs: CGFloat, rhs: Alias.LayoutPriority) -> LayoutExpression<NSLayoutDimension> {
        return LayoutExpression(constant: lhs, priority: rhs)
    }

    public func ~ <T: LayoutAnchorType>(lhs: T, rhs: Alias.LayoutPriority) -> LayoutExpression<T> {
        return LayoutExpression(anchor: lhs, priority: rhs)
    }

    public func ~ <T: LayoutAnchorType>(lhs: LayoutExpression<T>, rhs: Alias.LayoutPriority) -> LayoutExpression<T> {
        var expr = lhs
        expr.priority = rhs
        return expr
    }

    // MARK: Compatability Layout Expressions

    public func * (lhs: NSLayoutDimension, rhs: CGFloat) -> LayoutExpression<NSLayoutDimension> {
        return LayoutExpression(anchor: lhs, multiplier: rhs)
    }

    public func * (lhs: CGFloat, rhs: NSLayoutDimension) -> LayoutExpression<NSLayoutDimension> {
        return LayoutExpression(anchor: rhs, multiplier: lhs)
    }

    public func * (lhs: LayoutExpression<NSLayoutDimension>, rhs: CGFloat) -> LayoutExpression<NSLayoutDimension> {
        var expr = lhs
        expr.multiplier *= rhs
        return expr
    }

    public func * (lhs: CGFloat, rhs: LayoutExpression<NSLayoutDimension>) -> LayoutExpression<NSLayoutDimension> {
        var expr = rhs
        expr.multiplier *= lhs
        return expr
    }

    public func / (lhs: NSLayoutDimension, rhs: CGFloat) -> LayoutExpression<NSLayoutDimension> {
        return LayoutExpression(anchor: lhs, multiplier: 1.0 / rhs)
    }

    public func / (lhs: LayoutExpression<NSLayoutDimension>, rhs: CGFloat) -> LayoutExpression<NSLayoutDimension> {
        var expr = lhs
        expr.multiplier /= rhs
        return expr
    }

    public func + <T: LayoutAnchorType>(lhs: T, rhs: CGFloat) -> LayoutExpression<T> {
        return LayoutExpression(anchor: lhs, constant: rhs)
    }

    public func + <T: LayoutAnchorType>(lhs: CGFloat, rhs: T) -> LayoutExpression<T> {
        return LayoutExpression(anchor: rhs, constant: lhs)
    }

    public func + <T: LayoutAnchorType>(lhs: LayoutExpression<T>, rhs: CGFloat) -> LayoutExpression<T> {
        var expr = lhs
        expr.constant += rhs
        return expr
    }

    public func + <T: LayoutAnchorType>(lhs: CGFloat, rhs: LayoutExpression<T>) -> LayoutExpression<T> {
        var expr = rhs
        expr.constant += lhs
        return expr
    }

    public func - <T: LayoutAnchorType>(lhs: T, rhs: CGFloat) -> LayoutExpression<T> {
        return LayoutExpression(anchor: lhs, constant: -rhs)
    }

    public func - <T: LayoutAnchorType>(lhs: CGFloat, rhs: T) -> LayoutExpression<T> {
        return LayoutExpression(anchor: rhs, constant: -lhs)
    }

    public func - <T: LayoutAnchorType>(lhs: LayoutExpression<T>, rhs: CGFloat) -> LayoutExpression<T> {
        var expr = lhs
        expr.constant -= rhs
        return expr
    }

    public func - <T: LayoutAnchorType>(lhs: CGFloat, rhs: LayoutExpression<T>) -> LayoutExpression<T> {
        var expr = rhs
        expr.constant -= lhs
        return expr
    }

    // MARK: - Internal Compatability Extensions

    extension NSLayoutConstraint {
        @nonobjc var isActive: Bool {

            set (newVal) {
                active = newVal
            }

            get {
                return active
            }
        }
    }

    extension Array where Element: Equatable  {
        func index(of element: Element) -> Int? {
            return indexOf(element)
        }
    }

    extension UILayoutConstraintAxis {
        static let horizontal = UILayoutConstraintAxis.Horizontal
        static let vertical = UILayoutConstraintAxis.Vertical
    }

    // MARK: - Priavate Compatability Extensions

    private extension NSLayoutAnchor {

        @nonobjc final func constraint(equalTo anchor: NSLayoutAnchor) -> NSLayoutConstraint {
            return constraintEqualToAnchor(anchor)
        }

        @nonobjc final func constraint(greaterThanOrEqualTo anchor: NSLayoutAnchor) -> NSLayoutConstraint {
            return constraintGreaterThanOrEqualToAnchor(anchor)
        }

        @nonobjc final func constraint(lessThanOrEqualTo anchor: NSLayoutAnchor) -> NSLayoutConstraint {
            return constraintLessThanOrEqualToAnchor(anchor)
        }

        @nonobjc final func constraint(equalTo anchor: NSLayoutAnchor, constant c: CGFloat) -> NSLayoutConstraint {
            return constraintEqualToAnchor(anchor, constant: c)
        }

        @nonobjc final func constraint(greaterThanOrEqualTo anchor: NSLayoutAnchor, constant c: CGFloat) -> NSLayoutConstraint {
            return constraintGreaterThanOrEqualToAnchor(anchor, constant: c)
        }

        @nonobjc final func constraint(lessThanOrEqualTo anchor: NSLayoutAnchor, constant c: CGFloat) -> NSLayoutConstraint {
            return constraintLessThanOrEqualToAnchor(anchor, constant: c)
        }
    }

    private extension NSLayoutDimension {

        @nonobjc final func constraint(equalToConstant c: CGFloat) -> NSLayoutConstraint {
            return constraintEqualToConstant(c)
        }

        @nonobjc final func constraint(greaterThanOrEqualToConstant c: CGFloat) -> NSLayoutConstraint {
            return constraintGreaterThanOrEqualToConstant(c)
        }

        @nonobjc final func constraint(lessThanOrEqualToConstant c: CGFloat) -> NSLayoutConstraint {
            return constraintLessThanOrEqualToConstant(c)
        }

        @nonobjc final func constraint(equalTo anchor: NSLayoutDimension, multiplier m: CGFloat) -> NSLayoutConstraint {
            return constraintEqualToAnchor(anchor, multiplier: m)
        }

        @nonobjc final func constraint(greaterThanOrEqualTo anchor: NSLayoutDimension, multiplier m: CGFloat) -> NSLayoutConstraint {
            return constraintGreaterThanOrEqualToAnchor(anchor, multiplier: m)
        }

        @nonobjc final func constraint(lessThanOrEqualTo anchor: NSLayoutDimension, multiplier m: CGFloat) -> NSLayoutConstraint {
            return constraintLessThanOrEqualToAnchor(anchor, multiplier: m)
        }

        @nonobjc final func constraint(equalTo anchor: NSLayoutDimension, multiplier m: CGFloat, constant c: CGFloat) -> NSLayoutConstraint {
            return constraintEqualToAnchor(anchor, multiplier: m, constant: c)
        }

        @nonobjc final func constraint(greaterThanOrEqualTo anchor: NSLayoutDimension, multiplier m: CGFloat, constant c: CGFloat) -> NSLayoutConstraint {
            return constraintGreaterThanOrEqualToAnchor(anchor, multiplier: m, constant: c)
        }

        @nonobjc final func constraint(lessThanOrEqualTo anchor: NSLayoutDimension, multiplier m: CGFloat, constant c: CGFloat) -> NSLayoutConstraint {
            return constraintLessThanOrEqualToAnchor(anchor, multiplier: m, constant: c)
        }
    }

#endif

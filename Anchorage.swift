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

import UIKit

public protocol LayoutAnchorType {}
extension NSLayoutDimension : LayoutAnchorType {}
extension NSLayoutXAxisAnchor : LayoutAnchorType {}
extension NSLayoutYAxisAnchor : LayoutAnchorType {}

public protocol LayoutAxisType {}
extension NSLayoutXAxisAnchor : LayoutAxisType {}
extension NSLayoutYAxisAnchor : LayoutAxisType {}

#if swift(>=3.0)

    // MARK: - Equality Constraints

@discardableResult public func == (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(equalToConstant: rhs))
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

@discardableResult public func == (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeConstraints {
    return lhs.activeConstraints(equalTo: rhs)
}

@discardableResult public func == (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeConstraints {
    return lhs.activeConstraints(equalTo: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

// MARK: - Inequality Constraints

@discardableResult public func <= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(lessThanOrEqualToConstant: rhs))
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

@discardableResult public func <= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeConstraints {
    return lhs.activeConstraints(lessThanOrEqualTo: rhs)
}

@discardableResult public func <= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeConstraints {
    return lhs.activeConstraints(lessThanOrEqualTo: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func >= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(greaterThanOrEqualToConstant: rhs))
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

@discardableResult public func >= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeConstraints {
    return lhs.activeConstraints(greaterThanOrEqualTo: rhs)
}

@discardableResult public func >= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeConstraints {
    return lhs.activeConstraints(greaterThanOrEqualTo: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

// MARK: - Priority

precedencegroup PriorityPrecedence {
    associativity: none
    higherThan: ComparisonPrecedence
}

infix operator ~: PriorityPrecedence

@discardableResult public func ~ (lhs: CGFloat, rhs: UILayoutPriority) -> LayoutExpression<NSLayoutDimension> {
    return LayoutExpression(constant: lhs, priority: rhs)
}

@discardableResult public func ~ <T: LayoutAnchorType>(lhs: T, rhs: UILayoutPriority) -> LayoutExpression<T> {
    return LayoutExpression(anchor: lhs, priority: rhs)
}

@discardableResult public func ~ <T: LayoutAnchorType>(lhs: LayoutExpression<T>, rhs: UILayoutPriority) -> LayoutExpression<T> {
    var expr = lhs
    expr.priority = rhs
    return expr
}

// MARK: Layout Expressions

@discardableResult public func * (lhs: NSLayoutDimension, rhs: CGFloat) -> LayoutExpression<NSLayoutDimension> {
    return LayoutExpression(anchor: lhs, multiplier: rhs)
}

@discardableResult public func * (lhs: CGFloat, rhs: NSLayoutDimension) -> LayoutExpression<NSLayoutDimension> {
    return LayoutExpression(anchor: rhs, multiplier: lhs)
}

@discardableResult public func * (lhs: LayoutExpression<NSLayoutDimension>, rhs: CGFloat) -> LayoutExpression<NSLayoutDimension> {
    var expr = lhs
    expr.multiplier *= rhs
    return expr
}

@discardableResult public func * (lhs: CGFloat, rhs: LayoutExpression<NSLayoutDimension>) -> LayoutExpression<NSLayoutDimension> {
    var expr = rhs
    expr.multiplier *= lhs
    return expr
}

@discardableResult public func / (lhs: NSLayoutDimension, rhs: CGFloat) -> LayoutExpression<NSLayoutDimension> {
    return LayoutExpression(anchor: lhs, multiplier: 1.0 / rhs)
}

@discardableResult public func / (lhs: LayoutExpression<NSLayoutDimension>, rhs: CGFloat) -> LayoutExpression<NSLayoutDimension> {
    var expr = lhs
    expr.multiplier /= rhs
    return expr
}

@discardableResult public func + <T: LayoutAnchorType>(lhs: T, rhs: CGFloat) -> LayoutExpression<T> {
    return LayoutExpression(anchor: lhs, constant: rhs)
}

@discardableResult public func + <T: LayoutAnchorType>(lhs: CGFloat, rhs: T) -> LayoutExpression<T> {
    return LayoutExpression(anchor: rhs, constant: lhs)
}

@discardableResult public func + <T: LayoutAnchorType>(lhs: LayoutExpression<T>, rhs: CGFloat) -> LayoutExpression<T> {
    var expr = lhs
    expr.constant += rhs
    return expr
}

@discardableResult public func + <T: LayoutAnchorType>(lhs: CGFloat, rhs: LayoutExpression<T>) -> LayoutExpression<T> {
    var expr = rhs
    expr.constant += lhs
    return expr
}

@discardableResult public func - <T: LayoutAnchorType>(lhs: T, rhs: CGFloat) -> LayoutExpression<T> {
    return LayoutExpression(anchor: lhs, constant: -rhs)
}

@discardableResult public func - <T: LayoutAnchorType>(lhs: CGFloat, rhs: T) -> LayoutExpression<T> {
    return LayoutExpression(anchor: rhs, constant: -lhs)
}

@discardableResult public func - <T: LayoutAnchorType>(lhs: LayoutExpression<T>, rhs: CGFloat) -> LayoutExpression<T> {
    var expr = lhs
    expr.constant -= rhs
    return expr
}

@discardableResult public func - <T: LayoutAnchorType>(lhs: CGFloat, rhs: LayoutExpression<T>) -> LayoutExpression<T> {
    var expr = rhs
    expr.constant -= lhs
    return expr
}

#endif

public struct LayoutExpression<T : LayoutAnchorType> {

    var anchor: T?
    var constant: CGFloat
    var multiplier: CGFloat
    var priority: UILayoutPriority

    init(anchor: T? = nil, constant: CGFloat = 0.0, multiplier: CGFloat = 1.0, priority: UILayoutPriority = UILayoutPriorityRequired) {
        self.anchor = anchor
        self.constant = constant
        self.multiplier = multiplier
        self.priority = priority
    }

}

// MARK: - EdgeAnchorsProvider

public protocol AnchorGroupProvider {

    var horizontalAnchors: AxisAnchors<NSLayoutXAxisAnchor> { get }
    var verticalAnchors: AxisAnchors<NSLayoutYAxisAnchor> { get }

}

extension AnchorGroupProvider {

    public var edgeAnchors: EdgeAnchors {
        return EdgeAnchors(horizontal: horizontalAnchors, vertical: verticalAnchors)
    }

}


extension UIView: AnchorGroupProvider {

    public var horizontalAnchors: AxisAnchors<NSLayoutXAxisAnchor> {
        return AxisAnchors(leading: leadingAnchor, trailing: trailingAnchor)
    }
    public var verticalAnchors: AxisAnchors<NSLayoutYAxisAnchor> {
        return AxisAnchors(leading: topAnchor, trailing: bottomAnchor)
    }

}

extension UIViewController: AnchorGroupProvider {

    public var horizontalAnchors: AxisAnchors<NSLayoutXAxisAnchor> {
        return AxisAnchors(leading: view.leadingAnchor, trailing: view.trailingAnchor)
    }
    public var verticalAnchors: AxisAnchors<NSLayoutYAxisAnchor> {
        return AxisAnchors(leading: topLayoutGuide.bottomAnchor, trailing: bottomLayoutGuide.topAnchor)
    }

}

extension UILayoutGuide: AnchorGroupProvider {

    public var horizontalAnchors: AxisAnchors<NSLayoutXAxisAnchor> {
        return AxisAnchors(leading: leadingAnchor, trailing: trailingAnchor)
    }
    public var verticalAnchors: AxisAnchors<NSLayoutYAxisAnchor> {
        return AxisAnchors(leading: topAnchor, trailing: bottomAnchor)
    }
    
}

// MARK: - LayoutEdge

enum LayoutEdge {

    case top, leading, bottom, trailing
    static let Horizontal = [leading, trailing]
    static let Vertical = [top, bottom]
    static let All = [top, leading, bottom, trailing]

    func transform(constant theConstant: CGFloat) -> CGFloat {
        switch self {
        case .top, .leading:
            return theConstant
        case .bottom, .trailing:
            return -theConstant
        }
    }

}

// MARK: - EdgeAnchors

public struct AxisAnchors<T: LayoutAxisType>: LayoutAnchorType {
    private var leading: T
    private var trailing: T

    init(leading: T, trailing: T) {
        self.leading = leading
        self.trailing = trailing
    }

    public func activate(constraintsEqualToEdges anchor: AxisAnchors<T>?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> EdgeConstraints {
        let builder = ConstraintBuilder(horizontal: ==, vertical: ==)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    public func activate(constraintsLessThanOrEqualToEdges anchor: AxisAnchors<T>?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> EdgeConstraints {
        let builder = ConstraintBuilder(leading: <=, top: <=, trailing: >=, bottom: >=)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    public func activate(constraintsGreaterThanOrEqualToEdges anchor: AxisAnchors<T>?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> EdgeConstraints {
        let builder = ConstraintBuilder(leading: >=, top: >=, trailing: <=, bottom: <=)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    subscript (edge: LayoutEdge) -> LayoutAxisType? {
        switch edge {
        case .leading:  return leading
        case .trailing: return trailing
        default: return nil
        }
    }

    private func constraints(forAnchors anchors: AxisAnchors<T>?, constant c: CGFloat, priority: UILayoutPriority, builder: ConstraintBuilder) -> EdgeConstraints {
        guard let anchors = anchors else {
            preconditionFailure("Encountered nil edge anchors, indicating internal inconsistency of this API.")
        }

        var edgeConstraints = EdgeConstraints()
        let edges: [LayoutEdge] = [.leading, .trailing]
        for edge in edges {
            if let x = self[edge] as? NSLayoutXAxisAnchor, otherX = anchors[edge] as? NSLayoutXAxisAnchor {
                let expression = (otherX + edge.transform(constant: c)) ~ priority
                edgeConstraints[edge] = builder.horizontalBuilder(forEdge: edge)(x, expression)
            } else if let y = self[edge] as? NSLayoutYAxisAnchor, otherY = anchors[edge] as? NSLayoutYAxisAnchor {
                let expression = (otherY + edge.transform(constant: c)) ~ priority
                edgeConstraints[edge] = builder.verticalBuilder(forEdge: edge)(y, expression)
            } else if self[edge] != nil || anchors[edge] != nil {
                preconditionFailure("Layout axes of constrained anchors must match.")
            }
        }
        return edgeConstraints
    }
}

public struct EdgeAnchors: LayoutAnchorType {
    let horizontalAnchors: AxisAnchors<NSLayoutXAxisAnchor>
    let verticalAnchors: AxisAnchors<NSLayoutYAxisAnchor>

    init(horizontal: AxisAnchors<NSLayoutXAxisAnchor>, vertical: AxisAnchors<NSLayoutYAxisAnchor>) {
        self.horizontalAnchors = horizontal
        self.verticalAnchors = vertical
    }

    public func activate(constraintsEqualToEdges anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> EdgeConstraints {
        let builder = ConstraintBuilder(horizontal: ==, vertical: ==)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    public func activate(constraintsLessThanOrEqualToEdges anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> EdgeConstraints {
        let builder = ConstraintBuilder(leading: <=, top: <=, trailing: >=, bottom: >=)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    public func activate(constraintsGreaterThanOrEqualToEdges anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> EdgeConstraints {
        let builder = ConstraintBuilder(leading: >=, top: >=, trailing: <=, bottom: <=)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    private func constraints(forAnchors anchors: EdgeAnchors?, constant c: CGFloat, priority: UILayoutPriority, builder: ConstraintBuilder) -> EdgeConstraints {
        guard let anchors = anchors else {
            preconditionFailure("Encountered nil edge anchors, indicating internal inconsistency of this API.")
        }

        let horizontalConstraints = horizontalAnchors.constraints(forAnchors: anchors.horizontalAnchors, constant: c, priority: priority, builder: builder)
        let verticalConstraints = verticalAnchors.constraints(forAnchors: anchors.verticalAnchors, constant: c, priority: priority, builder: builder)
        return EdgeConstraints(top: verticalConstraints.top,
                               leading: horizontalConstraints.leading,
                               bottom: verticalConstraints.bottom,
                               trailing: verticalConstraints.trailing)
    }
    
}

// MARK: - EdgeConstraints

public struct EdgeConstraints {

    public var top: NSLayoutConstraint?
    public var leading: NSLayoutConstraint?
    public var bottom: NSLayoutConstraint?
    public var trailing: NSLayoutConstraint?

    public var horizontal: [NSLayoutConstraint] {
        return [leading, trailing].flatMap { $0 }
    }

    public var vertical: [NSLayoutConstraint] {
        return [top, bottom].flatMap { $0 }
    }

    public var all: [NSLayoutConstraint] {
        return [top, leading, bottom, trailing].flatMap { $0 }
    }

    subscript (edge: LayoutEdge) -> NSLayoutConstraint? {
        get {
            switch edge {
            case .top:      return top
            case .leading:  return leading
            case .bottom:   return bottom
            case .trailing: return trailing
            }
        }

        set {
            switch edge {
            case .top:      top = newValue
            case .leading:  leading = newValue
            case .bottom:   bottom = newValue
            case .trailing: trailing = newValue
            }
        }
    }

}

// MARK: - Constraint Builders

private struct ConstraintBuilder {

    typealias Horizontal = (NSLayoutXAxisAnchor, LayoutExpression<NSLayoutXAxisAnchor>) -> NSLayoutConstraint
    typealias Vertical = (NSLayoutYAxisAnchor, LayoutExpression<NSLayoutYAxisAnchor>) -> NSLayoutConstraint

    var top: Vertical
    var leading: Horizontal
    var bottom: Vertical
    var trailing: Horizontal

    #if swift(>=3.0)
    init(horizontal: @escaping Horizontal, vertical: @escaping Vertical) {
    top = vertical
    leading = horizontal
    bottom = vertical
    trailing = horizontal
    }
    init(leading: @escaping Horizontal, top: @escaping Vertical, trailing: @escaping Horizontal, bottom: @escaping Vertical) {
    self.leading = leading
    self.top = top
    self.trailing = trailing
    self.bottom = bottom
    }
    #else
    init(horizontal: Horizontal, vertical: Vertical) {
        top = vertical
        leading = horizontal
        bottom = vertical
        trailing = horizontal
    }
    init(leading: Horizontal, top: Vertical, trailing: Horizontal, bottom: Vertical) {
        self.leading = leading
        self.top = top
        self.trailing = trailing
        self.bottom = bottom
    }
    #endif

    func horizontalBuilder(forEdge edge: LayoutEdge) -> Horizontal {
        return (edge == .leading) ? leading : trailing
    }

    func verticalBuilder(forEdge edge: LayoutEdge) -> Vertical {
        return (edge == .top) ? top : bottom
    }

}

// MARK: - Constraint Activation

func activate(constraint theConstraint: NSLayoutConstraint, withPriority priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
    // Only disable autoresizing constraints on the LHS item, which is the one definitely intended to be governed by Auto Layout
    if let first = theConstraint.firstItem as? UIView {
        first.translatesAutoresizingMaskIntoConstraints = false
    }

    theConstraint.priority = priority
    theConstraint.isActive = true

    return theConstraint
}

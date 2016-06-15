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

public protocol AnchorType {}
extension NSLayoutAnchor : AnchorType {}

// MARK: - Equality Constraints

infix operator == {
associativity none
precedence 130
}

public func == (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraintEqualToConstant(rhs))
}

public func == (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraintEqualToAnchor(rhs))
}

public func == (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraintEqualToAnchor(rhs))
}

public func == (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraintEqualToAnchor(rhs))
}

public func == <T: NSLayoutAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraintEqualToAnchor(rhs.anchor, constant: rhs.constant), withPriority: rhs.priority)
}

public func == (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return activateConstraint(lhs.constraintEqualToAnchor(anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return activateConstraint(lhs.constraintEqualToConstant(rhs.constant), withPriority: rhs.priority)
    }
}

public func == (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeConstraints {
    return lhs.activeConstraintsEqualToEdges(rhs)
}

public func == (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeConstraints {
    return lhs.activeConstraintsEqualToEdges(rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

// MARK: - Inequality Constraints

public func <= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraintLessThanOrEqualToConstant(rhs))
}

public func <= <T: NSLayoutAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraintLessThanOrEqualToAnchor(rhs))
}

public func <= <T: NSLayoutAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraintLessThanOrEqualToAnchor(rhs.anchor, constant: rhs.constant), withPriority: rhs.priority)
}

public func <= (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return activateConstraint(lhs.constraintLessThanOrEqualToAnchor(anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return activateConstraint(lhs.constraintLessThanOrEqualToConstant(rhs.constant), withPriority: rhs.priority)
    }
}

public func <= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeConstraints {
    return lhs.activeConstraintsLessThanOrEqualToEdges(rhs)
}

public func <= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeConstraints {
    return lhs.activeConstraintsLessThanOrEqualToEdges(rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

public func >= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraintGreaterThanOrEqualToConstant(rhs))
}

public func >=<T: NSLayoutAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraintGreaterThanOrEqualToAnchor(rhs))
}

public func >= <T: NSLayoutAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraintGreaterThanOrEqualToAnchor(rhs.anchor, constant: rhs.constant), withPriority: rhs.priority)
}

public func >= (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return activateConstraint(lhs.constraintGreaterThanOrEqualToAnchor(anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return activateConstraint(lhs.constraintGreaterThanOrEqualToConstant(rhs.constant), withPriority: rhs.priority)
    }
}

public func >= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeConstraints {
    return lhs.activeConstraintsGreaterThanOrEqualToEdges(rhs)
}

public func >= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeConstraints {
    return lhs.activeConstraintsGreaterThanOrEqualToEdges(rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

// MARK: - Priority

infix operator ~ {
associativity none
precedence 135
}

public func ~ (lhs: CGFloat, rhs: UILayoutPriority) -> LayoutExpression<NSLayoutDimension> {
    return LayoutExpression(constant: lhs, priority: rhs)
}

public func ~ <T: AnchorType>(lhs: T, rhs: UILayoutPriority) -> LayoutExpression<T> {
    return LayoutExpression(anchor: lhs, priority: rhs)
}

public func ~ <T: AnchorType>(lhs: LayoutExpression<T>, rhs: UILayoutPriority) -> LayoutExpression<T> {
    var expr = lhs
    expr.priority = rhs
    return expr
}

// MARK: Layout Expressions

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

public func + <T: AnchorType>(lhs: T, rhs: CGFloat) -> LayoutExpression<T> {
    return LayoutExpression(anchor: lhs, constant: rhs)
}

public func + <T: AnchorType>(lhs: CGFloat, rhs: T) -> LayoutExpression<T> {
    return LayoutExpression(anchor: rhs, constant: lhs)
}

public func + <T: AnchorType>(lhs: LayoutExpression<T>, rhs: CGFloat) -> LayoutExpression<T> {
    var expr = lhs
    expr.constant += rhs
    return expr
}

public func + <T: AnchorType>(lhs: CGFloat, rhs: LayoutExpression<T>) -> LayoutExpression<T> {
    var expr = rhs
    expr.constant += lhs
    return expr
}

public func - <T: AnchorType>(lhs: T, rhs: CGFloat) -> LayoutExpression<T> {
    return LayoutExpression(anchor: lhs, constant: -rhs)
}

public func - <T: AnchorType>(lhs: CGFloat, rhs: T) -> LayoutExpression<T> {
    return LayoutExpression(anchor: rhs, constant: -lhs)
}

public func - <T: AnchorType>(lhs: LayoutExpression<T>, rhs: CGFloat) -> LayoutExpression<T> {
    var expr = lhs
    expr.constant -= rhs
    return expr
}

public func - <T: AnchorType>(lhs: CGFloat, rhs: LayoutExpression<T>) -> LayoutExpression<T> {
    var expr = rhs
    expr.constant -= lhs
    return expr
}

public struct LayoutExpression<T : AnchorType> {

    private var anchor: T?
    private var constant: CGFloat
    private var multiplier: CGFloat
    private var priority: UILayoutPriority

    private init(anchor: T? = nil, constant: CGFloat = 0.0, multiplier: CGFloat = 1.0, priority: UILayoutPriority = UILayoutPriorityRequired) {
        self.anchor = anchor
        self.constant = constant
        self.multiplier = multiplier
        self.priority = priority
    }

}

// MARK: - EdgeAnchorsProvider

public protocol EdgeAnchorsProvider {

    var edgeAnchors: EdgeAnchors { get }

}

extension EdgeAnchorsProvider {

    public var horizontalAnchors: EdgeAnchors {
        return edgeAnchors.filter(LayoutEdge.Horizontal)
    }

    public var verticalAnchors: EdgeAnchors {
        return edgeAnchors.filter(LayoutEdge.Vertical)
    }

}

extension UIView: EdgeAnchorsProvider {

    public var edgeAnchors: EdgeAnchors {
        return EdgeAnchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }

}

extension UIViewController: EdgeAnchorsProvider {

    public var edgeAnchors: EdgeAnchors {
        return EdgeAnchors(top: topLayoutGuide.bottomAnchor, leading: view.leadingAnchor, bottom: bottomLayoutGuide.topAnchor, trailing: view.trailingAnchor)
    }

}

extension UILayoutGuide: EdgeAnchorsProvider {

    public var edgeAnchors: EdgeAnchors {
        return EdgeAnchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }

}

// MARK: - LayoutEdge

private enum LayoutEdge {

    case Top, Leading, Bottom, Trailing

    static let Horizontal = [Leading, Trailing]
    static let Vertical = [Top, Bottom]
    static let All = [Top, Leading, Bottom, Trailing]

    var axis: UILayoutConstraintAxis {
        switch self {
        case .Top, .Bottom:
            return .Vertical
        case .Leading, .Trailing:
            return .Horizontal
        }
    }

    func transformConstant(c: CGFloat) -> CGFloat {
        switch self {
        case .Top, .Leading:
            return c
        case .Bottom, .Trailing:
            return -c
        }
    }

}

// MARK: - EdgeAnchors

public struct EdgeAnchors: AnchorType {

    private var top: NSLayoutYAxisAnchor
    private var leading: NSLayoutXAxisAnchor
    private var bottom: NSLayoutYAxisAnchor
    private var trailing: NSLayoutXAxisAnchor

    private var includedEdges = LayoutEdge.All

    private init(top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor, trailing: NSLayoutXAxisAnchor) {
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }

    private func filter(filter: [LayoutEdge]) -> EdgeAnchors {
        var filteredAnchors = self
        filteredAnchors.includedEdges = includedEdges.filter { filter.contains($0) }

        return filteredAnchors
    }

    public func activeConstraintsEqualToEdges(anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> EdgeConstraints {
        return constraintsForAnchors(anchor, constant: c, priority: priority, builder: ConstraintBuilder(horizontal: ==, vertical: ==))
    }

    public func activeConstraintsLessThanOrEqualToEdges(anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> EdgeConstraints {
        var constraintBuilder = ConstraintBuilder(horizontal: <=, vertical: <=)

        if includedEdges.contains(.Leading) && includedEdges.indexOf(.Trailing) == anchor?.includedEdges.indexOf(.Trailing) {
            constraintBuilder.trailing = (>=)
        }

        if includedEdges.contains(.Top) && includedEdges.indexOf(.Bottom) == anchor?.includedEdges.indexOf(.Bottom) {
            constraintBuilder.bottom = (>=)
        }

        return constraintsForAnchors(anchor, constant: c, priority: priority, builder: constraintBuilder)
    }

    public func activeConstraintsGreaterThanOrEqualToEdges(anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> EdgeConstraints {
        var constraintBuilder = ConstraintBuilder(horizontal: >=, vertical: >=)

        if includedEdges.contains(.Leading) && includedEdges.indexOf(.Trailing) == anchor?.includedEdges.indexOf(.Trailing) {
            constraintBuilder.trailing = (<=)
        }

        if includedEdges.contains(.Top) && includedEdges.indexOf(.Bottom) == anchor?.includedEdges.indexOf(.Bottom) {
            constraintBuilder.bottom = (<=)
        }

        return constraintsForAnchors(anchor, constant: c, priority: priority, builder: constraintBuilder)
    }

    private subscript (edge: LayoutEdge) -> NSLayoutAnchor {
        switch edge {
        case .Top:      return top
        case .Leading:  return leading
        case .Bottom:   return bottom
        case .Trailing: return trailing
        }
    }

    private func constraintsForAnchors(anchors: EdgeAnchors?, constant c: CGFloat, priority: UILayoutPriority, builder: ConstraintBuilder) -> EdgeConstraints {
        guard let anchors = anchors else {
            preconditionFailure("Encountered nil edge anchors, indicating internal inconsistency of this API.")
        }

        var edgeConstraints = EdgeConstraints()

        zip(includedEdges, anchors.includedEdges).forEach { (edge, otherEdge) in
            edgeConstraints[edge] = {
                switch (self[edge], anchors[otherEdge]) {

                case let (x as NSLayoutXAxisAnchor, otherX as NSLayoutXAxisAnchor):
                    let expression = (otherX + edge.transformConstant(c)) ~ priority
                    return builder.horizontalBuilderForEdge(edge)(x, expression)

                case let (y as NSLayoutYAxisAnchor, otherY as NSLayoutYAxisAnchor):
                    let expression = (otherY + edge.transformConstant(c)) ~ priority
                    return builder.verticalBuilderForEdge(edge)(y, expression)

                default:
                    preconditionFailure("Layout axis of constrained anchors must match.")
                }
                }()
        }

        return edgeConstraints
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

    private subscript (edge: LayoutEdge) -> NSLayoutConstraint? {
        get {
            switch edge {
            case .Top:      return top
            case .Leading:  return leading
            case .Bottom:   return bottom
            case .Trailing: return trailing
            }
        }

        set {
            switch edge {
            case .Top:      top = newValue
            case .Leading:  leading = newValue
            case .Bottom:   bottom = newValue
            case .Trailing: trailing = newValue
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

    init(horizontal: Horizontal, vertical: Vertical) {
        top = vertical
        leading = horizontal
        bottom = vertical
        trailing = horizontal
    }

    func horizontalBuilderForEdge(edge: LayoutEdge) -> Horizontal {
        assert(edge.axis == .Horizontal)
        return (edge == .Leading) ? leading : trailing
    }

    func verticalBuilderForEdge(edge: LayoutEdge) -> Vertical {
        assert(edge.axis == .Vertical)
        return (edge == .Top) ? top : bottom
    }

}

// MARK: - Constraint Activation

private func activateConstraint(constraint: NSLayoutConstraint, withPriority priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
    // Only disable autoresizing constraints on the LHS item, which is the one definitely intended to be governed by Auto Layout
    if let first = constraint.firstItem as? UIView {
        first.translatesAutoresizingMaskIntoConstraints = false
    }
    
    constraint.priority = priority
    constraint.active = true
    
    return constraint
}

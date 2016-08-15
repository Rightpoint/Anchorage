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

// MARK: - Equality Constraints

@discardableResult public func == (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(equalToConstant: rhs))
}

@discardableResult public func == (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(equalTo: rhs))
}

@discardableResult public func == (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(equalTo: rhs))
}

@discardableResult public func == (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(equalTo: rhs))
}

@discardableResult public func == <T: NSLayoutDimension>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(equalTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func == <T: NSLayoutXAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(equalTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func == <T: NSLayoutYAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(equalTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func == (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return activateConstraint(lhs.constraint(equalTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return activateConstraint(lhs.constraint(equalToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult public func == (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeConstraints {
    return lhs.activeConstraintsEqualToEdges(rhs)
}

@discardableResult public func == (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeConstraints {
    return lhs.activeConstraintsEqualToEdges(rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

// MARK: - Inequality Constraints

@discardableResult public func <= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(lessThanOrEqualToConstant: rhs))
}

@discardableResult public func <= <T: NSLayoutDimension>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(lessThanOrEqualTo: rhs))
}
@discardableResult public func <= <T: NSLayoutXAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(lessThanOrEqualTo: rhs))
}
@discardableResult public func <= <T: NSLayoutYAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(lessThanOrEqualTo: rhs))
}

@discardableResult public func <= <T: NSLayoutDimension>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(lessThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}
@discardableResult public func <= <T: NSLayoutXAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(lessThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}
@discardableResult public func <= <T: NSLayoutYAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(lessThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func <= (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return activateConstraint(lhs.constraint(lessThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return activateConstraint(lhs.constraint(lessThanOrEqualToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult public func <= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeConstraints {
    return lhs.activeConstraintsLessThanOrEqualToEdges(rhs)
}

@discardableResult public func <= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeConstraints {
    return lhs.activeConstraintsLessThanOrEqualToEdges(rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func >= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(greaterThanOrEqualToConstant: rhs))
}

@discardableResult public func >=<T: NSLayoutDimension>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(greaterThanOrEqualTo: rhs))
}

@discardableResult public func >=<T: NSLayoutXAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(greaterThanOrEqualTo: rhs))
}

@discardableResult public func >=<T: NSLayoutYAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(greaterThanOrEqualTo: rhs))
}

@discardableResult public func >= <T: NSLayoutDimension>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func >= <T: NSLayoutXAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func >= <T: NSLayoutYAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activateConstraint(lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func >= (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return activateConstraint(lhs.constraint(greaterThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return activateConstraint(lhs.constraint(greaterThanOrEqualToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult public func >= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeConstraints {
    return lhs.activeConstraintsGreaterThanOrEqualToEdges(rhs)
}

@discardableResult public func >= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeConstraints {
    return lhs.activeConstraintsGreaterThanOrEqualToEdges(rhs.anchor, constant: rhs.constant, priority: rhs.priority)
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

public struct LayoutExpression<T : LayoutAnchorType> {

    fileprivate var anchor: T?
    fileprivate var constant: CGFloat
    fileprivate var multiplier: CGFloat
    fileprivate var priority: UILayoutPriority

    fileprivate init(anchor: T? = nil, constant: CGFloat = 0.0, multiplier: CGFloat = 1.0, priority: UILayoutPriority = UILayoutPriorityRequired) {
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

    case top, leading, bottom, trailing
    static let Horizontal = [leading, trailing]
    static let Vertical = [top, bottom]
    static let All = [top, leading, bottom, trailing]

    var axis: UILayoutConstraintAxis {
        switch self {
        case .top, .bottom:
            return .vertical
        case.leading, .trailing:
            return .horizontal
        }
    }

    func transform(constant: CGFloat) -> CGFloat {
        switch self {
        case .top, .leading:
            return constant
        case .bottom, .trailing:
            return -constant
        }
    }

}

// MARK: - EdgeAnchors

public struct EdgeAnchors: LayoutAnchorType {

    private var top: NSLayoutYAxisAnchor
    private var leading: NSLayoutXAxisAnchor
    private var bottom: NSLayoutYAxisAnchor
    private var trailing: NSLayoutXAxisAnchor

    private var includedEdges = LayoutEdge.All

    fileprivate init(top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor, trailing: NSLayoutXAxisAnchor) {
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }

    fileprivate func filter(_ filter: [LayoutEdge]) -> EdgeAnchors {
        var filteredAnchors = self
        filteredAnchors.includedEdges = includedEdges.filter { filter.contains($0) }

        return filteredAnchors
    }

    public func activeConstraintsEqualToEdges(_ anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> EdgeConstraints {
        return constraintsForAnchors(anchor, constant: c, priority: priority, builder: ConstraintBuilder(horizontal: ==, vertical: ==))
    }

    public func activeConstraintsLessThanOrEqualToEdges(_ anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> EdgeConstraints {
        var constraintBuilder = ConstraintBuilder(horizontal: <=, vertical: <=)

        if includedEdges.contains(.leading) && includedEdges.index(of: .trailing) == anchor?.includedEdges.index(of: .trailing) {
            constraintBuilder.trailing = (>=)
        }

        if includedEdges.contains(.top) && includedEdges.index(of: .bottom) == anchor?.includedEdges.index(of: .bottom) {
            constraintBuilder.bottom = (>=)
        }

        return constraintsForAnchors(anchor, constant: c, priority: priority, builder: constraintBuilder)
    }

    public func activeConstraintsGreaterThanOrEqualToEdges(_ anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> EdgeConstraints {
        var constraintBuilder = ConstraintBuilder(horizontal: >=, vertical: >=)

        if includedEdges.contains(.leading) && includedEdges.index(of: .trailing) == anchor?.includedEdges.index(of: .trailing) {
            constraintBuilder.trailing = (<=)
        }

        if includedEdges.contains(.top) && includedEdges.index(of: .bottom) == anchor?.includedEdges.index(of: .bottom) {
            constraintBuilder.bottom = (<=)
        }

        return constraintsForAnchors(anchor, constant: c, priority: priority, builder: constraintBuilder)
    }

    fileprivate subscript (edge: LayoutEdge) -> LayoutAnchorType {
        switch edge {
        case .top:      return top
        case .leading:  return leading
        case .bottom:   return bottom
        case .trailing: return trailing
        }
    }

    private func constraintsForAnchors(_ anchors: EdgeAnchors?, constant c: CGFloat, priority: UILayoutPriority, builder: ConstraintBuilder) -> EdgeConstraints {
        guard let anchors = anchors else {
            preconditionFailure("Encountered nil edge anchors, indicating internal inconsistency of this API.")
        }

        var edgeConstraints = EdgeConstraints()

        zip(includedEdges, anchors.includedEdges).forEach { (edge, otherEdge) in
            edgeConstraints[edge] = {
                switch (self[edge], anchors[otherEdge]) {

                case let (x as NSLayoutXAxisAnchor, otherX as NSLayoutXAxisAnchor):
                    let expression = (otherX + edge.transform(constant: c)) ~ priority
                    return builder.horizontalBuilderForEdge(edge)(x, expression)

                case let (y as NSLayoutYAxisAnchor, otherY as NSLayoutYAxisAnchor):
                    let expression = (otherY + edge.transform(constant: c)) ~ priority
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

    fileprivate subscript (edge: LayoutEdge) -> NSLayoutConstraint? {
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

    init(horizontal: Horizontal, vertical: Vertical) {
        top = vertical
        leading = horizontal
        bottom = vertical
        trailing = horizontal
    }

    func horizontalBuilderForEdge(_ edge: LayoutEdge) -> Horizontal {
        assert(edge.axis == .horizontal)
        return (edge == .leading) ? leading : trailing
    }

    func verticalBuilderForEdge(_ edge: LayoutEdge) -> Vertical {
        assert(edge.axis == .vertical)
        return (edge == .top) ? top : bottom
    }

}

// MARK: - Constraint Activation

private func activateConstraint(_ constraint: NSLayoutConstraint, withPriority priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
    // Only disable autoresizing constraints on the LHS item, which is the one definitely intended to be governed by Auto Layout
    if let first = constraint.firstItem as? UIView {
        first.translatesAutoresizingMaskIntoConstraints = false
    }
    
    constraint.priority = priority
    constraint.isActive = true
    
    return constraint
}

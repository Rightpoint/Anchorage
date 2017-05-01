//
//  Internal.swift
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

    internal typealias View = NSView
    internal typealias ViewController = NSViewController
    internal typealias LayoutGuide = NSLayoutGuide

    internal let LayoutPriorityRequired = NSLayoutPriorityRequired
    internal let LayoutPriorityHigh = NSLayoutPriorityDefaultHigh
    internal let LayoutPriorityLow = NSLayoutPriorityDefaultLow
    internal let LayoutPriorityFittingSize = NSLayoutPriorityFittingSizeCompression
#else
    import UIKit

    internal typealias View = UIView
    internal typealias ViewController = UIViewController
    internal typealias LayoutGuide = UILayoutGuide

    internal let LayoutPriorityRequired = UILayoutPriorityRequired
    internal let LayoutPriorityHigh = UILayoutPriorityDefaultHigh
    internal let LayoutPriorityLow = UILayoutPriorityDefaultLow
    internal let LayoutPriorityFittingSize = UILayoutPriorityFittingSizeLevel
#endif

// MARK: - LayoutExpression

public struct LayoutExpression<T: LayoutAnchorType> {

    public var anchor: T?
    public var constant: CGFloat
    public var multiplier: CGFloat
    public var priority: Priority

    internal init(anchor: T? = nil, constant: CGFloat = 0.0, multiplier: CGFloat = 1.0, priority: Priority = .required) {
        self.anchor = anchor
        self.constant = constant
        self.multiplier = multiplier
        self.priority = priority
    }

}

// MARK: - AnchorPair

public struct AnchorPair<T: LayoutAxisType, U: LayoutAxisType>: LayoutAnchorType {

    public var first: T
    public var second: U

    internal init(first: T, second: U) {
        self.first = first
        self.second = second
    }

}

internal extension AnchorPair {

    func finalize(constraintsEqualToEdges anchor: AnchorPair<T, U>?, constant c: CGFloat = 0.0, priority: Priority = .required) -> AxisGroup {
        let builder = ConstraintBuilder(horizontal: ==, vertical: ==)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    func finalize(constraintsLessThanOrEqualToEdges anchor: AnchorPair<T, U>?, constant c: CGFloat = 0.0, priority: Priority = .required) -> AxisGroup {
        let builder = ConstraintBuilder(leading: <=, top: <=, trailing: >=, bottom: >=, centerX: <=, centerY: <=)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    func finalize(constraintsGreaterThanOrEqualToEdges anchor: AnchorPair<T, U>?, constant c: CGFloat = 0.0, priority: Priority = .required) -> AxisGroup {
        let builder = ConstraintBuilder(leading: >=, top: >=, trailing: <=, bottom: <=, centerX: >=, centerY: >=)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    func constraints(forAnchors anchors: AnchorPair<T, U>?, constant c: CGFloat, priority: Priority, builder: ConstraintBuilder) -> AxisGroup {
        guard let anchors = anchors else {
            preconditionFailure("Encountered nil edge anchors, indicating internal inconsistency of this API.")
        }

        var axisGroup: AxisGroup!

        performInBatch {
            switch (first, anchors.first, second, anchors.second) {
            // Leading, trailing
            case let (firstX as NSLayoutXAxisAnchor, otherFirstX as NSLayoutXAxisAnchor,
                      secondX as NSLayoutXAxisAnchor, otherSecondX as NSLayoutXAxisAnchor):
                axisGroup = AxisGroup(first: builder.leadingBuilder(firstX, otherFirstX + c ~ priority),
                                      second: builder.trailingBuilder(secondX, otherSecondX - c ~ priority))
            //Top, bottom
            case let (firstY as NSLayoutYAxisAnchor, otherFirstY as NSLayoutYAxisAnchor,
                      secondY as NSLayoutYAxisAnchor, otherSecondY as NSLayoutYAxisAnchor):
                axisGroup = AxisGroup(first: builder.topBuilder(firstY, otherFirstY + c ~ priority),
                                      second: builder.bottomBuilder(secondY, otherSecondY - c ~ priority))
            //CenterX, centerY
            case let (firstX as NSLayoutXAxisAnchor, otherFirstX as NSLayoutXAxisAnchor,
                      firstY as NSLayoutYAxisAnchor, otherFirstY as NSLayoutYAxisAnchor):
                axisGroup = AxisGroup(first: builder.centerXBuilder(firstX, otherFirstX + c ~ priority),
                                      second: builder.centerYBuilder(firstY, otherFirstY + c ~ priority))
            default:
                preconditionFailure("Layout axes of constrained anchors must match.")
            }
        }

        return axisGroup
    }

}

// MARK: - EdgeAnchors

internal extension EdgeAnchors {

    init(horizontal: AnchorPair<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor>, vertical: AnchorPair<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor>) {
        self.horizontalAnchors = horizontal
        self.verticalAnchors = vertical
    }

    func finalize(constraintsEqualToEdges anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: Priority = .required) -> EdgeGroup {
        let builder = ConstraintBuilder(horizontal: ==, vertical: ==)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    func finalize(constraintsLessThanOrEqualToEdges anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: Priority = .required) -> EdgeGroup {
        let builder = ConstraintBuilder(leading: <=, top: <=, trailing: >=, bottom: >=, centerX: <=, centerY: <=)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    func finalize(constraintsGreaterThanOrEqualToEdges anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: Priority = .required) -> EdgeGroup {
        let builder = ConstraintBuilder(leading: >=, top: >=, trailing: <=, bottom: <=, centerX: >=, centerY: >=)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    func constraints(forAnchors anchors: EdgeAnchors?, constant c: CGFloat, priority: Priority, builder: ConstraintBuilder) -> EdgeGroup {
        guard let anchors = anchors else {
            preconditionFailure("Encountered nil edge anchors, indicating internal inconsistency of this API.")
        }

        var edgeGroup: EdgeGroup!

        performInBatch {
            let horizontalConstraints = horizontalAnchors.constraints(forAnchors: anchors.horizontalAnchors, constant: c, priority: priority, builder: builder)
            let verticalConstraints = verticalAnchors.constraints(forAnchors: anchors.verticalAnchors, constant: c, priority: priority, builder: builder)
            edgeGroup = EdgeGroup(top: verticalConstraints.first,
                                  leading: horizontalConstraints.first,
                                  bottom: verticalConstraints.second,
                                  trailing: horizontalConstraints.second)
        }

        return edgeGroup
    }

}

// MARK: - ConstraintBuilder

internal struct ConstraintBuilder {

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

// MARK: - Batching

internal var currentBatch: ConstraintBatch?

internal class ConstraintBatch {

    var constraints = [NSLayoutConstraint]()

    func add(constraint: NSLayoutConstraint) {
        constraints.append(constraint)
    }

    func activate() {
        NSLayoutConstraint.activate(constraints)
    }

}

/// Perform a closure immediately if a batch is already active,
/// otherwise executes the closure in a new batch.
///
/// - Parameter closure: The work to perform inside of a batch
internal func performInBatch(closure: () -> Void) {
    if currentBatch == nil {
        batch(active: true, closure: closure)
    }
    else {
        closure()
    }
}

// MARK: - Constraint Activation

internal func finalize(constraint: NSLayoutConstraint, withPriority priority: Priority = .required) -> NSLayoutConstraint {
    // Only disable autoresizing constraints on the LHS item, which is the one definitely intended to be governed by Auto Layout
    if let first = constraint.firstItem as? View {
        first.translatesAutoresizingMaskIntoConstraints = false
    }

    constraint.priority = priority.value

    if let currentBatch = currentBatch {
        currentBatch.add(constraint: constraint)
    }
    else {
        constraint.isActive = true
    }

    return constraint
}

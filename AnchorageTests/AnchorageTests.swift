//
//  AnchorageTests.swift
//  AnchorageTests
//
//  Created by Zev Eisenberg on 4/29/17.
//  Copyright © 2017 Raizlabs. All rights reserved.
//

#if os(macOS)
    import AppKit
#else
    import UIKit
#endif

@testable import Anchorage
import SnapshotTesting
import Then
import XCTest

#if swift(>=4.0)
    public typealias ConstraintAttribute = NSLayoutConstraint.Attribute
#else
    public typealias ConstraintAttribute = NSLayoutAttribute
    func XCTAssertEqual<T>(
        _ expression1: @autoclosure () throws -> T,
        _ expression2: @autoclosure () throws -> T,
        accuracy: T,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) where T : FloatingPoint {
        XCTAssertEqualWithAccuracy(expression1, expression2, accuracy: accuracy, message, file: file, line: line)
    }
#endif

#if os(macOS)
    typealias TestView = NSView
    typealias TestWindow = NSWindow

    #if swift(>=4.0)
        let TestPriorityRequired = NSLayoutConstraint.Priority.required
        let TestPriorityHigh = NSLayoutConstraint.Priority.defaultHigh
        let TestPriorityLow = NSLayoutConstraint.Priority.defaultLow
    #else
        let TestPriorityRequired = NSLayoutPriorityRequired
        let TestPriorityHigh = NSLayoutPriorityDefaultHigh
        let TestPriorityLow = NSLayoutPriorityDefaultLow
    #endif

#else
    typealias TestView = UIView
    typealias TestWindow = UIWindow

    #if swift(>=4.0)
        let TestPriorityRequired = UILayoutPriority.required
        let TestPriorityHigh = UILayoutPriority.defaultHigh
        let TestPriorityLow = UILayoutPriority.defaultLow
    #else
        let TestPriorityRequired = UILayoutPriorityRequired
        let TestPriorityHigh = UILayoutPriorityDefaultHigh
        let TestPriorityLow = UILayoutPriorityDefaultLow
    #endif
#endif

let cgEpsilon: CGFloat = 0.00001
let fEpsilon: Float = 0.00001
let dEpsilon: Double = 0.00001

class AnchorageTests: XCTestCase {

    let view1 = TestView().then {
        $0.backgroundColor = .red
    }
    let view2 = TestView().then {
        $0.backgroundColor = .blue
    }

    let window = TestWindow().then {
        $0.backgroundColor = .yellow
        $0.frame = .init(
            origin: .zero,
            size: .init(
                width: 200,
                height: 200
            )
        )
        $0.isHidden = false
    }

    override func setUp() {
#if os(macOS)
        window.contentView!.addSubview(view1)
        window.contentView!.addSubview(view2)
#else
        window.addSubview(view1)
        window.addSubview(view2)
#endif
    }

    func testBasicEqualitySnapshot() {
        view1.edgeAnchors == window.edgeAnchors
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testBasicEquality() {
        let constraint = view1.widthAnchor == view2.widthAnchor
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqual(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.priority.rawValue, TestPriorityRequired.rawValue, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testBasicLessThanSnapshot() {
        view1.topAnchor == window.topAnchor
        view1.leadingAnchor == window.leadingAnchor
        view1.trailingAnchor == window.trailingAnchor
        view1.bottomAnchor <= window.bottomAnchor
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testBasicLessThan() {
        let constraint = view1.widthAnchor <= view2.widthAnchor
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqual(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.priority.rawValue, TestPriorityRequired.rawValue, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testBasicGreaterThanSnapshot() {
        view1.widthAnchor == 50
        view1.heightAnchor == 50
        view1.edgeAnchors >= window.edgeAnchors
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testBasicGreaterThan() {
        let constraint = view1.widthAnchor >= view2.widthAnchor
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqual(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.priority.rawValue, TestPriorityRequired.rawValue, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testEqualityWithOffsetSnapshot() {
        view2.widthAnchor == 50
        view2.heightAnchor == 50
        view2.centerAnchors == window.centerAnchors
        view1.widthAnchor == view2.widthAnchor + 50
        view1.heightAnchor == view2.heightAnchor + 50
        view1.centerAnchors == window.centerAnchors
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testEqualityWithOffset() {
        let constraint = view1.widthAnchor == view2.widthAnchor + 10
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqual(constraint.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.priority.rawValue, TestPriorityRequired.rawValue, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testEqualityWithMultiplierSnapshot() {
        view2.widthAnchor == 50
        view2.heightAnchor == 50
        view2.centerAnchors == window.centerAnchors
        view1.widthAnchor == view2.widthAnchor * 2
        view1.heightAnchor == view2.heightAnchor * 2
        view1.centerAnchors == window.centerAnchors
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testEqualityWithMultiplier() {
        let constraint = view1.widthAnchor == view2.widthAnchor / 2
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqual(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.multiplier, 0.5, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.priority.rawValue, TestPriorityRequired.rawValue, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testAxisAnchorEqualityWithMultiplierSnapshot() {
        view1.topAnchor == window.topAnchor
        view1.bottomAnchor == window.bottomAnchor
        view1.leadingAnchor == window.leadingAnchor
        view1.trailingAnchor == window.trailingAnchor * 0.5
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testAxisAnchorEqualityWithMultiplier() {
        let constraint = view1.leadingAnchor == view2.trailingAnchor / 2
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqual(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.multiplier, 0.5, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.priority.rawValue, TestPriorityRequired.rawValue, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .trailing)
    }

    func testEqualityWithOffsetAndMultiplier() {
        let constraint = view1.widthAnchor == (view2.widthAnchor + 10) / 2
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqual(constraint.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.multiplier, 0.5, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.priority.rawValue, TestPriorityRequired.rawValue, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testAxisAnchorEqualityWithOffsetAndMultiplierSnapshot() {
        view1.topAnchor == window.topAnchor
        view1.bottomAnchor == window.bottomAnchor
        view1.leadingAnchor == window.leadingAnchor
        view1.trailingAnchor == (window.trailingAnchor + 50) * 0.25
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testAxisAnchorEqualityWithOffsetAndMultiplier() {
        let constraint = view1.trailingAnchor == (view2.centerXAnchor + 10) / 2
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqual(constraint.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.multiplier, 0.5, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.priority.rawValue, TestPriorityRequired.rawValue, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .trailing)
        XCTAssertEqual(constraint.secondAttribute, .centerX)
    }

    func testEqualityWithPriorityConstantSnapshot() {
        view1.topAnchor == window.topAnchor
        view1.leadingAnchor == window.leadingAnchor
        view1.bottomAnchor == window.bottomAnchor
        view1.widthAnchor == window.widthAnchor ~ .high
        view2.topAnchor == window.topAnchor
        view2.trailingAnchor == window.trailingAnchor
        view2.bottomAnchor == window.bottomAnchor
        view2.widthAnchor == window.widthAnchor ~ .low
        view1.trailingAnchor == view2.leadingAnchor
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testEqualityWithPriorityConstant() {
        let constraint = view1.widthAnchor == view2.widthAnchor ~ .high
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqual(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.priority.rawValue, TestPriorityHigh.rawValue, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testEqualityWithPriorityLiteralSnapshot() {
        view1.topAnchor == window.topAnchor
        view1.leadingAnchor == window.leadingAnchor
        view1.bottomAnchor == window.bottomAnchor
        view1.widthAnchor == window.widthAnchor ~ 750
        view2.topAnchor == window.topAnchor
        view2.trailingAnchor == window.trailingAnchor
        view2.bottomAnchor == window.bottomAnchor
        view2.widthAnchor == window.widthAnchor ~ 250
        view1.trailingAnchor == view2.leadingAnchor
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testEqualityWithPriorityLiteral() {
        let constraint = view1.widthAnchor == view2.widthAnchor ~ 750
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqual(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.priority.rawValue, TestPriorityHigh.rawValue, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testEqualityWithPriorityConstantMathSnapshot() {
        view1.topAnchor == window.topAnchor
        view1.leadingAnchor == window.leadingAnchor
        view1.bottomAnchor == window.bottomAnchor
        view1.widthAnchor == window.widthAnchor ~ .high
        view2.topAnchor == window.topAnchor
        view2.trailingAnchor == window.trailingAnchor
        view2.bottomAnchor == window.bottomAnchor
        view2.widthAnchor == window.widthAnchor ~ .high - 1
        view1.trailingAnchor == view2.leadingAnchor
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testEqualityWithPriorityConstantMath() {
        let constraint = view1.widthAnchor == view2.widthAnchor ~ .high - 1
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqual(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testEqualityWithPriorityLiteralMathSnapshot() {
        view1.topAnchor == window.topAnchor
        view1.leadingAnchor == window.leadingAnchor
        view1.bottomAnchor == window.bottomAnchor
        view1.widthAnchor == window.widthAnchor ~ .high
        view2.topAnchor == window.topAnchor
        view2.trailingAnchor == window.trailingAnchor
        view2.bottomAnchor == window.bottomAnchor
        view2.widthAnchor == window.widthAnchor ~ Priority(750 - 1)
        view1.trailingAnchor == view2.leadingAnchor
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testEqualityWithPriorityLiteralMath() {
        let constraint = view1.widthAnchor == view2.widthAnchor ~ Priority(750 - 1)
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqual(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testEqualityWithOffsetAndPriorityMathSnapshot() {
        view1.topAnchor == window.topAnchor
        view1.leadingAnchor == window.leadingAnchor
        view1.bottomAnchor == window.bottomAnchor
        view1.widthAnchor == window.widthAnchor - 100 ~ .high + 1
        view2.topAnchor == window.topAnchor
        view2.trailingAnchor == window.trailingAnchor
        view2.bottomAnchor == window.bottomAnchor
        view2.widthAnchor == window.widthAnchor ~ .high
        view1.trailingAnchor == view2.leadingAnchor
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testEqualityWithOffsetAndPriorityMath() {
        let constraint = view1.widthAnchor == view2.widthAnchor + 10 ~ .high - 1
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqual(constraint.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testEqualityWithOffsetAndMultiplierAndPriorityMathSnapshot() {
        view1.topAnchor == window.topAnchor
        view1.leadingAnchor == window.leadingAnchor
        view1.bottomAnchor == window.bottomAnchor
        view1.widthAnchor == (window.widthAnchor + 50) / 4 ~ .high + 1
        view2.topAnchor == window.topAnchor
        view2.trailingAnchor == window.trailingAnchor
        view2.bottomAnchor == window.bottomAnchor
        view2.widthAnchor == window.widthAnchor ~ .high
        view1.trailingAnchor == view2.leadingAnchor
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testEqualityWithOffsetAndMultiplierAndPriorityMath() {
        let constraint = view1.widthAnchor == (view2.widthAnchor + 10) / 2 ~ .high - 1
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqual(constraint.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.multiplier, 0.5, accuracy: cgEpsilon)
        XCTAssertEqual(constraint.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testCenterAnchorsSnapshot() {
        view2.widthAnchor == 50
        view2.heightAnchor == 50
        view2.centerAnchors == window.centerAnchors
        view1.widthAnchor == view2.widthAnchor * 2
        view1.heightAnchor == view2.heightAnchor * 2
        view1.centerAnchors == view2.centerAnchors
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testCenterAnchors() {
        let constraints = view1.centerAnchors == view2.centerAnchors

        let horizontal = constraints.first
        assertIdentical(horizontal.firstItem, view1)
        assertIdentical(horizontal.secondItem, view2)
        XCTAssertEqual(horizontal.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(horizontal.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(horizontal.priority.rawValue, TestPriorityRequired.rawValue, accuracy: fEpsilon)
        XCTAssertTrue(horizontal.isActive)
        XCTAssertEqual(horizontal.relation, .equal)
        XCTAssertEqual(horizontal.firstAttribute, .centerX)
        XCTAssertEqual(horizontal.secondAttribute, .centerX)

        let vertical = constraints.second
        assertIdentical(vertical.firstItem, view1)
        assertIdentical(vertical.secondItem, view2)
        XCTAssertEqual(vertical.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(vertical.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(vertical.priority.rawValue, TestPriorityRequired.rawValue, accuracy: fEpsilon)
        XCTAssertTrue(vertical.isActive)
        XCTAssertEqual(vertical.relation, .equal)
        XCTAssertEqual(vertical.firstAttribute, .centerY)
        XCTAssertEqual(vertical.secondAttribute, .centerY)
    }

    func testCenterAnchorsWithOffsetSnapshot() {
        view2.widthAnchor == 50
        view2.heightAnchor == 50
        view2.centerAnchors == window.centerAnchors
        view1.widthAnchor == view2.widthAnchor * 2
        view1.heightAnchor == view2.heightAnchor * 2
        view1.centerAnchors == view2.centerAnchors + 25
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testCenterAnchorsWithOffsetAndPrioritySnapshot() {
        view2.widthAnchor == 50
        view2.heightAnchor == 50
        view2.centerAnchors == window.centerAnchors
        view1.widthAnchor == view2.widthAnchor * 2
        view1.heightAnchor == view2.heightAnchor * 2
        view1.bottomAnchor == window.bottomAnchor ~ .low
        view1.centerAnchors == view2.centerAnchors + 25 ~ .low + 1
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testCenterAnchorsWithOffsetAndPriority() {
        let constraints = view1.centerAnchors == view2.centerAnchors + 10 ~ .high - 1

        let horizontal = constraints.first
        assertIdentical(horizontal.firstItem, view1)
        assertIdentical(horizontal.secondItem, view2)
        XCTAssertEqual(horizontal.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqual(horizontal.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(horizontal.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(horizontal.isActive)
        XCTAssertEqual(horizontal.relation, .equal)
        XCTAssertEqual(horizontal.firstAttribute, .centerX)
        XCTAssertEqual(horizontal.secondAttribute, .centerX)

        let vertical = constraints.second
        assertIdentical(vertical.firstItem, view1)
        assertIdentical(vertical.secondItem, view2)
        XCTAssertEqual(vertical.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqual(vertical.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(vertical.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(vertical.isActive)
        XCTAssertEqual(vertical.relation, .equal)
        XCTAssertEqual(vertical.firstAttribute, .centerY)
        XCTAssertEqual(vertical.secondAttribute, .centerY)
    }

    func testHorizontalAnchorsSnapshot() {
        view1.heightAnchor == 50
        view1.horizontalAnchors == window.horizontalAnchors
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testHorizontalAnchors() {
        let constraints = view1.horizontalAnchors == view2.horizontalAnchors + 10 ~ .high - 1

        let leading = constraints.first
        assertIdentical(leading.firstItem, view1)
        assertIdentical(leading.secondItem, view2)
        XCTAssertEqual(leading.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqual(leading.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(leading.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(leading.isActive)
        XCTAssertEqual(leading.relation, .equal)
        XCTAssertEqual(leading.firstAttribute, .leading)
        XCTAssertEqual(leading.secondAttribute, .leading)

        let trailing = constraints.second
        assertIdentical(trailing.firstItem, view1)
        assertIdentical(trailing.secondItem, view2)
        XCTAssertEqual(trailing.constant, -10, accuracy: cgEpsilon)
        XCTAssertEqual(trailing.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(trailing.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(trailing.isActive)
        XCTAssertEqual(trailing.relation, .equal)
        XCTAssertEqual(trailing.firstAttribute, .trailing)
        XCTAssertEqual(trailing.secondAttribute, .trailing)
    }

    func testVerticalAnchorsSnapshot() {
        view1.widthAnchor == 50
        view1.verticalAnchors == window.verticalAnchors
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testVerticalAnchors() {
        let constraints = view1.verticalAnchors == view2.verticalAnchors + 10 ~ .high - 1

        let top = constraints.first
        assertIdentical(top.firstItem, view1)
        assertIdentical(top.secondItem, view2)
        XCTAssertEqual(top.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqual(top.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(top.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(top.isActive)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.secondAttribute, .top)

        let bottom = constraints.second
        assertIdentical(bottom.firstItem, view1)
        assertIdentical(bottom.secondItem, view2)
        XCTAssertEqual(bottom.constant, -10, accuracy: cgEpsilon)
        XCTAssertEqual(bottom.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(bottom.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(bottom.isActive)
        XCTAssertEqual(bottom.relation, .equal)
        XCTAssertEqual(bottom.firstAttribute, .bottom)
        XCTAssertEqual(bottom.secondAttribute, .bottom)
    }

    func testSizeAnchorsSnapshot() {
        view1.sizeAnchors == window.sizeAnchors
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testSizeAnchors() {
        let constraints = view1.sizeAnchors == view2.sizeAnchors + 10 ~ .high - 1

        let width = constraints.first
        assertIdentical(width.firstItem, view1)
        assertIdentical(width.secondItem, view2)
        XCTAssertEqual(width.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqual(width.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(width.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(width.isActive)
        XCTAssertEqual(width.relation, .equal)
        XCTAssertEqual(width.firstAttribute, .width)
        XCTAssertEqual(width.secondAttribute, .width)

        let height = constraints.second
        assertIdentical(height.firstItem, view1)
        assertIdentical(height.secondItem, view2)
        XCTAssertEqual(height.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqual(height.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(height.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(height.isActive)
        XCTAssertEqual(height.relation, .equal)
        XCTAssertEqual(height.firstAttribute, .height)
        XCTAssertEqual(height.secondAttribute, .height)
    }

    func testSizeAnchorsWithConstantsSnapshot() {
        view1.sizeAnchors == CGSize(width: 100, height: 100)
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testSizeAnchorsWithConstants() {
        let constraints = view1.sizeAnchors == CGSize(width: 50, height: 100) ~ .high - 1

        let width = constraints.first
        assertIdentical(width.firstItem, view1)
        assertIdentical(width.secondItem, nil)
        XCTAssertEqual(width.constant, 50, accuracy: cgEpsilon)
        XCTAssertEqual(width.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(width.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(width.isActive)
        XCTAssertEqual(width.relation, .equal)
        XCTAssertEqual(width.firstAttribute, .width)
        XCTAssertEqual(width.secondAttribute, .notAnAttribute)

        let height = constraints.second
        assertIdentical(height.firstItem, view1)
        assertIdentical(height.secondItem, nil)
        XCTAssertEqual(height.constant, 100, accuracy: cgEpsilon)
        XCTAssertEqual(height.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(height.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(height.isActive)
        XCTAssertEqual(height.relation, .equal)
        XCTAssertEqual(height.firstAttribute, .height)
        XCTAssertEqual(height.secondAttribute, .notAnAttribute)
    }

    func testEdgeAnchorsSnapshot() {
        view1.edgeAnchors == window.edgeAnchors
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testEdgeAnchors() {
        let constraints = view1.edgeAnchors == view2.edgeAnchors + 10 ~ .high - 1

        let all = constraints.all
        XCTAssertEqual(all.count, 4)
        XCTAssertEqual(all[0].firstAttribute, .top)
        XCTAssertEqual(all[1].firstAttribute, .leading)
        XCTAssertEqual(all[2].firstAttribute, .bottom)
        XCTAssertEqual(all[3].firstAttribute, .trailing)

        let vertical = constraints.vertical
        XCTAssertEqual(vertical.count, 2)
        XCTAssertEqual(vertical[0].firstAttribute, .top)
        XCTAssertEqual(vertical[1].firstAttribute, .bottom)

        let horizontal = constraints.horizontal
        XCTAssertEqual(horizontal.count, 2)
        XCTAssertEqual(horizontal[0].firstAttribute, .leading)
        XCTAssertEqual(horizontal[1].firstAttribute, .trailing)

        let leading = constraints.leading
        assertIdentical(leading.firstItem, view1)
        assertIdentical(leading.secondItem, view2)
        XCTAssertEqual(leading.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqual(leading.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(leading.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(leading.isActive)
        XCTAssertEqual(leading.relation, .equal)
        XCTAssertEqual(leading.firstAttribute, .leading)
        XCTAssertEqual(leading.secondAttribute, .leading)

        let trailing = constraints.trailing
        assertIdentical(trailing.firstItem, view1)
        assertIdentical(trailing.secondItem, view2)
        XCTAssertEqual(trailing.constant, -10, accuracy: cgEpsilon)
        XCTAssertEqual(trailing.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(trailing.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(trailing.isActive)
        XCTAssertEqual(trailing.relation, .equal)
        XCTAssertEqual(trailing.firstAttribute, .trailing)
        XCTAssertEqual(trailing.secondAttribute, .trailing)

        let top = constraints.top
        assertIdentical(top.firstItem, view1)
        assertIdentical(top.secondItem, view2)
        XCTAssertEqual(top.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqual(top.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(top.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(top.isActive)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.secondAttribute, .top)

        let bottom = constraints.bottom
        assertIdentical(bottom.firstItem, view1)
        assertIdentical(bottom.secondItem, view2)
        XCTAssertEqual(bottom.constant, -10, accuracy: cgEpsilon)
        XCTAssertEqual(bottom.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(bottom.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(bottom.isActive)
        XCTAssertEqual(bottom.relation, .equal)
        XCTAssertEqual(bottom.firstAttribute, .bottom)
        XCTAssertEqual(bottom.secondAttribute, .bottom)
    }

    func testEdgeAnchorsWithInsetsSnapshot() {
        view1.edgeAnchors == window.edgeAnchors + 50
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testEdgeAnchorsWithInsets() {
        let insets = EdgeInsets(top: 10, left: 5, bottom: 15, right: 20)

        let constraints = view1.edgeAnchors == view2.edgeAnchors + insets ~ .high - 1

        let leading = constraints.leading
        assertIdentical(leading.firstItem, view1)
        assertIdentical(leading.secondItem, view2)
        XCTAssertEqual(leading.constant, 5, accuracy: cgEpsilon)
        XCTAssertEqual(leading.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(leading.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(leading.isActive)
        XCTAssertEqual(leading.relation, .equal)
        XCTAssertEqual(leading.firstAttribute, .leading)
        XCTAssertEqual(leading.secondAttribute, .leading)

        let trailing = constraints.trailing
        assertIdentical(trailing.firstItem, view1)
        assertIdentical(trailing.secondItem, view2)
        XCTAssertEqual(trailing.constant, -20, accuracy: cgEpsilon)
        XCTAssertEqual(trailing.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(trailing.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(trailing.isActive)
        XCTAssertEqual(trailing.relation, .equal)
        XCTAssertEqual(trailing.firstAttribute, .trailing)
        XCTAssertEqual(trailing.secondAttribute, .trailing)

        let top = constraints.top
        assertIdentical(top.firstItem, view1)
        assertIdentical(top.secondItem, view2)
        XCTAssertEqual(top.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqual(top.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(top.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(top.isActive)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.secondAttribute, .top)

        let bottom = constraints.bottom
        assertIdentical(bottom.firstItem, view1)
        assertIdentical(bottom.secondItem, view2)
        XCTAssertEqual(bottom.constant, -15, accuracy: cgEpsilon)
        XCTAssertEqual(bottom.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(bottom.priority.rawValue, TestPriorityHigh.rawValue - 1, accuracy: fEpsilon)
        XCTAssertTrue(bottom.isActive)
        XCTAssertEqual(bottom.relation, .equal)
        XCTAssertEqual(bottom.firstAttribute, .bottom)
        XCTAssertEqual(bottom.secondAttribute, .bottom)
    }

    func testInactiveBatchConstraintsSnapshot() {
        view1.sizeAnchors == window.sizeAnchors - 100
        _ = Anchorage.batch(active: false) {
            view2.sizeAnchors == window.sizeAnchors
        }
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testInactiveBatchConstraints() {
        let constraints = Anchorage.batch(active: false) {
            view1.widthAnchor == view2.widthAnchor
            view1.heightAnchor == view2.heightAnchor / 2 ~ .low
        }

        let width = constraints[0]
        let height = constraints[1]

        assertIdentical(width.firstItem, view1)
        assertIdentical(width.secondItem, view2)
        XCTAssertEqual(width.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(width.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(width.priority.rawValue, TestPriorityRequired.rawValue, accuracy: fEpsilon)
        XCTAssertFalse(width.isActive)
        XCTAssertEqual(width.relation, .equal)
        XCTAssertEqual(width.firstAttribute, .width)
        XCTAssertEqual(width.secondAttribute, .width)

        assertIdentical(height.firstItem, view1)
        assertIdentical(height.secondItem, view2)
        XCTAssertEqual(height.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(height.multiplier, 0.5, accuracy: cgEpsilon)
        XCTAssertEqual(height.priority.rawValue, TestPriorityLow.rawValue, accuracy: fEpsilon)
        XCTAssertFalse(height.isActive)
        XCTAssertEqual(height.relation, .equal)
        XCTAssertEqual(height.firstAttribute, .height)
        XCTAssertEqual(height.secondAttribute, .height)
    }

    func testActiveBatchConstraintsSnapshot() {
        _ = Anchorage.batch(active: true) {
            view1.sizeAnchors == window.sizeAnchors - 100
        }
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testActiveBatchConstraints() {
        let constraints = Anchorage.batch {
            view1.widthAnchor == view2.widthAnchor
            view1.heightAnchor == view2.heightAnchor / 2 ~ .low
        }

        let width = constraints[0]
        let height = constraints[1]

        assertIdentical(width.firstItem, view1)
        assertIdentical(width.secondItem, view2)
        XCTAssertEqual(width.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(width.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(width.priority.rawValue, TestPriorityRequired.rawValue, accuracy: fEpsilon)
        XCTAssertTrue(width.isActive)
        XCTAssertEqual(width.relation, .equal)
        XCTAssertEqual(width.firstAttribute, .width)
        XCTAssertEqual(width.secondAttribute, .width)

        assertIdentical(height.firstItem, view1)
        assertIdentical(height.secondItem, view2)
        XCTAssertEqual(height.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(height.multiplier, 0.5, accuracy: cgEpsilon)
        XCTAssertEqual(height.priority.rawValue, TestPriorityLow.rawValue, accuracy: fEpsilon)
        XCTAssertTrue(height.isActive)
        XCTAssertEqual(height.relation, .equal)
        XCTAssertEqual(height.firstAttribute, .height)
        XCTAssertEqual(height.secondAttribute, .height)
    }

    func testNestedBatchConstraintsSnapshots() {
        _ = Anchorage.batch(active: true) {
            view1.sizeAnchors == window.sizeAnchors - 100
            view1.centerAnchors == window.centerAnchors
            _ = Anchorage.batch(active: true) {
                view2.sizeAnchors == window.sizeAnchors - 150
                view2.centerAnchors == window.centerAnchors
            }
        }
        assertSnapshot(
            matching: window,
            as: .image,
            record: false
        )
    }

    func testNestedBatchConstraints() {
        var nestedConstraints: [NSLayoutConstraint] = []
        let constraints = Anchorage.batch {
            view1.widthAnchor == view2.widthAnchor
            nestedConstraints = Anchorage.batch(active: false) {
                view1.heightAnchor == view2.heightAnchor / 2 ~ .low
            }
            view1.leadingAnchor == view2.leadingAnchor
        }

        let width = constraints[0]
        let leading = constraints[1]
        let height = nestedConstraints[0]

        assertIdentical(width.firstItem, view1)
        assertIdentical(width.secondItem, view2)
        XCTAssertEqual(width.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(width.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(width.priority.rawValue, TestPriorityRequired.rawValue, accuracy: fEpsilon)
        XCTAssertTrue(width.isActive)
        XCTAssertEqual(width.relation, .equal)
        XCTAssertEqual(width.firstAttribute, .width)
        XCTAssertEqual(width.secondAttribute, .width)

        assertIdentical(height.firstItem, view1)
        assertIdentical(height.secondItem, view2)
        XCTAssertEqual(height.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(height.multiplier, 0.5, accuracy: cgEpsilon)
        XCTAssertEqual(height.priority.rawValue, TestPriorityLow.rawValue, accuracy: fEpsilon)
        XCTAssertFalse(height.isActive)
        XCTAssertEqual(height.relation, .equal)
        XCTAssertEqual(height.firstAttribute, .height)
        XCTAssertEqual(height.secondAttribute, .height)

        assertIdentical(leading.firstItem, view1)
        assertIdentical(leading.secondItem, view2)
        XCTAssertEqual(leading.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqual(leading.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqual(leading.priority.rawValue, TestPriorityRequired.rawValue, accuracy: fEpsilon)
        XCTAssertTrue(leading.isActive)
        XCTAssertEqual(leading.relation, .equal)
        XCTAssertEqual(leading.firstAttribute, .leading)
        XCTAssertEqual(leading.secondAttribute, .leading)
    }

}

extension AnchorageTests {

    func assertIdentical(_ expression1: @autoclosure () -> AnyObject?, _ expression2: @autoclosure () -> AnyObject?, _ message: @autoclosure () -> String = "Objects were not identical", file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(expression1() === expression2(), message, file: file, line: line)
    }

}

extension ConstraintAttribute: CustomDebugStringConvertible {

    public var debugDescription: String {
#if os(macOS)
        switch self {
        case .left: return "left"
        case .right: return "right"
        case .top: return "top"
        case .bottom: return "bottom"
        case .leading: return "leading"
        case .trailing: return "trailing"
        case .width: return "width"
        case .height: return "height"
        case .centerX: return "centerX"
        case .centerY: return "centerY"
        case .lastBaseline: return "lastBaseline"
        case .firstBaseline: return "firstBaseline"
        case .notAnAttribute: return "notAnAttribute"
        }
#else
        switch self {
        case .left: return "left"
        case .right: return "right"
        case .top: return "top"
        case .bottom: return "bottom"
        case .leading: return "leading"
        case .trailing: return "trailing"
        case .width: return "width"
        case .height: return "height"
        case .centerX: return "centerX"
        case .centerY: return "centerY"
        case .lastBaseline: return "lastBaseline"
        case .firstBaseline: return "firstBaseline"
        case .leftMargin: return "leftMargin"
        case .rightMargin: return "rightMargin"
        case .topMargin: return "topMargin"
        case .bottomMargin: return "bottomMargin"
        case .leadingMargin: return "leadingMargin"
        case .trailingMargin: return "trailingMargin"
        case .centerXWithinMargins: return "centerXWithinMargins"
        case .centerYWithinMargins: return "centerYWithinMargins"
        case .notAnAttribute: return "notAnAttribute"
        }
#endif
    }

}

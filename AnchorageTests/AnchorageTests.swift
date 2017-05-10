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
import XCTest

#if os(macOS)
    typealias TestView = NSView
    typealias TestViewController = NSViewController
    typealias TestLayoutGuide = NSLayoutGuide
    typealias TestWindow = NSWindow
    let TestPriorityRequired = NSLayoutPriorityRequired
    let TestPriorityHigh = NSLayoutPriorityDefaultHigh
    let TestPriorityLow = NSLayoutPriorityDefaultLow
#else
    typealias TestView = UIView
    typealias TestViewController = UIViewController
    typealias TestLayoutGuide = UILayoutGuide
    typealias TestWindow = UIWindow
    let TestPriorityRequired = UILayoutPriorityRequired
    let TestPriorityHigh = UILayoutPriorityDefaultHigh
    let TestPriorityLow = UILayoutPriorityDefaultLow
#endif

let cgEpsilon: CGFloat = 0.00001
let fEpsilon: Float = 0.00001
let dEpsilon: Double = 0.00001
let f80Epsilon: Float80 = 0.00001

class AnchorageTests: XCTestCase {

    let view1 = TestView()
    let view2 = TestView()

    let controller1 = TestViewController()
    let controller2 = TestViewController()

    let guide1 = TestLayoutGuide()
    let guide2 = TestLayoutGuide()

    let window = TestWindow()

    override func setUp() {
        #if os(macOS)
            view1.addLayoutGuide(guide1)
            window.contentView!.addSubview(view1)
            view2.addLayoutGuide(guide2)
            window.contentView!.addSubview(view2)

            controller1.view = TestView()
            window.contentView!.addSubview(controller1.view)
            controller2.view = TestView()
            window.contentView!.addSubview(controller2.view)
        #else
            view1.addLayoutGuide(guide1)
            window.addSubview(view1)
            view2.addLayoutGuide(guide2)
            window.addSubview(view2)
            window.addSubview(controller1.view)
            window.addSubview(controller2.view)
        #endif
    }

    func testBasicDimensionEquality() {
        let constraint = view1.widthAnchor == view2.widthAnchor
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testBasicConstantEquality() {
        let constraint = view1.widthAnchor == 50
        assertIdentical(constraint.firstItem, view1)
        XCTAssertNil(constraint.secondItem)
        XCTAssertEqualWithAccuracy(constraint.constant, 50, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
    }

    func testBasicXAxisEquality() {
        let constraint = view1.leadingAnchor == view2.leadingAnchor
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .leading)
    }

    func testBasicYAxisEquality() {
        let constraint = view1.topAnchor == view2.topAnchor
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .top)
        XCTAssertEqual(constraint.secondAttribute, .top)
    }

    func testBasicLessThan() {
        let constraint = view1.widthAnchor <= view2.widthAnchor
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testBasicGreaterThan() {
        let constraint = view1.widthAnchor >= view2.widthAnchor
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testEqualityWithOffset() {
        let constraint = view1.leadingAnchor == view2.leadingAnchor + 10
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .leading)
    }

    func testLessThanWithOffset() {
        let constraint = view1.widthAnchor <= view2.widthAnchor + 10
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testGreaterThanWithOffset() {
        let constraint = view1.widthAnchor >= view2.widthAnchor + 10
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testEqualityWithMultiplier() {
        let constraint = view1.widthAnchor == view2.widthAnchor / 2
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 0.5, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testLessThanWithMultiplier() {
        let constraint = view1.widthAnchor <= view2.widthAnchor / 2
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 0.5, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testGreaterThanWithMultiplier() {
        let constraint = view1.widthAnchor >= view2.widthAnchor / 2
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 0.5, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testEqualityWithOffsetAndMultiplier() {
        let constraint = view1.widthAnchor == (view2.widthAnchor + 10) / 2
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 0.5, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testLessThanWithOffsetAndMultiplier() {
        let constraint = view1.widthAnchor <= (view2.widthAnchor + 10) / 2
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 0.5, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testGreaterThanWithOffsetAndMultiplier() {
        let constraint = view1.widthAnchor >= (view2.widthAnchor + 10) / 2
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 0.5, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testEqualityWithPriorityConstant() {
        let constraint = view1.widthAnchor == view2.widthAnchor ~ .high
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityHigh, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testEqualityWithPriorityLiteral() {
        let constraint = view1.widthAnchor == view2.widthAnchor ~ 750
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityHigh, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testEqualityWithPriorityConstantMath() {
        let constraint = view1.widthAnchor == view2.widthAnchor ~ .high - 1
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testEqualityWithPriorityLiteralMath() {
        let constraint = view1.widthAnchor == view2.widthAnchor ~ Priority(750 - 1)
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testEqualityWithOffsetAndPriorityMath() {
        let constraint = view1.widthAnchor == view2.widthAnchor + 10 ~ .high - 1
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testEqualityWithOffsetAndMultiplierAndPriorityMath() {
        let constraint = view1.widthAnchor == (view2.widthAnchor + 10) / 2 ~ .high - 1
        assertIdentical(constraint.firstItem, view1)
        assertIdentical(constraint.secondItem, view2)
        XCTAssertEqualWithAccuracy(constraint.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.multiplier, 0.5, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(constraint.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
    }

    func testViewCenterAnchors() {
        let constraints = view1.centerAnchors == view2.centerAnchors

        let horizontal = constraints.first
        assertIdentical(horizontal.firstItem, view1)
        assertIdentical(horizontal.secondItem, view2)
        XCTAssertEqualWithAccuracy(horizontal.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(horizontal.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(horizontal.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(horizontal.isActive)
        XCTAssertEqual(horizontal.relation, .equal)
        XCTAssertEqual(horizontal.firstAttribute, .centerX)
        XCTAssertEqual(horizontal.secondAttribute, .centerX)

        let vertical = constraints.second
        assertIdentical(vertical.firstItem, view1)
        assertIdentical(vertical.secondItem, view2)
        XCTAssertEqualWithAccuracy(vertical.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(vertical.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(vertical.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(vertical.isActive)
        XCTAssertEqual(vertical.relation, .equal)
        XCTAssertEqual(vertical.firstAttribute, .centerY)
        XCTAssertEqual(vertical.secondAttribute, .centerY)
    }

    func testControllerCenterAnchors() {
        let constraints = controller1.centerAnchors == controller2.centerAnchors

        let horizontal = constraints.first
        assertIdentical(horizontal.firstItem, controller1.view)
        assertIdentical(horizontal.secondItem, controller2.view)
        XCTAssertEqualWithAccuracy(horizontal.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(horizontal.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(horizontal.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(horizontal.isActive)
        XCTAssertEqual(horizontal.relation, .equal)
        XCTAssertEqual(horizontal.firstAttribute, .centerX)
        XCTAssertEqual(horizontal.secondAttribute, .centerX)

        let vertical = constraints.second
        assertIdentical(vertical.firstItem, controller1.view)
        assertIdentical(vertical.secondItem, controller2.view)
        XCTAssertEqualWithAccuracy(vertical.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(vertical.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(vertical.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(vertical.isActive)
        XCTAssertEqual(vertical.relation, .equal)
        XCTAssertEqual(vertical.firstAttribute, .centerY)
        XCTAssertEqual(vertical.secondAttribute, .centerY)
    }

    func testLayoutGuideCenterAnchors() {
        let constraints = guide1.centerAnchors == guide2.centerAnchors

        let horizontal = constraints.first
        assertIdentical(horizontal.firstItem, guide1)
        assertIdentical(horizontal.secondItem, guide2)
        XCTAssertEqualWithAccuracy(horizontal.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(horizontal.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(horizontal.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(horizontal.isActive)
        XCTAssertEqual(horizontal.relation, .equal)
        XCTAssertEqual(horizontal.firstAttribute, .centerX)
        XCTAssertEqual(horizontal.secondAttribute, .centerX)

        let vertical = constraints.second
        assertIdentical(vertical.firstItem, guide1)
        assertIdentical(vertical.secondItem, guide2)
        XCTAssertEqualWithAccuracy(vertical.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(vertical.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(vertical.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(vertical.isActive)
        XCTAssertEqual(vertical.relation, .equal)
        XCTAssertEqual(vertical.firstAttribute, .centerY)
        XCTAssertEqual(vertical.secondAttribute, .centerY)
    }

    func testCenterAnchorsWithOffsetAndPriority() {
        let constraints = view1.centerAnchors == view2.centerAnchors + 10 ~ .high - 1

        let horizontal = constraints.first
        assertIdentical(horizontal.firstItem, view1)
        assertIdentical(horizontal.secondItem, view2)
        XCTAssertEqualWithAccuracy(horizontal.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(horizontal.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(horizontal.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(horizontal.isActive)
        XCTAssertEqual(horizontal.relation, .equal)
        XCTAssertEqual(horizontal.firstAttribute, .centerX)
        XCTAssertEqual(horizontal.secondAttribute, .centerX)

        let vertical = constraints.second
        assertIdentical(vertical.firstItem, view1)
        assertIdentical(vertical.secondItem, view2)
        XCTAssertEqualWithAccuracy(vertical.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(vertical.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(vertical.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(vertical.isActive)
        XCTAssertEqual(vertical.relation, .equal)
        XCTAssertEqual(vertical.firstAttribute, .centerY)
        XCTAssertEqual(vertical.secondAttribute, .centerY)
    }

    func testViewHorizontalAnchors() {
        let constraints = view1.horizontalAnchors == view2.horizontalAnchors

        let leading = constraints.first
        assertIdentical(leading.firstItem, view1)
        assertIdentical(leading.secondItem, view2)
        XCTAssertEqualWithAccuracy(leading.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(leading.isActive)
        XCTAssertEqual(leading.relation, .equal)
        XCTAssertEqual(leading.firstAttribute, .leading)
        XCTAssertEqual(leading.secondAttribute, .leading)

        let trailing = constraints.second
        assertIdentical(trailing.firstItem, view1)
        assertIdentical(trailing.secondItem, view2)
        XCTAssertEqualWithAccuracy(trailing.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(trailing.isActive)
        XCTAssertEqual(trailing.relation, .equal)
        XCTAssertEqual(trailing.firstAttribute, .trailing)
        XCTAssertEqual(trailing.secondAttribute, .trailing)
    }

    func testControllerHorizontalAnchors() {
        let constraints = controller1.horizontalAnchors == controller2.horizontalAnchors

        let leading = constraints.first
        assertIdentical(leading.firstItem, controller1.view)
        assertIdentical(leading.secondItem, controller2.view)
        XCTAssertEqualWithAccuracy(leading.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(leading.isActive)
        XCTAssertEqual(leading.relation, .equal)
        XCTAssertEqual(leading.firstAttribute, .leading)
        XCTAssertEqual(leading.secondAttribute, .leading)

        let trailing = constraints.second
        assertIdentical(trailing.firstItem, controller1.view)
        assertIdentical(trailing.secondItem, controller2.view)
        XCTAssertEqualWithAccuracy(trailing.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(trailing.isActive)
        XCTAssertEqual(trailing.relation, .equal)
        XCTAssertEqual(trailing.firstAttribute, .trailing)
        XCTAssertEqual(trailing.secondAttribute, .trailing)
    }

    func testLayoutGuideHorizontalAnchors() {
        let constraints = guide1.horizontalAnchors == guide2.horizontalAnchors

        let leading = constraints.first
        assertIdentical(leading.firstItem, guide1)
        assertIdentical(leading.secondItem, guide2)
        XCTAssertEqualWithAccuracy(leading.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(leading.isActive)
        XCTAssertEqual(leading.relation, .equal)
        XCTAssertEqual(leading.firstAttribute, .leading)
        XCTAssertEqual(leading.secondAttribute, .leading)

        let trailing = constraints.second
        assertIdentical(trailing.firstItem, guide1)
        assertIdentical(trailing.secondItem, guide2)
        XCTAssertEqualWithAccuracy(trailing.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(trailing.isActive)
        XCTAssertEqual(trailing.relation, .equal)
        XCTAssertEqual(trailing.firstAttribute, .trailing)
        XCTAssertEqual(trailing.secondAttribute, .trailing)
    }

    func testHorizontalAnchorsWithOffsetAndPriority() {
        let constraints = view1.horizontalAnchors == view2.horizontalAnchors + 10 ~ .high - 1

        let leading = constraints.first
        assertIdentical(leading.firstItem, view1)
        assertIdentical(leading.secondItem, view2)
        XCTAssertEqualWithAccuracy(leading.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(leading.isActive)
        XCTAssertEqual(leading.relation, .equal)
        XCTAssertEqual(leading.firstAttribute, .leading)
        XCTAssertEqual(leading.secondAttribute, .leading)

        let trailing = constraints.second
        assertIdentical(trailing.firstItem, view1)
        assertIdentical(trailing.secondItem, view2)
        XCTAssertEqualWithAccuracy(trailing.constant, -10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(trailing.isActive)
        XCTAssertEqual(trailing.relation, .equal)
        XCTAssertEqual(trailing.firstAttribute, .trailing)
        XCTAssertEqual(trailing.secondAttribute, .trailing)
    }

    func testViewVerticalAnchors() {
        let constraints = view1.verticalAnchors == view2.verticalAnchors

        let top = constraints.first
        assertIdentical(top.firstItem, view1)
        assertIdentical(top.secondItem, view2)
        XCTAssertEqualWithAccuracy(top.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(top.isActive)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.secondAttribute, .top)

        let bottom = constraints.second
        assertIdentical(bottom.firstItem, view1)
        assertIdentical(bottom.secondItem, view2)
        XCTAssertEqualWithAccuracy(bottom.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(bottom.isActive)
        XCTAssertEqual(bottom.relation, .equal)
        XCTAssertEqual(bottom.firstAttribute, .bottom)
        XCTAssertEqual(bottom.secondAttribute, .bottom)
    }

    func testControllerVerticalAnchors() {
        let constraints = controller1.verticalAnchors == controller2.verticalAnchors

        let top = constraints.first
        #if os(macOS)
            assertIdentical(top.firstItem, controller1.view)
            assertIdentical(top.secondItem, controller2.view)
            XCTAssertEqual(top.firstAttribute, .top)
            XCTAssertEqual(top.secondAttribute, .top)
        #else
            assertIdentical(top.firstItem, controller1.topLayoutGuide)
            assertIdentical(top.secondItem, controller2.topLayoutGuide)
            XCTAssertEqual(top.firstAttribute, .bottom)
            XCTAssertEqual(top.secondAttribute, .bottom)
        #endif
        XCTAssertEqualWithAccuracy(top.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(top.isActive)
        XCTAssertEqual(top.relation, .equal)

        let bottom = constraints.second
        #if os(macOS)
            assertIdentical(bottom.firstItem, controller1.view)
            assertIdentical(bottom.secondItem, controller2.view)
            XCTAssertEqual(bottom.firstAttribute, .bottom)
            XCTAssertEqual(bottom.secondAttribute, .bottom)
        #else
            assertIdentical(bottom.firstItem, controller1.bottomLayoutGuide)
            assertIdentical(bottom.secondItem, controller2.bottomLayoutGuide)
            XCTAssertEqual(bottom.firstAttribute, .top)
            XCTAssertEqual(bottom.secondAttribute, .top)
        #endif
        XCTAssertEqualWithAccuracy(bottom.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(bottom.isActive)
        XCTAssertEqual(bottom.relation, .equal)
    }

    func testLayoutGuideVerticalAnchors() {
        let constraints = guide1.verticalAnchors == guide2.verticalAnchors

        let top = constraints.first
        assertIdentical(top.firstItem, guide1)
        assertIdentical(top.secondItem, guide2)
        XCTAssertEqualWithAccuracy(top.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(top.isActive)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.secondAttribute, .top)

        let bottom = constraints.second
        assertIdentical(bottom.firstItem, guide1)
        assertIdentical(bottom.secondItem, guide2)
        XCTAssertEqualWithAccuracy(bottom.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(bottom.isActive)
        XCTAssertEqual(bottom.relation, .equal)
        XCTAssertEqual(bottom.firstAttribute, .bottom)
        XCTAssertEqual(bottom.secondAttribute, .bottom)
    }

    func testVerticalAnchorsWithOffsetAndPriority() {
        let constraints = view1.verticalAnchors == view2.verticalAnchors + 10 ~ .high - 1

        let top = constraints.first
        assertIdentical(top.firstItem, view1)
        assertIdentical(top.secondItem, view2)
        XCTAssertEqualWithAccuracy(top.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(top.isActive)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.secondAttribute, .top)

        let bottom = constraints.second
        assertIdentical(bottom.firstItem, view1)
        assertIdentical(bottom.secondItem, view2)
        XCTAssertEqualWithAccuracy(bottom.constant, -10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(bottom.isActive)
        XCTAssertEqual(bottom.relation, .equal)
        XCTAssertEqual(bottom.firstAttribute, .bottom)
        XCTAssertEqual(bottom.secondAttribute, .bottom)
    }

    func testViewSizeAnchors() {
        let constraints = view1.sizeAnchors == CGSize(width: 50, height: 100)

        let width = constraints.first
        assertIdentical(width.firstItem, view1)
        assertIdentical(width.secondItem, nil)
        XCTAssertEqualWithAccuracy(width.constant, 50, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(width.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(width.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(width.isActive)
        XCTAssertEqual(width.relation, .equal)
        XCTAssertEqual(width.firstAttribute, .width)
        XCTAssertEqual(width.secondAttribute, .notAnAttribute)

        let height = constraints.second
        assertIdentical(height.firstItem, view1)
        assertIdentical(height.secondItem, nil)
        XCTAssertEqualWithAccuracy(height.constant, 100, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(height.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(height.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(height.isActive)
        XCTAssertEqual(height.relation, .equal)
        XCTAssertEqual(height.firstAttribute, .height)
        XCTAssertEqual(height.secondAttribute, .notAnAttribute)
    }

    func testControllerSizeAnchors() {
        let constraints = controller1.sizeAnchors == controller2.sizeAnchors

        let width = constraints.first
        assertIdentical(width.firstItem, controller1.view)
        assertIdentical(width.secondItem, controller2.view)
        XCTAssertEqualWithAccuracy(width.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(width.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(width.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(width.isActive)
        XCTAssertEqual(width.relation, .equal)
        XCTAssertEqual(width.firstAttribute, .width)
        XCTAssertEqual(width.secondAttribute, .width)

        let height = constraints.second
        assertIdentical(height.firstItem, controller1.view)
        assertIdentical(height.secondItem, controller2.view)
        XCTAssertEqualWithAccuracy(height.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(height.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(height.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(height.isActive)
        XCTAssertEqual(height.relation, .equal)
        XCTAssertEqual(height.firstAttribute, .height)
        XCTAssertEqual(height.secondAttribute, .height)
    }

    func testLayoutGuideSizeAnchors() {
        let constraints = guide1.sizeAnchors == CGSize(width: 50, height: 100)

        let width = constraints.first
        assertIdentical(width.firstItem, guide1)
        assertIdentical(width.secondItem, nil)
        XCTAssertEqualWithAccuracy(width.constant, 50, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(width.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(width.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(width.isActive)
        XCTAssertEqual(width.relation, .equal)
        XCTAssertEqual(width.firstAttribute, .width)
        XCTAssertEqual(width.secondAttribute, .notAnAttribute)

        let height = constraints.second
        assertIdentical(height.firstItem, guide1)
        assertIdentical(height.secondItem, nil)
        XCTAssertEqualWithAccuracy(height.constant, 100, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(height.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(height.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(height.isActive)
        XCTAssertEqual(height.relation, .equal)
        XCTAssertEqual(height.firstAttribute, .height)
        XCTAssertEqual(height.secondAttribute, .notAnAttribute)
    }

    func testSizeAnchorsWithOffsetAndPriority() {
        let constraints = view1.sizeAnchors == view2.sizeAnchors + 10 ~ .high - 1

        let width = constraints.first
        assertIdentical(width.firstItem, view1)
        assertIdentical(width.secondItem, view2)
        XCTAssertEqualWithAccuracy(width.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(width.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(width.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(width.isActive)
        XCTAssertEqual(width.relation, .equal)
        XCTAssertEqual(width.firstAttribute, .width)
        XCTAssertEqual(width.secondAttribute, .width)

        let height = constraints.second
        assertIdentical(height.firstItem, view1)
        assertIdentical(height.secondItem, view2)
        XCTAssertEqualWithAccuracy(height.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(height.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(height.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(height.isActive)
        XCTAssertEqual(height.relation, .equal)
        XCTAssertEqual(height.firstAttribute, .height)
        XCTAssertEqual(height.secondAttribute, .height)
    }

    func testViewEdgeAnchors() {
        let constraints = view1.edgeAnchors == view2.edgeAnchors

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
        XCTAssertEqualWithAccuracy(leading.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(leading.isActive)
        XCTAssertEqual(leading.relation, .equal)
        XCTAssertEqual(leading.firstAttribute, .leading)
        XCTAssertEqual(leading.secondAttribute, .leading)

        let trailing = constraints.trailing
        assertIdentical(trailing.firstItem, view1)
        assertIdentical(trailing.secondItem, view2)
        XCTAssertEqualWithAccuracy(trailing.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(trailing.isActive)
        XCTAssertEqual(trailing.relation, .equal)
        XCTAssertEqual(trailing.firstAttribute, .trailing)
        XCTAssertEqual(trailing.secondAttribute, .trailing)

        let top = constraints.top
        assertIdentical(top.firstItem, view1)
        assertIdentical(top.secondItem, view2)
        XCTAssertEqualWithAccuracy(top.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(top.isActive)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.secondAttribute, .top)

        let bottom = constraints.bottom
        assertIdentical(bottom.firstItem, view1)
        assertIdentical(bottom.secondItem, view2)
        XCTAssertEqualWithAccuracy(bottom.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(bottom.isActive)
        XCTAssertEqual(bottom.relation, .equal)
        XCTAssertEqual(bottom.firstAttribute, .bottom)
        XCTAssertEqual(bottom.secondAttribute, .bottom)
    }

    func testControllerEdgeAnchors() {
        let constraints = controller1.edgeAnchors == controller2.edgeAnchors

        let all = constraints.all
        XCTAssertEqual(all.count, 4)
        #if os(macOS)
            XCTAssertEqual(all[0].firstAttribute, .top)
            XCTAssertEqual(all[1].firstAttribute, .leading)
            XCTAssertEqual(all[2].firstAttribute, .bottom)
            XCTAssertEqual(all[3].firstAttribute, .trailing)
        #else
            XCTAssertEqual(all[0].firstAttribute, .bottom)
            XCTAssertEqual(all[1].firstAttribute, .leading)
            XCTAssertEqual(all[2].firstAttribute, .top)
            XCTAssertEqual(all[3].firstAttribute, .trailing)
        #endif

        let vertical = constraints.vertical
        XCTAssertEqual(vertical.count, 2)
        #if os(macOS)
            XCTAssertEqual(vertical[0].firstAttribute, .top)
            XCTAssertEqual(vertical[1].firstAttribute, .bottom)
        #else
            XCTAssertEqual(vertical[0].firstAttribute, .bottom)
            XCTAssertEqual(vertical[1].firstAttribute, .top)
        #endif

        let horizontal = constraints.horizontal
        XCTAssertEqual(horizontal.count, 2)
        XCTAssertEqual(horizontal[0].firstAttribute, .leading)
        XCTAssertEqual(horizontal[1].firstAttribute, .trailing)

        let leading = constraints.leading
        assertIdentical(leading.firstItem, controller1.view)
        assertIdentical(leading.secondItem, controller2.view)
        XCTAssertEqualWithAccuracy(leading.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(leading.isActive)
        XCTAssertEqual(leading.relation, .equal)
        XCTAssertEqual(leading.firstAttribute, .leading)
        XCTAssertEqual(leading.secondAttribute, .leading)

        let trailing = constraints.trailing
        assertIdentical(trailing.firstItem, controller1.view)
        assertIdentical(trailing.secondItem, controller2.view)
        XCTAssertEqualWithAccuracy(trailing.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(trailing.isActive)
        XCTAssertEqual(trailing.relation, .equal)
        XCTAssertEqual(trailing.firstAttribute, .trailing)
        XCTAssertEqual(trailing.secondAttribute, .trailing)

        let top = constraints.top
        #if os(macOS)
            assertIdentical(top.firstItem, controller1.view)
            assertIdentical(top.secondItem, controller2.view)
            XCTAssertEqual(top.firstAttribute, .top)
            XCTAssertEqual(top.secondAttribute, .top)
        #else
            assertIdentical(top.firstItem, controller1.topLayoutGuide)
            assertIdentical(top.secondItem, controller2.topLayoutGuide)
            XCTAssertEqual(top.firstAttribute, .bottom)
            XCTAssertEqual(top.secondAttribute, .bottom)
        #endif
        XCTAssertEqualWithAccuracy(top.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(top.isActive)
        XCTAssertEqual(top.relation, .equal)

        let bottom = constraints.bottom
        #if os(macOS)
            assertIdentical(bottom.firstItem, controller1.view)
            assertIdentical(bottom.secondItem, controller2.view)
            XCTAssertEqual(bottom.firstAttribute, .bottom)
            XCTAssertEqual(bottom.secondAttribute, .bottom)
        #else
            assertIdentical(bottom.firstItem, controller1.bottomLayoutGuide)
            assertIdentical(bottom.secondItem, controller2.bottomLayoutGuide)
            XCTAssertEqual(bottom.firstAttribute, .top)
            XCTAssertEqual(bottom.secondAttribute, .top)
        #endif
        XCTAssertEqualWithAccuracy(bottom.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(bottom.isActive)
        XCTAssertEqual(bottom.relation, .equal)
    }

    func testEdgeAnchorsWithOffsetAndPriority() {
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
        XCTAssertEqualWithAccuracy(leading.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(leading.isActive)
        XCTAssertEqual(leading.relation, .equal)
        XCTAssertEqual(leading.firstAttribute, .leading)
        XCTAssertEqual(leading.secondAttribute, .leading)

        let trailing = constraints.trailing
        assertIdentical(trailing.firstItem, view1)
        assertIdentical(trailing.secondItem, view2)
        XCTAssertEqualWithAccuracy(trailing.constant, -10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(trailing.isActive)
        XCTAssertEqual(trailing.relation, .equal)
        XCTAssertEqual(trailing.firstAttribute, .trailing)
        XCTAssertEqual(trailing.secondAttribute, .trailing)

        let top = constraints.top
        assertIdentical(top.firstItem, view1)
        assertIdentical(top.secondItem, view2)
        XCTAssertEqualWithAccuracy(top.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(top.isActive)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.secondAttribute, .top)

        let bottom = constraints.bottom
        assertIdentical(bottom.firstItem, view1)
        assertIdentical(bottom.secondItem, view2)
        XCTAssertEqualWithAccuracy(bottom.constant, -10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(bottom.isActive)
        XCTAssertEqual(bottom.relation, .equal)
        XCTAssertEqual(bottom.firstAttribute, .bottom)
        XCTAssertEqual(bottom.secondAttribute, .bottom)
    }

    func testAddingEdgeAnchorsWithInsets() {
        let insets = EdgeInsets(top: 10, left: 5, bottom: 15, right: 20)

        let constraints = view1.edgeAnchors == view2.edgeAnchors + insets ~ .high - 1

        let leading = constraints.leading
        assertIdentical(leading.firstItem, view1)
        assertIdentical(leading.secondItem, view2)
        XCTAssertEqualWithAccuracy(leading.constant, 5, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(leading.isActive)
        XCTAssertEqual(leading.relation, .equal)
        XCTAssertEqual(leading.firstAttribute, .leading)
        XCTAssertEqual(leading.secondAttribute, .leading)

        let trailing = constraints.trailing
        assertIdentical(trailing.firstItem, view1)
        assertIdentical(trailing.secondItem, view2)
        XCTAssertEqualWithAccuracy(trailing.constant, -20, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(trailing.isActive)
        XCTAssertEqual(trailing.relation, .equal)
        XCTAssertEqual(trailing.firstAttribute, .trailing)
        XCTAssertEqual(trailing.secondAttribute, .trailing)

        let top = constraints.top
        assertIdentical(top.firstItem, view1)
        assertIdentical(top.secondItem, view2)
        XCTAssertEqualWithAccuracy(top.constant, 10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(top.isActive)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.secondAttribute, .top)

        let bottom = constraints.bottom
        assertIdentical(bottom.firstItem, view1)
        assertIdentical(bottom.secondItem, view2)
        XCTAssertEqualWithAccuracy(bottom.constant, -15, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(bottom.isActive)
        XCTAssertEqual(bottom.relation, .equal)
        XCTAssertEqual(bottom.firstAttribute, .bottom)
        XCTAssertEqual(bottom.secondAttribute, .bottom)
    }

    func testSubtractingEdgeAnchorsWithInsets() {
        let insets = EdgeInsets(top: 10, left: 5, bottom: 15, right: 20)

        let constraints = view1.edgeAnchors == view2.edgeAnchors - insets ~ .high - 1

        let leading = constraints.leading
        assertIdentical(leading.firstItem, view1)
        assertIdentical(leading.secondItem, view2)
        XCTAssertEqualWithAccuracy(leading.constant, -5, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(leading.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(leading.isActive)
        XCTAssertEqual(leading.relation, .equal)
        XCTAssertEqual(leading.firstAttribute, .leading)
        XCTAssertEqual(leading.secondAttribute, .leading)

        let trailing = constraints.trailing
        assertIdentical(trailing.firstItem, view1)
        assertIdentical(trailing.secondItem, view2)
        XCTAssertEqualWithAccuracy(trailing.constant, 20, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(trailing.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(trailing.isActive)
        XCTAssertEqual(trailing.relation, .equal)
        XCTAssertEqual(trailing.firstAttribute, .trailing)
        XCTAssertEqual(trailing.secondAttribute, .trailing)

        let top = constraints.top
        assertIdentical(top.firstItem, view1)
        assertIdentical(top.secondItem, view2)
        XCTAssertEqualWithAccuracy(top.constant, -10, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(top.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(top.isActive)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.secondAttribute, .top)

        let bottom = constraints.bottom
        assertIdentical(bottom.firstItem, view1)
        assertIdentical(bottom.secondItem, view2)
        XCTAssertEqualWithAccuracy(bottom.constant, 15, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(bottom.priority, TestPriorityHigh - 1, accuracy: fEpsilon)
        XCTAssertTrue(bottom.isActive)
        XCTAssertEqual(bottom.relation, .equal)
        XCTAssertEqual(bottom.firstAttribute, .bottom)
        XCTAssertEqual(bottom.secondAttribute, .bottom)
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
        XCTAssertEqualWithAccuracy(width.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(width.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(width.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertFalse(width.isActive)
        XCTAssertEqual(width.relation, .equal)
        XCTAssertEqual(width.firstAttribute, .width)
        XCTAssertEqual(width.secondAttribute, .width)

        assertIdentical(height.firstItem, view1)
        assertIdentical(height.secondItem, view2)
        XCTAssertEqualWithAccuracy(height.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(height.multiplier, 0.5, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(height.priority, TestPriorityLow, accuracy: fEpsilon)
        XCTAssertFalse(height.isActive)
        XCTAssertEqual(height.relation, .equal)
        XCTAssertEqual(height.firstAttribute, .height)
        XCTAssertEqual(height.secondAttribute, .height)
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
        XCTAssertEqualWithAccuracy(width.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(width.multiplier, 1, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(width.priority, TestPriorityRequired, accuracy: fEpsilon)
        XCTAssertTrue(width.isActive)
        XCTAssertEqual(width.relation, .equal)
        XCTAssertEqual(width.firstAttribute, .width)
        XCTAssertEqual(width.secondAttribute, .width)

        assertIdentical(height.firstItem, view1)
        assertIdentical(height.secondItem, view2)
        XCTAssertEqualWithAccuracy(height.constant, 0, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(height.multiplier, 0.5, accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(height.priority, TestPriorityLow, accuracy: fEpsilon)
        XCTAssertTrue(height.isActive)
        XCTAssertEqual(height.relation, .equal)
        XCTAssertEqual(height.firstAttribute, .height)
        XCTAssertEqual(height.secondAttribute, .height)
    }

}

extension AnchorageTests {

    func assertIdentical(_ expression1: @autoclosure (Void) -> AnyObject?, _ expression2: @autoclosure (Void) -> AnyObject?, _ message: @autoclosure (Void) -> String = "Objects were not identical", file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(expression1() === expression2(), message, file: file, line: line)
    }

}

extension NSLayoutAttribute: CustomDebugStringConvertible {

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

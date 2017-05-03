//
//  FloatTests.swift
//  Anchorage
//
//  Created by Rob Visentin on 5/1/17.
//  Copyright © 2017 Raizlabs. All rights reserved.
//

@testable import Anchorage
import XCTest

class FloatTests: XCTestCase {

    func testCGFloatConversion() {
        XCTAssertEqualWithAccuracy(CGFloat(0), CGFloat(0).toCGFloat(), accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(CGFloat(Float(0)), Float(0).toCGFloat(), accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(CGFloat(Double(0)), Double(0).toCGFloat(), accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(CGFloat(Float80(0)), Float80(0).toCGFloat(), accuracy: cgEpsilon)

        XCTAssertEqualWithAccuracy(CGFloat.pi, CGFloat.pi.toCGFloat(), accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(CGFloat(Float.pi), Float.pi.toCGFloat(), accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(CGFloat(Double.pi), Double.pi.toCGFloat(), accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(CGFloat(Float80.pi), Float80.pi.toCGFloat(), accuracy: cgEpsilon)

        XCTAssertEqualWithAccuracy(-CGFloat.pi, (-CGFloat.pi).toCGFloat(), accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(-CGFloat(Float.pi), (-Float.pi).toCGFloat(), accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(-CGFloat(Double.pi), (-Double.pi).toCGFloat(), accuracy: cgEpsilon)
        XCTAssertEqualWithAccuracy(-CGFloat(Float80.pi), (-Float80.pi).toCGFloat(), accuracy: cgEpsilon)

        XCTAssertEqual(CGFloat.infinity, CGFloat.infinity.toCGFloat())
        XCTAssertEqual(CGFloat(Float.infinity), Float.infinity.toCGFloat())
        XCTAssertEqual(CGFloat(Double.infinity), Double.infinity.toCGFloat())
        XCTAssertEqual(CGFloat(Float80.infinity), Float80.infinity.toCGFloat())

        XCTAssertEqual(-CGFloat.infinity, (-CGFloat.infinity).toCGFloat())
        XCTAssertEqual(-CGFloat(Float.infinity), (-Float.infinity).toCGFloat())
        XCTAssertEqual(-CGFloat(Double.infinity), (-Double.infinity).toCGFloat())
        XCTAssertEqual(-CGFloat(Float80.infinity), (-Float80.infinity).toCGFloat())

        XCTAssert(CGFloat.nan.toCGFloat().isNaN)
        XCTAssert(Float.nan.toCGFloat().isNaN)
        XCTAssert(Double.nan.toCGFloat().isNaN)
        XCTAssert(Float80.nan.toCGFloat().isNaN)

        XCTAssert(CGFloat.signalingNaN.toCGFloat().isSignalingNaN)
        XCTAssert(Float.signalingNaN.toCGFloat().isSignalingNaN)
        XCTAssert(Double.signalingNaN.toCGFloat().isSignalingNaN)
        XCTAssert(Float80.signalingNaN.toCGFloat().isSignalingNaN)
    }

    func testFloatConversion() {
        XCTAssertEqualWithAccuracy(Float(0), CGFloat(0).toFloat(), accuracy: fEpsilon)
        XCTAssertEqualWithAccuracy(Float(Float(0)), Float(0).toFloat(), accuracy: fEpsilon)
        XCTAssertEqualWithAccuracy(Float(Double(0)), Double(0).toFloat(), accuracy: fEpsilon)
        XCTAssertEqualWithAccuracy(Float(Float80(0)), Float80(0).toFloat(), accuracy: fEpsilon)

        XCTAssertEqualWithAccuracy(Float.pi, CGFloat.pi.toFloat(), accuracy: fEpsilon)
        XCTAssertEqualWithAccuracy(Float(Float.pi), Float.pi.toFloat(), accuracy: fEpsilon)
        XCTAssertEqualWithAccuracy(Float(Double.pi), Double.pi.toFloat(), accuracy: fEpsilon)
        XCTAssertEqualWithAccuracy(Float(Float80.pi), Float80.pi.toFloat(), accuracy: fEpsilon)

        XCTAssertEqualWithAccuracy(-Float.pi, (-CGFloat.pi).toFloat(), accuracy: fEpsilon)
        XCTAssertEqualWithAccuracy(-Float(Float.pi), (-Float.pi).toFloat(), accuracy: fEpsilon)
        XCTAssertEqualWithAccuracy(-Float(Double.pi), (-Double.pi).toFloat(), accuracy: fEpsilon)
        XCTAssertEqualWithAccuracy(-Float(Float80.pi), (-Float80.pi).toFloat(), accuracy: fEpsilon)

        XCTAssertEqual(Float.infinity, CGFloat.infinity.toFloat())
        XCTAssertEqual(Float(Float.infinity), Float.infinity.toFloat())
        XCTAssertEqual(Float(Double.infinity), Double.infinity.toFloat())
        XCTAssertEqual(Float(Float80.infinity), Float80.infinity.toFloat())

        XCTAssertEqual(-Float.infinity, (-CGFloat.infinity).toFloat())
        XCTAssertEqual(-Float(Float.infinity), (-Float.infinity).toFloat())
        XCTAssertEqual(-Float(Double.infinity), (-Double.infinity).toFloat())
        XCTAssertEqual(-Float(Float80.infinity), (-Float80.infinity).toFloat())

        XCTAssert(CGFloat.nan.toFloat().isNaN)
        XCTAssert(Float.nan.toFloat().isNaN)
        XCTAssert(Double.nan.toFloat().isNaN)
        XCTAssert(Float80.nan.toFloat().isNaN)

        XCTAssert(CGFloat.signalingNaN.toFloat().isSignalingNaN)
        XCTAssert(Float.signalingNaN.toFloat().isSignalingNaN)
        XCTAssert(Double.signalingNaN.toFloat().isSignalingNaN)
        XCTAssert(Float80.signalingNaN.toFloat().isSignalingNaN)
    }

    func testDoubleConversion() {
        XCTAssertEqualWithAccuracy(Double(0), CGFloat(0).toDouble(), accuracy: dEpsilon)
        XCTAssertEqualWithAccuracy(Double(Float(0)), Float(0).toDouble(), accuracy: dEpsilon)
        XCTAssertEqualWithAccuracy(Double(Double(0)), Double(0).toDouble(), accuracy: dEpsilon)
        XCTAssertEqualWithAccuracy(Double(Float80(0)), Float80(0).toDouble(), accuracy: dEpsilon)

        XCTAssertEqualWithAccuracy(Double.pi, CGFloat.pi.toDouble(), accuracy: dEpsilon)
        XCTAssertEqualWithAccuracy(Double(Float.pi), Float.pi.toDouble(), accuracy: dEpsilon)
        XCTAssertEqualWithAccuracy(Double(Double.pi), Double.pi.toDouble(), accuracy: dEpsilon)
        XCTAssertEqualWithAccuracy(Double(Float80.pi), Float80.pi.toDouble(), accuracy: dEpsilon)

        XCTAssertEqualWithAccuracy(-Double.pi, (-CGFloat.pi).toDouble(), accuracy: dEpsilon)
        XCTAssertEqualWithAccuracy(-Double(Float.pi), (-Float.pi).toDouble(), accuracy: dEpsilon)
        XCTAssertEqualWithAccuracy(-Double(Double.pi), (-Double.pi).toDouble(), accuracy: dEpsilon)
        XCTAssertEqualWithAccuracy(-Double(Float80.pi), (-Float80.pi).toDouble(), accuracy: dEpsilon)

        XCTAssertEqual(Double.infinity, CGFloat.infinity.toDouble())
        XCTAssertEqual(Double(Float.infinity), Float.infinity.toDouble())
        XCTAssertEqual(Double(Double.infinity), Double.infinity.toDouble())
        XCTAssertEqual(Double(Float80.infinity), Float80.infinity.toDouble())

        XCTAssertEqual(-Double.infinity, (-CGFloat.infinity).toDouble())
        XCTAssertEqual(-Double(Float.infinity), (-Float.infinity).toDouble())
        XCTAssertEqual(-Double(Double.infinity), (-Double.infinity).toDouble())
        XCTAssertEqual(-Double(Float80.infinity), (-Float80.infinity).toDouble())

        XCTAssert(CGFloat.nan.toDouble().isNaN)
        XCTAssert(Float.nan.toDouble().isNaN)
        XCTAssert(Double.nan.toDouble().isNaN)
        XCTAssert(Float80.nan.toDouble().isNaN)

        XCTAssert(CGFloat.signalingNaN.toDouble().isSignalingNaN)
        XCTAssert(Float.signalingNaN.toDouble().isSignalingNaN)
        XCTAssert(Double.signalingNaN.toDouble().isSignalingNaN)
        XCTAssert(Float80.signalingNaN.toDouble().isSignalingNaN)
    }

    func testFloat80Conversion() {
        // Float80 seems to crash XCTAssertEqualWithAccuracy...
        func AssertEqualWithAccuracy(_ a: @autoclosure () throws -> Float80, _ b: @autoclosure () throws -> Float80, accuracy: Float80, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) rethrows {
            let lhs = try a()
            let rhs = try b()
            XCTAssert(abs(lhs - rhs) < accuracy, message, file: file, line: line)
        }

        AssertEqualWithAccuracy(Float80(0), CGFloat(0).toFloat80(), accuracy: f80Epsilon)
        AssertEqualWithAccuracy(Float80(Float(0)), Float(0).toFloat80(), accuracy: f80Epsilon)
        AssertEqualWithAccuracy(Float80(Double(0)), Double(0).toFloat80(), accuracy: f80Epsilon)
        AssertEqualWithAccuracy(Float80(Float80(0)), Float80(0).toFloat80(), accuracy: f80Epsilon)

        AssertEqualWithAccuracy(Float80.pi, CGFloat.pi.toFloat80(), accuracy: f80Epsilon)
        AssertEqualWithAccuracy(Float80(Float.pi), Float.pi.toFloat80(), accuracy: f80Epsilon)
        AssertEqualWithAccuracy(Float80(Double.pi), Double.pi.toFloat80(), accuracy: f80Epsilon)
        AssertEqualWithAccuracy(Float80(Float80.pi), Float80.pi.toFloat80(), accuracy: f80Epsilon)

        AssertEqualWithAccuracy(-Float80.pi, (-CGFloat.pi).toFloat80(), accuracy: f80Epsilon)
        AssertEqualWithAccuracy(-Float80(Float.pi), (-Float.pi).toFloat80(), accuracy: f80Epsilon)
        AssertEqualWithAccuracy(-Float80(Double.pi), (-Double.pi).toFloat80(), accuracy: f80Epsilon)
        AssertEqualWithAccuracy(-Float80(Float80.pi), (-Float80.pi).toFloat80(), accuracy: f80Epsilon)

        XCTAssertEqual(Float80.infinity, CGFloat.infinity.toFloat80())
        XCTAssertEqual(Float80(Float.infinity), Float.infinity.toFloat80())
        XCTAssertEqual(Float80(Double.infinity), Double.infinity.toFloat80())
        XCTAssertEqual(Float80(Float80.infinity), Float80.infinity.toFloat80())

        XCTAssertEqual(-Float80.infinity, (-CGFloat.infinity).toFloat80())
        XCTAssertEqual(-Float80(Float.infinity), (-Float.infinity).toFloat80())
        XCTAssertEqual(-Float80(Double.infinity), (-Double.infinity).toFloat80())
        XCTAssertEqual(-Float80(Float80.infinity), (-Float80.infinity).toFloat80())

        XCTAssert(CGFloat.nan.toFloat80().isNaN)
        XCTAssert(Float.nan.toFloat80().isNaN)
        XCTAssert(Double.nan.toFloat80().isNaN)
        XCTAssert(Float80.nan.toFloat80().isNaN)

        XCTAssert(CGFloat.signalingNaN.toFloat80().isSignalingNaN)
        XCTAssert(Float.signalingNaN.toFloat80().isSignalingNaN)
        XCTAssert(Double.signalingNaN.toFloat80().isSignalingNaN)
        XCTAssert(Float80.signalingNaN.toFloat80().isSignalingNaN)
    }

}

public extension BinaryFloatingPoint {

    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }

    func toFloat() -> Float {
        return Float(self)
    }

    func toDouble() -> Double {
        return Double(self)
    }

    func toFloat80() -> Float80 {
        return Float80(self)
    }

}

//
//  NSLayoutAnchor+MultiplierConstraints.swift
//  Anchorage
//
//  Created by Aleksandr Gusev on 7/21/17.
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

extension NSLayoutXAxisAnchor {
    func constraint(equalTo anchor: NSLayoutXAxisAnchor,
                    multiplier m: CGFloat,
                    constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor, constant: c)
        return constraint.with(multiplier: m)
    }

    func constraint(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor,
                    multiplier m: CGFloat,
                    constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = self.constraint(greaterThanOrEqualTo: anchor, constant: c)
        return constraint.with(multiplier: m)
    }

    func constraint(lessThanOrEqualTo anchor: NSLayoutXAxisAnchor,
                    multiplier m: CGFloat,
                    constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = self.constraint(lessThanOrEqualTo: anchor, constant: c)
        return constraint.with(multiplier: m)
    }
}

extension NSLayoutYAxisAnchor {
    func constraint(equalTo anchor: NSLayoutYAxisAnchor,
                    multiplier m: CGFloat,
                    constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor, constant: c)
        return constraint.with(multiplier: m)
    }

    func constraint(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor,
                    multiplier m: CGFloat,
                    constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = self.constraint(greaterThanOrEqualTo: anchor, constant: c)
        return constraint.with(multiplier: m)
    }

    func constraint(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor,
                    multiplier m: CGFloat,
                    constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = self.constraint(lessThanOrEqualTo: anchor, constant: c)
        return constraint.with(multiplier: m)
    }
}

private extension NSLayoutConstraint {
    func with(multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstItem!,
                                  attribute: firstAttribute,
                                  relatedBy: relation,
                                  toItem: secondItem,
                                  attribute: secondAttribute,
                                  multiplier: multiplier,
                                  constant: constant)
    }
}

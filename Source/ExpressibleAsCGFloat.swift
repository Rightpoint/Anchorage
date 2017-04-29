//
//  ExpressibleAsCGFloat.swift
//  Anchorage
//
//  Created by Zev Eisenberg on 4/29/17.
//  Copyright © 2017 Raizlabs. All rights reserved.
//

import CoreGraphics.CGBase

public protocol ExpressibleAsCGFloat {

    var asCGFloat: CGFloat { get }

}

extension CGFloat: ExpressibleAsCGFloat {

    public var asCGFloat: CGFloat {
        return self
    }

}

extension Float: ExpressibleAsCGFloat {

    public var asCGFloat: CGFloat {
        return CGFloat(self)
    }

}

extension Double: ExpressibleAsCGFloat {

    public var asCGFloat: CGFloat {
        return CGFloat(self)
    }

}

extension Float80: ExpressibleAsCGFloat {

    public var asCGFloat: CGFloat {
        return CGFloat(self)
    }

}

extension Int: ExpressibleAsCGFloat {

    public var asCGFloat: CGFloat {
        return CGFloat(self)
    }

}

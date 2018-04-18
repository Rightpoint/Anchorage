# Anchorage

[![Swift 3.0 + 4.0](https://img.shields.io/badge/Swift-3.0%20+%204.0-orange.svg?style=flat)](https://swift.org)
[![CircleCI](https://img.shields.io/circleci/project/github/Raizlabs/Anchorage/master.svg)](https://circleci.com/gh/Raizlabs/Anchorage)
[![Version](https://img.shields.io/cocoapods/v/Anchorage.svg?style=flat)](https://cocoadocs.org/docsets/Anchorage)
[![Platform](https://img.shields.io/cocoapods/p/Anchorage.svg?style=flat)](http://cocoapods.org/pods/Anchorage)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A lightweight collection of intuitive operators and utilities that simplify Auto Layout code. Anchorage is built directly on top of the `NSLayoutAnchor` API.

Each expression acts on one or more `NSLayoutAnchor`s, and returns active `NSLayoutConstraint`s. If you want inactive constraints, [here's how to do that](#batching-constraints).

# Usage

## Alignment

```swift
// Pin the button to 12 pt from the leading edge of its container
button.leadingAnchor == container.leadingAnchor + 12

// Pin the button to at least 12 pt from the trailing edge of its container
button.trailingAnchor <= container.trailingAnchor - 12

// Center one or both axes of a view
button.centerXAnchor == container.centerXAnchor
button.centerAnchors == container.centerAnchors
```

## Relative Alignment

```swift
// Position a view to be centered at 2/3 of its container's width
view.centerXAnchor == 2 * container.trailingAnchor / 3

// Pin the top of a view at 25% of container's height
view.topAnchor == container.bottomAnchor / 4
```

## Sizing

```swift
// Constrain a view's width to be at most 100 pt
view.widthAnchor <= 100

// Constraint a view to a fixed size
imageView.sizeAnchors == CGSize(width: 100, height: 200)

// Constrain two views to be the same size
imageView.sizeAnchors == view.sizeAnchors

// Constrain view to 4:3 aspect ratio
view.widthAnchor == 4 * view.heightAnchor / 3
```

## Composite Anchors

Constrain multiple edges at a time with this syntax:

```swift
// Constrain the leading, trailing, top and bottom edges to be equal
imageView.edgeAnchors == container.edgeAnchors

// Inset the edges of a view from another view
let insets = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
imageView.edgeAnchors == container.edgeAnchors + insets

// Inset the leading and trailing anchors by 10
imageView.horizontalAnchors >= container.horizontalAnchors + 10

// Inset the top and bottom anchors by 10
imageView.verticalAnchors >= container.verticalAnchors + 10
```

#### Use leading and trailing
Using `leftAnchor` and `rightAnchor` is rarely the right choice. To encourage this, `horizontalAnchors` and `edgeAnchors` use the `leadingAnchor` and `trailingAnchor` layout anchors.

#### Inset instead of Shift
When constraining leading/trailing or top/bottom, it is far more common to work in terms of an inset from the edges instead of shifting both edges in the same direction. When building the expression, Anchorage will flip the relationship and invert the constant in the constraint on the far side of the axis. This makes the expressions much more natural to work with.


## Priority

The `~` is used to specify priority of the constraint resulting from any Anchorage expression:

```swift
// Align view 20 points from the center of its superview, with system-defined low priority
view.centerXAnchor == view.superview.centerXAnchor + 20 ~ .low

// Align view 20 points from the center of its superview, with (required - 1) priority
view.centerXAnchor == view.superview.centerXAnchor + 20 ~ .required - 1

// Align view 20 points from the center of its superview, with custom priority
view.centerXAnchor == view.superview.centerXAnchor + 20 ~ 752
```
The layout priority is an enum with the following values:

- `.required` - `UILayoutPriorityRequired` (default)
- `.high` - `UILayoutPriorityDefaultHigh`
- `.low` - `UILayoutPriorityDefaultLow`
- `.fittingSize` - `UILayoutPriorityFittingSizeLevel`

## Storing Constraints

To store constraints created by Anchorage, simply assign the expression to a variable:

```swift
// A single (active) NSLayoutConstraint
let topConstraint = (imageView.topAnchor == container.topAnchor)

// EdgeConstraints represents a collection of constraints
// You can retrieve the NSLayoutConstraints individually,
// or get an [NSLayoutConstraint] via .all, .horizontal, or .vertical
let edgeConstraints = (button.edgeAnchors == container.edgeAnchors).all
```

## Batching Constraints

By default, Anchorage returns active layout constraints. If you'd rather return inactive constraints for use with the [`NSLayoutConstraint.activate(_:)` method](https://developer.apple.com/reference/uikit/nslayoutconstraint/1526955-activate) for performance reasons, you can do it like this:

```swift
let constraints = Anchorage.batch(active: false) {
    view1.widthAnchor == view2.widthAnchor
    view1.heightAnchor == view2.heightAnchor / 2 ~ .low
    // ... as many constraints as you want
}

// Later:
NSLayoutConstraint.activate(constraints)
```

You can also pass `active: true` if you want the constraints in the array to be automatically activated in a batch.

## Autoresizing Mask

Anchorage sets the `translatesAutoresizingMaskIntoConstraints` property to `false` on the *left* hand side of the expression, so you should never need to set this property manually. This is important to be aware of in case the container view relies on `translatesAutoresizingMaskIntoConstraints` being set to `true`. We tend to keep child views on the left hand side of the expression to avoid this problem, especially when constraining to a system-supplied view.

# Installation

## CocoaPods

To integrate Anchorage into your Xcode project using CocoaPods, specify it in
your Podfile:

```ruby
pod 'Anchorage'
```

## Carthage

To integrate Anchorage into your Xcode project using Carthage, specify it in
your Cartfile:

```ogdl
github "Raizlabs/Anchorage"
```

Run `carthage update` to build the framework and drag the built
`Anchorage.framework` into your Xcode project.

# License

This code and tool is under the MIT License. See `LICENSE` file in this repository.

Any ideas and contributions welcome!

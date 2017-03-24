# Anchorage

[![Swift 2.x + 3.0](https://img.shields.io/badge/Swift-2.3%20+%203.0-orange.svg?style=flat)](https://swift.org)
[![Version](https://img.shields.io/cocoapods/v/Anchorage.svg?style=flat)](https://cocoadocs.org/docsets/Anchorage)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A lightweight collection of intuitive operators and utilities that simplify iOS layout code. Anchorage is built directly on top of the `NSLayoutAnchor` API, so fully supports `UILayoutGuide`.
Each expression acts on one or more `NSLayoutAnchor`s, and returns active `NSLayoutConstraint`s.

# Usage

## Spacing

```swift
// Pin the button to at least 12 pts from the edges of its container view, and center it
button.leftAnchor    >= container.leftAnchor + 12
button.centerXAnchor == container.centerXAnchor
button.centerYAnchor == container.centerYAnchor
```
## Sizing

```swift
// Constrain a view's width to be at most 100 pts
view.widthAnchor <= 100

// Constrain two views to be the same size
view1.widthAnchor  == view2.widthAnchor
view1.heightAnchor == view2.heightAnchor

// Constrain view to 4:3 aspect ratio
view.widthAnchor == 4 * view.heightAnchor / 3
```

## Composite Anchors

```swift
// Constrain the leading, trailing, top and bottom edges to be equal
imageView.edgeAnchors == container.edgeAnchors

// Inset the leading and trailing anchors by 10
imageView.horizontalAnchors >= container.horizontalAnchors + 10

// Inset the top and bottom anchors by 10
imageView.verticalAnchors >= container.verticalAnchors + 10
```

The composite anchors create multiple constraints across one or two axis. Anchorage is smart about mapping these expressions to make them easy to work with.

##### Use leading and trailing
Using `leftAnchor` and `rightAnchor` is rarely needed. To encourage this, `horizontalAnchors` and `edgeAnchors` use the `leadingAnchor` and `trailingAnchor` layout anchors.

##### Inset instead of Shift
When constraining two sides of an axis, it is far more common to work in terms of an inset from the edges instead of shifting both edges in the same direction. When building the expression, Anchorage will flip the relationship and invert the constant in the constraint on the far side of the axis. This makes the expressions much more natural to work with.


## Priority

Priority of `NSLayoutConstraints` must be set before they are active.
The `~` is used to specify priority of the constraint resulting from an equation:

```swift
// Align view 20 points from the center of its superview, with low priority
view.centerXAnchor == view.superview.centerXAnchor + 20 ~ .low
```
The layout priority is an enum with the following values:

- .required - UILayoutPriorityRequired (default)
- .high - UILayoutPriorityDefaultHigh
- .low - UILayoutPriorityDefaultLow
- .fittingSize - UILayoutPriorityFittingSizeLevel
- .custom(UILayoutPriority) - you can specify any float


These map to the `UILayoutPriorityDefaultLow`, `UILayoutPriorityDefaultHigh`, and `UILayoutPriorityRequired` constants,
but you may specify any `Float` for a priority value.

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

## Autoresizing Mask

Anchorage sets the `translatesAutoresizingMaskIntoConstraints` property to `false` on the *left* hand side of the expression, so you should never need to set this property manually. This is important to be aware of in case the container view relies on `translatesAutoresizingMaskIntoConstraints` being set to `true`. We tend to keep child views on the left hand side of the expression to avoid this problem, especially when constraining to a system supplied view.

# Installation

## CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects.
You can install it with the following command:

```sh
$ gem install cocoapods
```

To integrate Anchorage into your Xcode project using CocoaPods, specify it in
your Podfile:

```ruby
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
  pod 'Anchorage', '~> 3.0'
end
```
Then, run the following command:

```sh
$ pod install
```

## Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency
manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](https://brew.sh/) using the following commands:

```sh
$ brew update
$ brew install carthage
```

To integrate Anchorage into your Xcode project using Carthage, specify it in
your Cartfile:

```
github "Raizlabs/Anchorage" ~> 3.0
```

Run `carthage update` to build the framework and drag the built
`Anchorage.framework` into your Xcode project.

# License

This code and tool is under the MIT License. See `LICENSE` file in this repository.

Any ideas and contributions welcome!

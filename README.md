#### Build Status

###### Master:

[![Build Status](https://travis-ci.org/lostatseajoshua/PriorityQueue.svg?branch=master)](https://travis-ci.org/lostatseajoshua/PriorityQueue)

###### Develop: 

[![Build Status](https://travis-ci.org/lostatseajoshua/PriorityQueue.svg?branch=master)](https://travis-ci.org/lostatseajoshua/PriorityQueue)

# PriorityQueue
Framework with data structure and protocol to serve elements in order by priority

## Overview
The `PriorityQueue` is a prioritized element collection. It provides quick access the highest priority element.
An element with high priority is served before an element with low priority. If two elements have the same priority, they are served according to their order in the queue.

The `PriorityType` data structure is backed arrays that hold alike priority elements together. The number of arrays is equal to 3 corresponding to the number of cases of in `Priority` enum. This adds the ability to add like priority elements by index and have like elements being served in a specific order as well.

```swift
// PriorityQueue class internal collections
var highPriorityCollection = [PriorityType]()
var defaultPriorityCollection = [PriorityType]()
var lowPriorityCollection = [PriorityType]()
```

 The `PriorityQueue` elements must adhere to `PriorityType` which adds an associated "`priority`" to each element.

## Requirements
Xcode 8

Swift 3.1

iOS 8.0+

## Code Example
Creating a queue
```swift
let priorityQueue = PriorityQueue()
```

Adding an element
```swift
let foo = Foo(priority: .high, value: 0)
priorityQueue.add(item: foo)
```

Create an element that adheres to the `PriorityType` protocol
```swift
struct Foo: PriorityType {
    var priority: Priority
    let value: Int
}
```

Insert an element
```swift
let foo = Foo(priority: .high, value: 0)
priorityQueue.insert(item: foo)
```

Insert an element at a specified position in its corresponding priority collection.
```swift
let foo = Foo(priority: .high, value: 0)
priorityQueue.insert(item: foo, at: 2) // inserted at index 2 in the collection of high priority alike elements
```

Remove all elements from the queue
```swift
priorityQueue.removeAll()
```

Get top item
```swift
let top = priorityQueue.getTopItem() // returns a PriorityType object
```

Get top object (casted)
```swift
let topFoo: Foo? = priorityQueue.getTopObject() // returns Foo object
```

## Installation
```@available(iOS 8, *)```

#### Swift Package Manager

```swift
import PackageDescription

let package = Package(
    name: "YourProject",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/lostatseajoshua/PriorityQueue.git",
                 majorVersion: 1)
    ]
)
```

#### Manually

To use this library in your project manually do the following.

Add the PriorityQueue.framework to your project by downloading the framework from the [releases](https://github.com/lostatseajoshua/PriorityQueue/releases)

## Contributors
Joshua Alvarado - [Twitter](https://www.twitter.com/alvaradojoshua0)

## License
This project is released under the [MIT license](https://github.com/lostatseajoshua/PriorityQueue/blob/master/LICENSE).

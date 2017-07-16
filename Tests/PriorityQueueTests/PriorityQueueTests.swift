import XCTest
@testable import PriorityQueue

struct Foo: PriorityType {
    var priority: Priority
    let value: Int
}

struct Bar: PriorityType {
    var priority: Priority
    let title: String
}

struct Baz: PriorityType, Equatable {
    var priority: Priority
    let context: Double

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func ==(lhs: Baz, rhs: Baz) -> Bool {
        return lhs.context == rhs.context && lhs.priority == rhs.priority
    }
}

class PriorityQueueTests: XCTestCase {
    static var allTests = [
        (testAddingAnItem, "testAddingAnItem"),
        (testAddingItems, "testAddingItems"),
        (testAddingArrayOfItems, "testAddingArrayOfItems"),
        (testInsertingOneItem, "testInsertingOneItem"),
        (testInsertingItems, "testInsertingItems"),
        (testInsertingAtIndex, "testInsertingAtIndex"),
        (testRemovingAllOneItem, "testRemovingAllOneItem"),
        (testRemovingNextItem, "testRemovingNextItem"),
        (testRemovingAllItems, "testRemovingAllItems"),
        (testRemoveItemAtOf, "testRemoveItemAtOf"),
        (testRemoveObjectAtOf, "testRemoveObjectAtOf"),
        (testRemoveFirstItemWhere, "testRemoveFirstItemWhere"),
        (testRemoveItemFromWhere, "testRemoveItemFromWhere"),
        (testRemoveItemsOfPriority, "testRemoveItemsOfPriority"),
        (testPeekAtNextItem, "testPeekAtNextItem"),
        (testPeekAtNextObject, "testPeekAtNextObject"),
        (testGettingNextItem, "testGettingNextItem"),
        (testGettingNextItems, "testGettingNextItems"),
        (testGettingNextObject, "testGettingNextObject"),
        (testGettingAllItemsOf, "testGettingAllItemsOf"),
        (testGettingTopObjectFromAddingItems, "testGettingTopObjectFromAddingItems"),
        (testDescription, "testDescription"),
        (testDebugDescription, "testDebugDescription")
    ]
    
    // MARK: - Insert / Add

    func testAddingAnItem() {
        let priorityQueue = PriorityQueue()
        let foo = Foo(priority: .high, value: 0)
        priorityQueue.add(item: foo)
        XCTAssertEqual(priorityQueue.count, 1)
    }

    func testAddingItems() {
        let priorityQueue = PriorityQueue()
        addManyItems(to: priorityQueue)
        XCTAssertEqual(priorityQueue.count, 1000)
    }

    func testAddingArrayOfItems() {
        let priorityQueue = PriorityQueue()

        var foos = [Foo]()

        var number = 0

        for i in 0..<1000 {
            var foo = Foo(priority: .low, value: i)

            if number == 1 {
                foo = Foo(priority: .medium, value: i)
            }

            if number == 2 {
                foo = Foo(priority: .high, value: i)
            }

            foos.append(foo)

            number += 1

            if number == 3 {
                number = 0
            }
        }

        priorityQueue.add(items: foos)
        XCTAssertEqual(priorityQueue.count, 1000)
    }


    func testInsertingOneItem() {
        let priorityQueue = PriorityQueue()
        priorityQueue.insert(item: Foo(priority: .low, value: 0))
        XCTAssertEqual(priorityQueue.count, 1)
    }

    func testInsertingItems() {
        let priorityQueue = PriorityQueue()
        insertManyItems(into: priorityQueue)
        XCTAssertEqual(priorityQueue.count, 1000)
    }

    func testInsertingAtIndex() {
        let priorityQueue = PriorityQueue()
        let bar = Bar(priority: .high, title: "Hey")
        let foo = Foo(priority: .medium, value: 1)
        let baz = Baz(priority: .low, context: 40.0)

        priorityQueue.insert(item: bar, at: 0)
        priorityQueue.insert(item: foo, at: 2)
        priorityQueue.insert(item: baz, at: -1)

        XCTAssertEqual(priorityQueue.count, 3)
        XCTAssertEqual(priorityQueue.getAllItems(of: .high).count, 1)
        XCTAssertEqual(priorityQueue.getAllItems(of: .medium).count, 1)
        XCTAssertEqual(priorityQueue.getAllItems(of: .low).count, 1)
    }

    // MARK: - Remove

    func testRemovingAllOneItem() {
        let priorityQueue = PriorityQueue()
        let foo0 = Foo(priority: .low, value: 0)

        priorityQueue.insert(item: foo0)
        XCTAssertEqual(priorityQueue.count, 1)

        priorityQueue.removeAll()
        XCTAssertTrue(priorityQueue.isEmpty)
    }

    func testRemovingNextItem() {
        let priorityQueue = PriorityQueue()
        let foo = Foo(priority: .high, value: 0)
        priorityQueue.insert(item: foo)

        XCTAssertTrue(priorityQueue.removeTopItem())
        XCTAssertTrue(priorityQueue.isEmpty)
        XCTAssertFalse(priorityQueue.removeTopItem())
    }

    func testRemovingAllItems() {
        let priorityQueue = PriorityQueue()
        insertManyItems(into: priorityQueue)

        XCTAssertEqual(priorityQueue.count, 1000)

        priorityQueue.removeAll()
        XCTAssertTrue(priorityQueue.isEmpty)
    }

    func testRemoveObject() {
        let priorityQueue = PriorityQueue()
        let baz0 = Baz(priority: .low, context: 30.0)
        let baz1 = Baz(priority: .medium, context: 40.0)
        let baz2 = Baz(priority: .high, context: 100)
        let baz3 = Baz(priority: .high, context: 11)

        priorityQueue.add(items: [baz0, baz1, baz2])

        let removedBaz0 = priorityQueue.remove(object: baz0)
        XCTAssertNotNil(removedBaz0)
        XCTAssertEqual(removedBaz0?.context, baz0.context)

        let removedBaz1 = priorityQueue.remove(object: baz1)
        XCTAssertNotNil(removedBaz1)
        XCTAssertEqual(removedBaz1?.context, baz1.context)

        let removedBaz2 = priorityQueue.remove(object: baz2)
        XCTAssertNotNil(removedBaz2)
        XCTAssertEqual(removedBaz2?.context, baz2.context)

        XCTAssertNil(priorityQueue.remove(object: baz3))
    }

    func testRemoveItemAtOf() {
        let priorityQueue = PriorityQueue()
        for i in 0...3 {
            priorityQueue.add(items: [Foo(priority: .high, value: i),
                                      Foo(priority: .medium, value: i),
                                      Foo(priority: .low, value: i)])
        }

        XCTAssertEqual(priorityQueue.count, 12)

        priorityQueue.insert(item: Foo(priority: .high, value: 4), at: 2)
        priorityQueue.insert(item: Foo(priority: .medium, value: 4), at: 2)
        priorityQueue.insert(item: Foo(priority: .low, value: 4), at: 2)

        XCTAssertEqual(priorityQueue.count, 15)
        XCTAssertEqual(priorityQueue.getAllItems(of: .high).count, 5)
        XCTAssertEqual(priorityQueue.getAllItems(of: .medium).count, 5)
        XCTAssertEqual(priorityQueue.getAllItems(of: .low).count, 5)

        let highFoo = priorityQueue.removeItem(at: 2, of: .high)
        let medFoo = priorityQueue.removeItem(at: 2, of: .medium)
        let lowFoo = priorityQueue.removeItem(at: 2, of: .low)

        XCTAssertNotNil(highFoo)
        XCTAssertNotNil(medFoo)
        XCTAssertNotNil(lowFoo)

        XCTAssertEqual((highFoo as? Foo)?.value, 4)
        XCTAssertEqual((medFoo as? Foo)?.value, 4)
        XCTAssertEqual((lowFoo as? Foo)?.value, 4)

        XCTAssertNil(priorityQueue.removeItem(at: 20, of: .high))
        XCTAssertNil(priorityQueue.removeItem(at: -1, of: .medium))
        XCTAssertNil(priorityQueue.removeItem(at: 100, of: .low))
    }

    func testRemoveObjectAtOf() {
        let priorityQueue = PriorityQueue()
        for i in 0...3 {
            priorityQueue.add(items: [Foo(priority: .high, value: i),
                                      Foo(priority: .medium, value: i),
                                      Foo(priority: .low, value: i)])
        }

        XCTAssertEqual(priorityQueue.count, 12)

        priorityQueue.insert(item: Foo(priority: .high, value: 4), at: 2)
        priorityQueue.insert(item: Foo(priority: .medium, value: 4), at: 2)
        priorityQueue.insert(item: Foo(priority: .low, value: 4), at: 2)

        XCTAssertEqual(priorityQueue.count, 15)
        XCTAssertEqual(priorityQueue.getAllItems(of: .high).count, 5)
        XCTAssertEqual(priorityQueue.getAllItems(of: .medium).count, 5)
        XCTAssertEqual(priorityQueue.getAllItems(of: .low).count, 5)

        XCTAssertNil(priorityQueue.removeObject(at: 100, of: .high))
        XCTAssertNil(priorityQueue.removeObject(at: 100, of: .medium))
        XCTAssertNil(priorityQueue.removeObject(at: 100, of: .low))

        let baz0: Baz? = priorityQueue.removeObject(at: 2, of: .high)
        let baz1: Baz? = priorityQueue.removeObject(at: 2, of: .medium)
        let baz2: Baz? = priorityQueue.removeObject(at: 2, of: .low)

        XCTAssertNil(baz0)
        XCTAssertNil(baz1)
        XCTAssertNil(baz2)

        let highFoo: Foo? = priorityQueue.removeObject(at: 2, of: .high)
        let medFoo: Foo? = priorityQueue.removeObject(at: 2, of: .medium)
        let lowFoo: Foo? = priorityQueue.removeObject(at: 2, of: .low)

        XCTAssertNotNil(highFoo)
        XCTAssertNotNil(medFoo)
        XCTAssertNotNil(lowFoo)

        XCTAssertEqual(highFoo?.value, 4)
        XCTAssertEqual(medFoo?.value, 4)
        XCTAssertEqual(lowFoo?.value, 4)
    }

    func testRemoveFirstItemWhere() {
        let priorityQueue = PriorityQueue()
        let foo0 = Foo(priority: .high, value: 0)
        let foo1 = Foo(priority: .medium, value: 1)
        let foo2 = Foo(priority: .low, value: 2)
        priorityQueue.add(items: [foo0, foo1, foo2])

        XCTAssertNil(priorityQueue.removeFirstItem { $0 is Baz })
        XCTAssertNil(priorityQueue.removeFirstItem { $0 is Baz })
        XCTAssertNil(priorityQueue.removeFirstItem { $0 is Baz })

        XCTAssertNotNil(priorityQueue.removeFirstItem { $0.priority == .high })
        XCTAssertNotNil(priorityQueue.removeFirstItem { $0.priority == .medium })
        XCTAssertNotNil(priorityQueue.removeFirstItem { $0.priority == .low })
        XCTAssertNil(priorityQueue.removeFirstItem { $0.priority == .low })
    }

    func testRemoveItemFromWhere() {
        let priorityQueue = PriorityQueue()
        let foo0 = Foo(priority: .high, value: 12)
        let foo1 = Foo(priority: .medium, value: 1)
        let foo2 = Foo(priority: .low, value: 111)

        priorityQueue.add(items: [foo0, foo1, foo2])

        XCTAssertNil(priorityQueue.removeItem(of: .high) { ($0 as? Foo)?.value == 100 })
        XCTAssertNil(priorityQueue.removeItem(of: .medium) { ($0 as? Foo)?.value == 100 })
        XCTAssertNil(priorityQueue.removeItem(of: .low) { ($0 as? Foo)?.value == 100 })

        XCTAssertNotNil(priorityQueue.removeItem(of: .high) { ($0 as? Foo)?.value == foo0.value })
        XCTAssertNotNil(priorityQueue.removeItem(of: .medium) { ($0 as? Foo)?.value == foo1.value })
        XCTAssertNotNil(priorityQueue.removeItem(of: .low) { ($0 as? Foo)?.value == foo2.value })
    }

    func testRemoveItemsOfPriority() {
        let priorityQueue = PriorityQueue()
        insertManyItems(into: priorityQueue)
        XCTAssertEqual(priorityQueue.count, 1000)

        let highs = priorityQueue.removeAllItems(of: .high)
        XCTAssertEqual(highs.count, 333)
        highs.forEach { XCTAssertTrue($0.priority == .high) }
        XCTAssertEqual(priorityQueue.count, 667)

        let mediums = priorityQueue.removeAllItems(of: .medium)
        XCTAssertEqual(mediums.count, 333)
        mediums.forEach { XCTAssertTrue($0.priority == .medium) }
        XCTAssertEqual(priorityQueue.count, 334)

        let lows = priorityQueue.removeAllItems(of: .low)
        XCTAssertEqual(lows.count, 334)
        lows.forEach { XCTAssertTrue($0.priority == .low) }
        XCTAssertTrue(priorityQueue.isEmpty)
    }

    // MARK: - Peek
    func testPeekAtNextItem() {
        let priorityQueue = PriorityQueue()
        let bar = Bar(priority: .high, title: "Hey")
        let foo = Foo(priority: .medium, value: 1)
        let baz = Baz(priority: .low, context: 30.0)
        priorityQueue.add(item: baz)
        priorityQueue.add(item: bar)
        priorityQueue.add(item: foo)

        let topItem0 = priorityQueue.peekAtTopItem()
        XCTAssertNotNil(topItem0)
        XCTAssertEqual((topItem0 as? Bar)?.title, bar.title)

        XCTAssertTrue(priorityQueue.removeTopItem())

        let topItem1 = priorityQueue.peekAtTopItem()
        XCTAssertNotNil(topItem1)
        XCTAssertEqual((topItem1 as? Foo)?.value, foo.value)

        XCTAssertTrue(priorityQueue.removeTopItem())

        let topItem2 = priorityQueue.peekAtTopItem()
        XCTAssertNotNil(topItem2)
        XCTAssertEqual((topItem2 as? Baz)?.context, baz.context)

        XCTAssertTrue(priorityQueue.removeTopItem())
        XCTAssertNil(priorityQueue.peekAtTopItem())
    }

    func testPeekAtNextObject() {
        let priorityQueue = PriorityQueue()
        let bar = Bar(priority: .high, title: "Hey")
        let foo = Foo(priority: .medium, value: 1)
        let baz = Baz(priority: .low, context: 30.0)
        priorityQueue.add(item: baz)
        priorityQueue.add(item: bar)
        priorityQueue.add(item: foo)

        let topItem0: Bar? = priorityQueue.peekAtTopObject()
        XCTAssertNotNil(topItem0)
        XCTAssertEqual(topItem0?.title, bar.title)

        XCTAssertTrue(priorityQueue.removeTopItem())

        let topItem1: Foo? = priorityQueue.peekAtTopObject()
        XCTAssertNotNil(topItem1)
        XCTAssertEqual(topItem1?.value, foo.value)

        XCTAssertTrue(priorityQueue.removeTopItem())

        let topItem2: Baz? = priorityQueue.peekAtTopObject()
        XCTAssertNotNil(topItem2)
        XCTAssertEqual(topItem2?.context, baz.context)

        XCTAssertTrue(priorityQueue.removeTopItem())
        XCTAssertNil(priorityQueue.peekAtTopObject())
    }

    // MARK: - Retrieveing item

    func testGettingNextItem() {
        let priorityQueue = PriorityQueue()
        let fooValue = 1000
        let foo = Foo(priority: .high, value: fooValue)
        priorityQueue.insert(item: foo)

        let top = priorityQueue.getTopItem()
        XCTAssertTrue(priorityQueue.isEmpty)
        XCTAssertNotNil(top)
        XCTAssertEqual(top?.priority, .high)
        if let topFoo = top as? Foo {
            XCTAssertEqual(topFoo.value, fooValue)
        } else {
            XCTFail("top should type cast to foo")
        }
    }

    func testGettingNextItems() {
        let priorityQueue = PriorityQueue()
        let foo0 = Foo(priority: .high, value: 0)
        let foo1 = Foo(priority: .high, value: 1)

        let foo2 = Foo(priority: .medium, value: 2)
        let foo3 = Foo(priority: .medium, value: 3)
        let foo4 = Foo(priority: .medium, value: 4)

        let foo5 = Foo(priority: .low, value: 5)

        let items = [foo0, foo1, foo2, foo3, foo4, foo5]

        priorityQueue.add(items: items)

        for foo in items {
            let top = priorityQueue.getTopItem() as? Foo
            XCTAssertNotNil(top)
            XCTAssertEqual(foo.priority, top?.priority)
            XCTAssertEqual(foo.value, top?.value)
        }
    }

    func testGettingNextObject() {
        let priorityQueue = PriorityQueue()
        let expectedFooValue = 0
        let expectedBar0Value = "Hey"
        let expectedBar1Value = "Hello"

        let foo = Foo(priority: .high, value: expectedFooValue)
        let bar0 = Bar(priority: .low, title: expectedBar0Value)
        let bar1 = Bar(priority: .low, title: expectedBar1Value)

        priorityQueue.add(item: bar0)
        priorityQueue.add(item: bar1)
        priorityQueue.add(item: foo)

        let topFoo: Foo? = priorityQueue.getTopObject()
        XCTAssertNotNil(topFoo)
        XCTAssertEqual(topFoo?.value, expectedFooValue)

        let topBar0: Bar? = priorityQueue.getTopObject()
        XCTAssertNotNil(topBar0)
        XCTAssertEqual(topBar0?.title, expectedBar0Value)

        let badCastBar: Foo? = priorityQueue.getTopObject()
        XCTAssertNil(badCastBar)

        let topBar1: Bar? = priorityQueue.getTopObject()
        XCTAssertNotNil(topBar1)
        XCTAssertEqual(topBar1?.title, expectedBar1Value)

        let badCast: Foo? = priorityQueue.getTopObject()
        XCTAssertNil(badCast)
    }

    func testGettingAllItemsOf() {
        let priorityQueue = PriorityQueue()
        insertManyItems(into: priorityQueue)

        let highFoos = priorityQueue.getAllItems(of: .high)
        XCTAssertEqual(highFoos.count, 333)

        let mediumFoos = priorityQueue.getAllItems(of: .medium)
        XCTAssertEqual(mediumFoos.count, 333)

        let lowFoos = priorityQueue.getAllItems(of: .low)
        XCTAssertEqual(lowFoos.count, 334)
    }

    func testGettingTopObjectFromAddingItems() {
        let priorityQueue = PriorityQueue()
        var foos = [Foo]()

        var number = 0

        for i in 0..<1000 {
            var foo = Foo(priority: .low, value: i)

            if number == 1 {
                foo = Foo(priority: .medium, value: i)
            }

            if number == 2 {
                foo = Foo(priority: .high, value: i)
            }

            foos.append(foo)

            number += 1

            if number == 3 {
                number = 0
            }
        }
        
        priorityQueue.add(items: foos)

        for i in stride(from: 2, to: 999, by: 3) {
            let top = priorityQueue.getTopItem()
            XCTAssertNotNil(top)
            XCTAssertEqual(top?.priority, .high)
            XCTAssertEqual((top as? Foo)?.value, i)
        }

        for i in stride(from: 1, to: 999, by: 3) {
            let top = priorityQueue.getTopItem()
            XCTAssertNotNil(top)
            XCTAssertEqual(top?.priority, .medium)
            XCTAssertEqual((top as? Foo)?.value, i)
        }

        for i in stride(from: 0, to: 999, by: 3) {
            let top = priorityQueue.getTopItem()
            XCTAssertNotNil(top)
            XCTAssertEqual(top?.priority, .low)
            XCTAssertEqual((top as? Foo)?.value, i)
        }
    }

    func testDescription() {
        let priorityQueue = PriorityQueue()
        XCTAssertFalse(priorityQueue.description.isEmpty)
    }

    func testDebugDescription() {
        let priorityQueue = PriorityQueue()
        XCTAssertFalse(priorityQueue.debugDescription.isEmpty)
    }

    // MARK: - Utility
    private final func insertManyItems(into queue: PriorityQueue) {
        var number = 0

        for i in 0..<1000 {
            var foo = Foo(priority: .low, value: i)

            if number == 1 {
                foo = Foo(priority: .medium, value: i)
            }

            if number == 2 {
                foo = Foo(priority: .high, value: i)
            }

            queue.insert(item: foo)
            number += 1

            if number == 3 {
                number = 0
            }
        }
    }

    private final func addManyItems(to queue: PriorityQueue) {
        var number = 0

        for i in 0..<1000 {
            var foo = Foo(priority: .low, value: i)

            if number == 1 {
                foo = Foo(priority: .medium, value: i)
            }

            if number == 2 {
                foo = Foo(priority: .high, value: i)
            }

            queue.add(item: foo)
            number += 1

            if number == 3 {
                number = 0
            }
        }
    }
}

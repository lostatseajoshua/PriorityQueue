//
//  PriorityQueue.swift
//  PriorityQueue
//
//  Created by Joshua Alvarado on 7/9/17.
//  Copyright © 2017 Joshua Alvarado. All rights reserved.
//

/**
 A prioritized element collection.

 The `PriorityQueue` holds a collection of ranked objects.

 A `PriorityQueue` is efficient where an element of a collection with the highest priority is to be accessed one at a time.

 The `PriorityQueue` provides quick access the top highest priority element.
 An element with high priority is served before an element with low priority. If two elements have the same priority, they are served according to their order in the queue.

 The `PriorityType` data structure is backed arrays that hold alike priority elements together. The number of arrays is equal to 3 corresponding to the number of cases of in `Priority` enum. This adds the ability to add like priority elements by index and have like elements being served in a specific order as well.

 The `PriorityQueue` elements must adhere to `PriorityType` which adds an associated "`priority`" to each element.
 */
public class PriorityQueue {
    fileprivate var highPriorityCollection = [PriorityType]()
    fileprivate var defaultPriorityCollection = [PriorityType]()
    fileprivate var lowPriorityCollection = [PriorityType]()

    /// Number of total elements in the queue.
    public var count: Int {
        return highPriorityCollection.count + defaultPriorityCollection.count + lowPriorityCollection.count
    }

    /// A Boolean value indicating whether the queue is empty.
    /// Use `isEmpty` property instead of checking if the count is equal to zero.
    public var isEmpty: Bool {
        return highPriorityCollection.isEmpty && defaultPriorityCollection.isEmpty && lowPriorityCollection.isEmpty
    }

    // MARK: - Add

    /**
     Adds an element to the queue.

     The element is inserted properly based on its priority.

     - Parameter item: Element to add to the queue.
     */
    public func add(item: PriorityType) {
        insert(item: item)
    }

    /**
     Adds the elements of a sequence to the of the queue.

     The elements will be inserted properly based their priority.

     - Parameter item: Element to add to the queue.
     */
    public func add(items: [PriorityType]) {
        items.forEach { insert(item: $0) }
    }

    // MARK: - Insert
    /**
     Inserts a new element to the queue at the specified position of its corresponding priority collection.
     
     The element is inserted in the specified index. If an index passed is greater than or equal to the 
     `endIndex` of its priority collection the element will be appended to the end. If the index is less than it the 
     `startIndex` the element will be insert at the `0` index. If an index is not passed in then the new element will be appended.
     
     - Parameters:
        - item: The element to insert into the queue.
        - index: Optional index position in which to insert the new element.
    */
    public func insert(item: PriorityType, at index: Int? = nil) {
        switch item.priority {
        case .high:
            insert(item, inCollection: &highPriorityCollection, index: index)
        case .medium:
            insert(item, inCollection: &defaultPriorityCollection, index: index)
        case .low:
            insert(item, inCollection: &lowPriorityCollection, index: index)
        }
    }

    // MARK: - Retrieve

    /**
     Removes and returns the top element of the queue.
     
     If the queue is empty the return value is `nil`.
     
     - Returns: Element at the top of the queue.
     */
    public func getTopItem() -> PriorityType? {
        if !highPriorityCollection.isEmpty {
            return highPriorityCollection.removeFirst()
        }

        if !defaultPriorityCollection.isEmpty {
            return defaultPriorityCollection.removeFirst()
        }

        if !lowPriorityCollection.isEmpty {
            return lowPriorityCollection.removeFirst()
        }

        return nil
    }

    /**
     The top element of the queue cast to the return value.

     If the queue is empty or the element fails to be cast to the return value type
     then the return value is `nil`.
     
     - Note: The top element will not be removed if the casting fails.

     - Returns: Element at the top of the queue.
     */
    public func getTopObject<T>() -> T? {
        if peekAtTopItem() is T {
            return getTopItem() as? T
        }

        return nil
    }

    /**
     Returns a copy of all the elements from the queue that corresponds to the specified priority.

     - Parameter of: The specified priority of the elements requested.
     - Returns: A collection of elements with the specified priority.
     */
    public func getAllItems(of priortiy: Priority) -> [PriorityType] {
        switch priortiy {
        case .high:
            return highPriorityCollection
        case .medium:
            return defaultPriorityCollection
        case .low:
            return lowPriorityCollection
        }
    }

    // MARK: - Peek

    /**
     Returns the top element of the queue. The element will not be removed

     If the queue is empty the return value is `nil`.

     - Returns: Element at the top of the queue
     */
    public func peekAtTopItem() -> PriorityType? {
        if !highPriorityCollection.isEmpty {
            return highPriorityCollection.first
        }

        if !defaultPriorityCollection.isEmpty {
            return defaultPriorityCollection.first
        }

        if !lowPriorityCollection.isEmpty {
            return lowPriorityCollection.first
        }

        return nil
    }


    /**
     Returns the top element of the queue. The element will not be removed

     If the queue is empty or the element fails to cast as the return value
     then the return value is `nil`.

     - Returns: Element at the top of the queue
     */
    public func peekAtTopObject<T>() -> T? {
        if !highPriorityCollection.isEmpty {
            return highPriorityCollection.first as? T
        }

        if !defaultPriorityCollection.isEmpty {
            return defaultPriorityCollection.first as? T
        }

        if !lowPriorityCollection.isEmpty {
            return lowPriorityCollection.first as? T
        }

        return nil
    }

    // MARK: - Remove

    /**
     Discards the top element of the queue.
     
     - Returns: `true` if a value was removed indicating the queue is not empty.
     `false` if no item was discarded.
     */
    @discardableResult public func removeTopItem() -> Bool {
        return getTopItem() != nil
    }

    /**
     Removes all the elements from the queue.
     
     The queue contains three collections which correspond to the three priority cases.
     This will remove all elements of each priority collection.

     - Complexity: O(*h*+*m*+*l*), where *h* is the length of the high priority collection,
     m is the length of the medium priority collection, and l is the length of the low
     priority collection
    */
    public func removeAll() {
        highPriorityCollection.removeAll()
        defaultPriorityCollection.removeAll()
        lowPriorityCollection.removeAll()
    }

    /**
     Removes all the elements from the queue with the corresponding priority.

     The queue contains three collections which correspond to the three priority cases.
     This will remove all the elements of the priority collection corresponding to the priority parameter.

     - Parameter of: The specified priority of the elements to remove.
     - Returns: The elements that were removed from the queue.
     
     - Complexity: O(*n*), where *n* is the number elements in the queue with the specified priority.
     */
    @discardableResult public func removeAllItems(of priortiy: Priority) -> [PriorityType] {
        let items = getAllItems(of: priortiy)

        switch priortiy {
        case .high:
            highPriorityCollection.removeAll()
        case .medium:
            defaultPriorityCollection.removeAll()
        case .low:
            lowPriorityCollection.removeAll()
        }

        return items
    }

    /**
     Removes an item from the queue where the element satisfies the given predicate with the
     specified priority.
     
     - Note: Specifying the priority will result in a more efficient attempt to satsify the predicate.

     Use a predicate to remove an element of a type that doesn't conform to `Equatable` protocol
     or remove an element that satisfies a requirement.

         removeItem(of: .high, where: { item in -> Bool
            return (item as? CustomObject).value == value
         })

     - Parameters:
        - of: The specified priority of the elements to remove.
        - where: A closure that takes an element as its argument and returns a Boolean value that indicates whether the passed element represents a match.
        - item: The element passed into the closure of type `PriorityType`

     - Returns: The elements that were removed from the queue or nil if no element satisfied the predicate.

     - Complexity: O(*n*), where *n* is the number elements in the queue with the specified priority.
     */
    public func removeItem(of priority: Priority, where predicate: (_ item: PriorityType) -> Bool) -> PriorityType? {
        switch priority {
        case .high:
            for (index, priorityType) in highPriorityCollection.enumerated() {
                if predicate(priorityType) {
                    return highPriorityCollection.remove(at: index)
                }
            }
        case .medium:
            for (index, priorityType) in defaultPriorityCollection.enumerated() {
                if predicate(priorityType) {
                    return defaultPriorityCollection.remove(at: index)
                }
            }
        case .low:
            for (index, priorityType) in lowPriorityCollection.enumerated() {
                if predicate(priorityType) {
                    return lowPriorityCollection.remove(at: index)
                }
            }
        }

        return nil
    }

    /**
     Removes the first item from the queue where the element satisfies the given predicate.

     The queue contains three collections which correspond to the three priority cases.
     This method will enumerate over all three collections to attempt to satisfy
     the predicate. If the priority is known, use `removeItem(of: where:)` which is
     more efficient.

     Use a predicate to remove an element of a type that doesn't conform to `Equatable` protocol
     or remove an element that satisfies a requirement.

         removeItem(where: { item in -> Bool
          return (item as? CustomObject).value == value
         })

     - Parameters:
        - where: A closure that takes an element as its argument and returns a Boolean value that indicates whether the passed element represents a match.
        - item: The element passed into the closure of type `PriorityType`

     - Returns: The element that was removed from the queue or nil if no element satisfied the predicate.

     - Complexity: O(*h*+*m*+*l*), where *h* is the length of the high priority collection,
     m is the length of the medium priority collection, and l is the length of the low
     priority collection

     - SeeAlso: `removeItem(of: where:)`
     */
    @discardableResult public func removeFirstItem(where completion: (PriorityType) -> Bool) -> PriorityType? {
        for (index, priorityType) in highPriorityCollection.enumerated() {
            if completion(priorityType) {
                return highPriorityCollection.remove(at: index)
            }
        }

        for (index, priorityType) in defaultPriorityCollection.enumerated() {
            if completion(priorityType) {
                return defaultPriorityCollection.remove(at: index)
            }
        }

        for (index, priorityType) in lowPriorityCollection.enumerated() {
            if completion(priorityType) {
                return lowPriorityCollection.remove(at: index)
            }
        }

        return nil
    }

    /**
     Removes the specified element from the queue.

     - Parameter object: The element to remove.
     - Returns: The element that was removed from the queue otherwise `nil` if the element was not found.
     */
    public func remove<T: PriorityType & Equatable>(object: T) -> T? {
        switch object.priority {
        case .high:
            let index = highPriorityCollection.index { ($0 as? T) == object }

            if let index = index {
                return highPriorityCollection.remove(at: index) as? T
            }
        case .medium:
            let index = defaultPriorityCollection.index { ($0 as? T) == object }

            if let index = index {
                return defaultPriorityCollection.remove(at: index) as? T
            }
        case .low:
            let index = lowPriorityCollection.index { ($0 as? T) == object }

            if let index = index {
                return lowPriorityCollection.remove(at: index) as? T
            }
        }

        return nil
    }

    /**
     Removes the element from the queue at the specified position of its corresponding collection based on its priority.

     - Parameters:
        - object: The index position of the element to remove. If the index is out of bounds or not a valid index 
     the object will not remove the element.
        - of: The priority of the element to remove
     - Returns: The element that was removed from the queue otherwise `nil` if the index was not valid or out of
     bounds.
     */
    @discardableResult public func removeItem(at index: Int, of priority: Priority) -> PriorityType? {
        switch priority {
        case .high:
            if highPriorityCollection.indices.contains(index) {
                return highPriorityCollection.remove(at: index)
            }
        case .medium:
            if defaultPriorityCollection.indices.contains(index) {
                return defaultPriorityCollection.remove(at: index)
            }
        case .low:
            if lowPriorityCollection.indices.contains(index) {
                return lowPriorityCollection.remove(at: index)
            }
        }

        return nil
    }

    /**
     Removes the element of the return type from the queue at the specified position of its corresponding collection based on its priority.
     
     - Note: The element will not be removed if the casting fails.
     
     - Parameters:
        - object: The index position of the element to remove. If the index is out of bounds or not a valid index
     the object will not remove the element.
        - of: The priority of the element to remove

     - Returns: The element that was removed from the queue otherwise `nil` if the object at the index was not
     of the return type or the index was not valid or out of bounds.
     */
    @discardableResult public func removeObject<T>(at index: Int, of priority: Priority) -> T? {
        switch priority {
        case .high:
            if highPriorityCollection.indices.contains(index) {
                if highPriorityCollection[index] is T {
                    return highPriorityCollection.remove(at: index) as? T
                }
            }
        case .medium:
            if defaultPriorityCollection.indices.contains(index) {
                if defaultPriorityCollection[index] is T {
                    return defaultPriorityCollection.remove(at: index) as? T
                }
            }
        case .low:
            if lowPriorityCollection.indices.contains(index) {
                if lowPriorityCollection[index] is T {
                    return lowPriorityCollection.remove(at: index) as? T
                }
            }
        }

        return nil
    }

    // MARK: - Utility

    private func insert(_ item: PriorityType, inCollection collection: inout [PriorityType], index: Int? = nil) {
        if var index = index, index < collection.endIndex {
            if index < collection.startIndex {
                index = collection.startIndex
            }
            collection.insert(item, at: index)
        } else {
            collection.append(item)
        }
    }
}

extension PriorityQueue: CustomStringConvertible {
    public var description: String {
        return "Queue with \(count) items"
    }
}

extension PriorityQueue: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "\(highPriorityCollection.count) high priority announcement(s), \(defaultPriorityCollection.count) default priority announcement(s), and \(lowPriorityCollection.count) low priority announcement(s) queued."
    }
}

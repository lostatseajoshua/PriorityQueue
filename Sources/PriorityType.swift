//
//  PriorityType.swift
//  PriorityQueue
//
//  Created by Joshua Alvarado on 7/9/17.
//  Copyright © 2017 Joshua Alvarado. All rights reserved.
//

/// A type that has an associated `Priority`.
public protocol PriorityType {
    var priority: Priority { get set }
}

/// Specifies a prority of rank.
public enum Priority: Int, Comparable {
    /// Least ranking priority
    case low
    /// Mid-ranking priority i.e. default
    case medium
    /// Highest ranking priority
    case high

    /// Returns a Boolean value indicating whether the value of the first
    /// argument is less than that of the second argument.
    ///
    /// This function is the only requirement of the `Comparable` protocol. The
    /// remainder of the relational operator functions are implemented by the
    /// standard library for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func <(lhs: Priority, rhs: Priority) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

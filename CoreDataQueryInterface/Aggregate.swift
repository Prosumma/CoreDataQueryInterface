//
//  Aggregate.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

/**
 Represents an aggregate whose `NSAttributeType` is the same
 as that of its argument.
 
 In other words, using `sum` with an `.integer32Attribute` argument
 produces an `.integer32Attribute` result and with a `.doubleAttribute`
 produces a `.doubleAttribute` result.
 
 Currently, the supported aggregates are `average`, `max`, `min`,
 and `sum`. The `count` aggregate is supported by the `Count`
 type.
 
 Since aggregates can be used in projections an `Aggregate<E>` must
 have a name. By default, this is the `cdqiName` of its argument
 appended with the function name in title case. For instance, if
 the argument's name is `age`, then a `sum` would have the name
 `ageSum`.
 
 Don't use this type directly. Instead, use the various methods
 and functions that return it, such as `sum` and `cdqiSum`.
 */
public struct Aggregate<E: Expression & Typed & TypeComparable>: Function {
    public typealias CDQIComparableType = E.CDQIComparableType
    
    public enum Function: String {
        case average
        case max
        case min
        case sum
    }
    
    public let cdqiAttributeType: NSAttributeType
    public let cdqiName: String
    public let cdqiExpression: NSExpression
    
    init(function: Function, argument: E) {
        cdqiAttributeType = argument.cdqiAttributeType
        cdqiExpression = NSExpression(forFunction: "\(function):", arguments: [argument.cdqiExpression])
        if let argument = argument as? Named {
            cdqiName = "\(argument.cdqiName)\(function.rawValue.titlecased())"
        } else {
            cdqiName = function.rawValue
        }
    }
}

/**
 Get the average of `argument`.
 
 For example, to `select` the average of employee salaries:
 
 ```
 Employee.cdqiQuery.select(average(Employee.e.salary))
 ```
 
 - parameter argument: The expression whose average to get.
 - returns: An aggregate expression producing an average.
 */
public func average<E: Expression & Typed & TypeComparable>(_ argument: E) -> Aggregate<E> {
    return Aggregate(function: .average, argument: argument)
}

/**
 Get the maximum of `argument`.
 
 For example, to `select` the maximum employee salary:
 
 ```
 Employee.cdqiQuery.select(max(Employee.e.salary))
 ```
 
 - parameter argument: The expression whose maximum to get.
 - returns: An aggregate expression producing a maximum.
 */
public func max<E: Expression & Typed & TypeComparable>(_ argument: E) -> Aggregate<E> {
    return Aggregate(function: .max, argument: argument)
}

/**
 Get the minimum of `argument`.
 
 For example, to `select` the minimum employee salary:
 
 ```
 Employee.cdqiQuery.select(min(Employee.e.salary))
 ```
 
 - parameter argument: The expression whose minimum to get.
 - returns: An aggregate expression producing a minimum.
 */
public func min<E: Expression & Typed & TypeComparable>(_ argument: E) -> Aggregate<E> {
    return Aggregate(function: .min, argument: argument)
}

/**
 Get the sum of `argument`.
 
 For example, to `select` the sum of employee salaries:
 
 ```
 Employee.cdqiQuery.select(sum(Employee.e.salary))
 ```
 
 - parameter argument: The expression whose sum to calculate.
 - returns: An expression producing a sum.
 */
public func sum<E: Expression & Typed & TypeComparable>(_ argument: E) -> Aggregate<E> {
    return Aggregate(function: .sum, argument: argument)
}

public extension Expression where Self: Typed & TypeComparable {
    
    /**
     Get the average of the receiver.
     
     For example, to `select` the average of employee salaries:
     
     ```
     Employee.cdqiQuery.select(average(Employee.e.salary.cdqiAverage))
     ```
     */
    var cdqiAverage: Aggregate<Self> {
        return average(self)
    }
    
    /**
     Get the maximum of the receiver.
     
     For example, to `select` the maximum employee salary:
     
     ```
     Employee.cdqiQuery.select(Employee.e.salary.cdqiMax))
     ```
     */
    var cdqiMax: Aggregate<Self> {
        return max(self)
    }
    
    /**
     Get the minimum of the receiver.
     
     For example, to `select` the minimum employee salary:
     
     ```
     Employee.cdqiQuery.select(Employee.e.salary.cdqiMin)
     ```
     */
    var cdqiMin: Aggregate<Self> {
        return min(self)
    }
 
    /**
     Get the sum of the receiver.
     
     For example, to `select` the sum of employee salaries:
     
     ```
     Employee.cdqiQuery.select(Employee.e.salary.cdqiSum)
     ```
     */
    var cdqiSum: Aggregate<Self> {
        return sum(self)
    }
}

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
 
 While this type can be used directly, there are many convenient
 methods and functions instead, such as `sum` and `cdqiSum`.
 */
public struct Aggregate<E: Expression & Typed & TypeComparable>: Function {
    public typealias CDQIComparableType = E.CDQIComparableType
    
    public enum Function: String {
        case average
        case max
        case min
        case sum
    }
    
    public let cdqiType: NSAttributeType
    public let cdqiName: String
    public let cdqiExpression: NSExpression
    
    init(function: Function, argument: E) {
        cdqiType = argument.cdqiType
        cdqiExpression = NSExpression(forFunction: "\(function):", arguments: [argument.cdqiExpression])
        if let argument = argument as? Named {
            cdqiName = "\(argument.cdqiName)\(function.rawValue.titlecased())"
        } else {
            cdqiName = function.rawValue.titlecased()
        }
    }
}

public func average<E: Expression & Typed & TypeComparable>(_ argument: E) -> Aggregate<E> {
    return Aggregate(function: .average, argument: argument)
}

public func max<E: Expression & Typed & TypeComparable>(_ argument: E) -> Aggregate<E> {
    return Aggregate(function: .max, argument: argument)
}

public func min<E: Expression & Typed & TypeComparable>(_ argument: E) -> Aggregate<E> {
    return Aggregate(function: .min, argument: argument)
}

public func sum<E: Expression & Typed & TypeComparable>(_ argument: E) -> Aggregate<E> {
    return Aggregate(function: .sum, argument: argument)
}

public extension Expression where Self: Typed & TypeComparable {
    
    var cdqiAverage: Aggregate<Self> {
        return Aggregate(function: .average, argument: self)
    }
    
    var cdqiMax: Aggregate<Self> {
        return Aggregate(function: .max, argument: self)
    }
    
    var cdqiMin: Aggregate<Self> {
        return Aggregate(function: .min, argument: self)
    }
 
    var cdqiSum: Aggregate<Self> {
        return Aggregate(function: .sum, argument: self)
    }
}

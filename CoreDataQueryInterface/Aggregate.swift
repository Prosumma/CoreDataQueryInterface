//
//  Aggregate.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public struct Aggregate<E: Property & TypeComparable>: Function {
    public typealias CDQIComparableType = E.CDQIComparableType
    
    public enum Function: String {
        case average
        case max
        case min
    }
    
    public let cdqiType: NSAttributeType
    public let cdqiName: String
    public let cdqiExpression: NSExpression
    
    init(function: Function, argument: E) {
        cdqiType = argument.cdqiType
        cdqiExpression = NSExpression(forFunction: "\(function):", arguments: [argument.cdqiExpression])
        cdqiName = "\(argument.cdqiName)\(function.rawValue.titlecased())"
    }
}

public func average<E: Property & TypeComparable>(_ argument: E) -> Aggregate<E> {
    return Aggregate(function: .average, argument: argument)
}

public func max<E: Property & TypeComparable>(_ argument: E) -> Aggregate<E> {
    return Aggregate(function: .max, argument: argument)
}

public func min<E: Property & TypeComparable>(_ argument: E) -> Aggregate<E> {
    return Aggregate(function: .min, argument: argument)
}

extension Expression where Self: Typed & Named & TypeComparable {
    
    var cdqiAverage: Aggregate<Self> {
        return Aggregate(function: .average, argument: self)
    }
    
    var cdqiMax: Aggregate<Self> {
        return Aggregate(function: .max, argument: self)
    }
    
    var cdqiMin: Aggregate<Self> {
        return Aggregate(function: .min, argument: self)
    }
    
}

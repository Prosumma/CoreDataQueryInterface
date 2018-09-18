//
//  InconstantExpression.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

/**
 A type that turns a `TypeComparable` expression into an `Inconstant`, so that it can
 be used in filter expressions. See the documentation for `Inconstant` for more information.
 
 Use the `inconstant` function or `cdqiInconstant` property to create an `InconstantExpression`.
 */
public struct InconstantExpression<E: Expression & TypeComparable>: Expression, Inconstant, TypeComparable {
    public typealias CDQIComparableType = E.CDQIComparableType
    
    public let cdqiExpression: NSExpression
    
    init(_ constant: E) {
        cdqiExpression = constant.cdqiExpression
    }
}

/**
 A function that turns its argument into an `Inconstant`, so that it can be used in filter
 expressions. See the documentation for `Inconstant` for more information.
 
 ```
 query.filter(inconstant(0) == 0)
 ```
 */
public func inconstant<E: Expression & TypeComparable>(_ expression: E) -> InconstantExpression<E> {
    return InconstantExpression(expression)
}

/**
 A property that turns its receiver into an `Inconstant`, so that it can be used in filter
 expressions. See the documentation for `Inconstant` for more information.
 
 ```
 query.filter(0.cdqiInconstant == 0)
 ```
 */
public extension Expression where Self: TypeComparable {
    var cdqiInconstant: InconstantExpression<Self> {
        return inconstant(self)
    }
}


//
//  AdaptedScalar.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

/**
 This protocol allows custom types to participate in CDQI comparisons.
 
 ```
 enum Size: String, AdaptedScalar {
    case small
    case medium
    case large
 
    typealias CDQIComparableType = String
 
    var cdqiType: NSAttributeType {
        return .stringAttributeType
    }
 
    var cdqiExpression: NSExpression {
        return NSExpression(forConstantValue: rawValue)
    }
 }
 ```
 
 Given the definition above, the `Size` type can now be
 compared directly to strings in CDQI filters:
 
 ```
 managedObjectContext
    .from(Merchandise.self)
    .filter(Merchandise.e.size == Size.large)
 ```
 
 You can of course just make your type conform to `Type`,
 `TypeComparable` and `Expression` separately. This is just a
 convenience.
 */
public protocol AdaptedScalar: Typed, TypeComparable, Expression {}


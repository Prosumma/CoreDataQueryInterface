//
//  AttributedType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public protocol AttributeType: CustomStringConvertible, OrderType, ExpressionType {
    init(_ name: String?, parent: AttributeType?)
}

extension AttributeType {
    public func toPropertyDescription(entityDescription: NSEntityDescription) -> NSPropertyDescription {
        return String(self).toPropertyDescription(entityDescription)
    }
    public func toExpression(entityDescription: NSEntityDescription) -> NSExpression {
        return String(self).toExpression(entityDescription)
    }
}

public func predicate<A: AttributeType, T: CVarArgType>(lhs: A, _ op: String, _ formatSpecifier: String, _ rhs: T?) -> NSPredicate {
    let key = lhs.description
    if let rhs = rhs where !key.isEmpty {
        return NSPredicate(format: "%K \(op) \(formatSpecifier)", lhs.description, rhs)
    } else if let rhs = rhs where key.isEmpty {
        return NSPredicate(format: "SELF \(op) \(formatSpecifier)", rhs)
    } else if !key.isEmpty {
        return NSPredicate(format: "%K \(op) NIL", lhs.description)
    } else {
        return NSPredicate(format: "SELF \(op) NIL")
    }
}

// NSObject

public func ==<A: AttributeType>(lhs: A, rhs: NSObject?) -> NSPredicate {
    return predicate(lhs, "==", "%@", rhs)
}

// [NSObject]

public func ==<A: AttributeType>(lhs: A, rhs: [NSObject]) -> NSPredicate {
    return predicate(lhs, "IN", "%@", rhs as NSArray)
}

public func !=<A: AttributeType>(lhs: A, rhs: [NSObject]) -> NSPredicate {
    return NSCompoundPredicate.notPredicateWithSubpredicate(lhs == rhs)
}

// String

public func ==<A: AttributeType>(lhs: A, rhs: String) -> NSPredicate {
    return predicate(lhs, "==", "%@", rhs as NSString)
}

// [String]

public func ==<A: AttributeType>(lhs: A, rhs: [String]) -> NSPredicate {
    return NSCompoundPredicate.notPredicateWithSubpredicate(lhs == rhs)
}


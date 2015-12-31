//
//  Attribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/3/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import Foundation
import CoreData

/**
 The base class for attributes.
 - note: Don't use this class directly. Create or use one of its subclasses, such as `KeyAttribute`.
*/
public class Attribute: CustomStringConvertible, CustomExpressionConvertible {
    private let _name: String?
    private let _parent: Attribute?
    public required init() {
        _name = nil
        _parent = nil
    }
    public required init(_ name: String, parent: Attribute? = nil) {
        _name = name
        _parent = parent
    }
    public private(set) lazy var description: String = {
        if let parent = self._parent {
            let parentName = String(parent)
            let prefix = parentName.isEmpty ? "" : (parentName + ".")
            return prefix + self._name!
        } else {
            return self._name ?? ""
        }
    }()
    public private(set) lazy var expression: NSExpression = {
        let keyPath = String(self)
        if keyPath.hasPrefix("$") {
            return NSExpression(forVariable: keyPath.substringFromIndex(keyPath.startIndex.successor()))
        } else if keyPath == "" {
            return NSExpression(format: "SELF")
        } else {
            return NSExpression(forKeyPath: keyPath)
        }
    }()
    public func named(name: String, type: NSAttributeType = .UndefinedAttributeType) -> NSExpressionDescription {
        let e = NSExpressionDescription()
        e.expression = expression
        e.name = name
        e.expressionResultType = type
        return e
    }
}

extension Aggregable where Self: Attribute {
    public func subquery(variable: String, predicate: AggregateType -> NSPredicate) -> NSExpression {
        let collection = AggregateType(_name!) // Can't do a subquery unless _name is not nil.
        let iteratorVariable = AggregateType(variable)
        return NSExpression(forSubquery: collection.expression, usingIteratorVariable: iteratorVariable.expression.variable, predicate: predicate(iteratorVariable))
    }
    public func subquery(predicate: AggregateType -> NSPredicate) -> NSExpression {
        var identifier = NSProcessInfo().globallyUniqueString.stringByReplacingOccurrencesOfString("-", withString: "")
        identifier = identifier.substringToIndex(identifier.startIndex.advancedBy(10)).lowercaseString
        let variable = "$v\(identifier)"
        return subquery(variable, predicate: predicate)
    }
    public var count: NSExpression {
        return NSExpression(format: "%@.@count", expression)
    }
    public var average: AggregateType {
        return AggregateType("@avg", parent: self)
    }
    public var sum: AggregateType {
        return AggregateType("@sum", parent: self)
    }
    public var max: AggregateType {
        return AggregateType("@max", parent: self)
    }
    public var min: AggregateType {
        return AggregateType("@min", parent: self)
    }
}

extension Attribute: CustomPropertyConvertible {
    public var property: AnyObject {
        return String(self)
    }
}

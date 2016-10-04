//
//  Protocols.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 9/25/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public protocol Entity {
    associatedtype CDQIAttribute: EntityAttribute
}

public protocol Typed {
    static var cdqiStaticType: NSAttributeType { get }
    var cdqiType: NSAttributeType { get }
}

extension Typed {
    public static var cdqiStaticType: NSAttributeType {
        return .undefinedAttributeType
    }
    public var cdqiType: NSAttributeType {
        return type(of: self).cdqiStaticType
    }
}

public protocol ExpressionConvertible {
    var cdqiExpression: NSExpression { get }
}

extension NSExpression: ExpressionConvertible {
    public var cdqiExpression: NSExpression {
        return self
    }
}

extension NSManagedObject: ExpressionConvertible {
    public var cdqiExpression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}

extension NSManagedObjectID: ExpressionConvertible {
    public var cdqiExpression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}

public protocol TypedExpressionConvertible: ExpressionConvertible, Typed {
    associatedtype CDQIComparisonType: Typed
}

public protocol PredicateComparableTypedExpressionConvertible: TypedExpressionConvertible {
}

public protocol TypedConstantExpressionConvertible: TypedExpressionConvertible {
}

extension TypedConstantExpressionConvertible {
    public var cdqiExpression: NSExpression {
        return NSExpression(forConstantValue: (self as AnyObject))
    }
}

public protocol PropertyConvertible {
    var cdqiProperty: Any { get }
}

extension NSPropertyDescription: PropertyConvertible {
    public var cdqiProperty: Any {
        return self
    }
}

extension String: PropertyConvertible {
    public var cdqiProperty: Any {
        return self
    }
}

public protocol SortDescriptorConvertible {
    func cdqiSortDescriptor(ascending: Bool) -> NSSortDescriptor
}

extension String: SortDescriptorConvertible {
    public func cdqiSortDescriptor(ascending: Bool) -> NSSortDescriptor {
        return NSSortDescriptor(key: self, ascending: ascending)
    }
}

extension NSSortDescriptor: SortDescriptorConvertible {
    public func cdqiSortDescriptor(ascending: Bool) -> NSSortDescriptor {
        return self
    }
}

public protocol KeyPathExpressionConvertible: ExpressionConvertible, PropertyConvertible, SortDescriptorConvertible {
    var cdqiKey: String? { get }
    var cdqiParent: KeyPathExpressionConvertible? { get }
}

extension KeyPathExpressionConvertible {
    private var cdqiRawKeyPath: String? {
        if cdqiKey == nil && cdqiParent == nil {
            return nil
        }
        guard let key = cdqiKey else {
            assertionFailure("Can't build cdqiKeyPath: Missing cdqiKey in KeyPathExpressionConvertible.")
            return nil
        }
        if let parentKeyPath = cdqiParent?.cdqiRawKeyPath {
            return "\(parentKeyPath).\(key)"
        }
        return key
    }
    
    public var cdqiKeyPath: String {
        if let keyPath = cdqiRawKeyPath {
            return keyPath
        }
        return "SELF"
    }
    
    private var cdqiRawName: String? {
        if cdqiKey == nil && cdqiParent == nil {
            return nil
        }
        guard let key = cdqiKey else {
            assertionFailure("Can't build cdqiName: Missing cdqiKey in KeyPathExpressionConvertible.")
            return nil
        }
        if let parentName = cdqiParent?.cdqiRawName {
            let index = key.index(key.startIndex, offsetBy: 1)
            let start = key.substring(to: index)
            let remainder = key.substring(from: index)
            let name = "\(start.uppercased())\(remainder)"
            return "\(parentName)\(name)"
        }
        return key
    }
    
    public var cdqiName: String {
        return cdqiRawName!
    }
    
    public var cdqiExpression: NSExpression {
        if let key = cdqiKey, key.hasPrefix("$") {
            return NSExpression(forVariable: key.substring(from: key.index(key.startIndex, offsetBy: 1)))
        } else if cdqiKeyPath == "SELF" {
            return NSExpression(format: "SELF")
        }
        return NSExpression(forKeyPath: cdqiKeyPath)
    }
    
    public var cdqiProperty: Any {
        let property = NSExpressionDescription()
        property.expression = cdqiExpression
        property.name = cdqiName
        if let typed = self as? Typed {
            property.expressionResultType = typed.cdqiType
        }
        return property
    }
    
    public func cdqiSortDescriptor(ascending: Bool) -> NSSortDescriptor {
        return NSSortDescriptor(key: cdqiKeyPath, ascending: ascending)
    }
}

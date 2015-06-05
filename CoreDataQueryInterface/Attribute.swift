//
//  Attribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/3/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import Foundation

public protocol AttributeType : Printable {
    init(_ name: String?, parent: AttributeType?)
}

public class Attribute : AttributeType {
    
    private let _name: String?
    private let _parent: AttributeType?

    public required init(_ name: String? = nil, parent: AttributeType? = nil) {
        _name = name
        _parent = parent
    }
    
    public var description: String {
        if let parent = _parent {
            return (parent.description == "" ? "" : ".") + _name!
        } else {
            return _name ?? ""
        }
    }
    
}

public func &&(lhs: NSPredicate, rhs: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate.andPredicateWithSubpredicates([lhs, rhs])
}

public func ||(lhs: NSPredicate, rhs: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate.orPredicateWithSubpredicates([lhs, rhs])
}

public prefix func !(predicate: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate.notPredicateWithSubpredicate(predicate)
}

public func predicate<A: AttributeType, T>(lhs: A, op: String, rhs: T?, convert: T -> NSObject) -> NSPredicate {
    if let rhs = rhs {
        return NSPredicate(format: "%K \(op) %@", lhs.description, convert(rhs))
    } else {
        return NSPredicate(format: "%K \(op) NIL", lhs.description)
    }
}

public func predicate<A: AttributeType, B: AttributeType>(lhs: A, op: String, rhs: B) -> NSPredicate {
    return NSPredicate(format: "%K \(op) %K", lhs.description, rhs.description)
}

/* == */

public func ==<A: AttributeType>(lhs: A, rhs: NSObject?) -> NSPredicate {
    return predicate(lhs, "==", rhs) {$0}
}

public func ==<A: AttributeType>(lhs: A, rhs: String?) -> NSPredicate {
    return predicate(lhs, "==", rhs) {$0 as NSString}
}

public func ==<A: AttributeType>(lhs: A, rhs: UInt8?) -> NSPredicate {
    return predicate(lhs, "==", rhs) {NSNumber(unsignedChar: $0)}
}

public func ==<A: AttributeType>(lhs: A, rhs: UInt16?) -> NSPredicate {
    return predicate(lhs, "==", rhs) {NSNumber(unsignedShort: $0)}
}

public func ==<A: AttributeType>(lhs: A, rhs: Int16?) -> NSPredicate {
    return predicate(lhs, "==", rhs) {NSNumber(short: $0)}
}

public func ==<A: AttributeType>(lhs: A, rhs: UInt32?) -> NSPredicate {
    return predicate(lhs, "==", rhs) {NSNumber(unsignedInt: $0)}
}

public func ==<A: AttributeType>(lhs: A, rhs: Int32?) -> NSPredicate {
    return predicate(lhs, "==", rhs) {NSNumber(int: $0)}
}

public func ==<A: AttributeType>(lhs: A, rhs: UInt64?) -> NSPredicate {
    return predicate(lhs, "==", rhs) {NSNumber(unsignedLongLong: $0)}
}

public func ==<A: AttributeType>(lhs: A, rhs: Int64?) -> NSPredicate {
    return predicate(lhs, "==", rhs) {NSNumber(longLong: $0)}
}

public func ==<A: AttributeType>(lhs: A, rhs: Int?) -> NSPredicate {
    return predicate(lhs, "==", rhs) {NSNumber(integer: $0)}
}

public func ==<A: AttributeType>(lhs: A, rhs: Float?) -> NSPredicate {
    return predicate(lhs, "==", rhs) {NSNumber(float: $0)}
}

public func ==<A: AttributeType>(lhs: A, rhs: Double?) -> NSPredicate {
    return predicate(lhs, "==", rhs) {NSNumber(double: $0)}
}

public func ==<A: AttributeType>(lhs: A, rhs: BooleanType?) -> NSPredicate {
    if let rhs = rhs {
        let constant = rhs ? "YES" : "NO"
        return NSPredicate(format: "%K == \(constant)", lhs.description)
    } else {
        return NSPredicate(format: "%K == NIL", lhs.description)
    }
}

/* != */

public func !=<A: AttributeType>(lhs: A, rhs: NSObject?) -> NSPredicate {
    return predicate(lhs, "!=", rhs) {$0}
}

public func !=<A: AttributeType>(lhs: A, rhs: String?) -> NSPredicate {
    return predicate(lhs, "!=", rhs) {$0 as NSString}
}

public func !=<A: AttributeType>(lhs: A, rhs: UInt8?) -> NSPredicate {
    return predicate(lhs, "!=", rhs) {NSNumber(unsignedChar: $0)}
}

public func !=<A: AttributeType>(lhs: A, rhs: UInt16?) -> NSPredicate {
    return predicate(lhs, "!=", rhs) {NSNumber(unsignedShort: $0)}
}

public func !=<A: AttributeType>(lhs: A, rhs: Int16?) -> NSPredicate {
    return predicate(lhs, "!=", rhs) {NSNumber(short: $0)}
}

public func !=<A: AttributeType>(lhs: A, rhs: UInt32?) -> NSPredicate {
    return predicate(lhs, "!=", rhs) {NSNumber(unsignedInt: $0)}
}

public func !=<A: AttributeType>(lhs: A, rhs: Int32?) -> NSPredicate {
    return predicate(lhs, "!=", rhs) {NSNumber(int: $0)}
}

public func !=<A: AttributeType>(lhs: A, rhs: UInt64?) -> NSPredicate {
    return predicate(lhs, "!=", rhs) {NSNumber(unsignedLongLong: $0)}
}

public func !=<A: AttributeType>(lhs: A, rhs: Int64?) -> NSPredicate {
    return predicate(lhs, "!=", rhs) {NSNumber(longLong: $0)}
}

public func !=<A: AttributeType>(lhs: A, rhs: Int?) -> NSPredicate {
    return predicate(lhs, "!=", rhs) {NSNumber(integer: $0)}
}

public func !=<A: AttributeType>(lhs: A, rhs: Float?) -> NSPredicate {
    return predicate(lhs, "!=", rhs) {NSNumber(float: $0)}
}

public func !=<A: AttributeType>(lhs: A, rhs: Double?) -> NSPredicate {
    return predicate(lhs, "!=", rhs) {NSNumber(double: $0)}
}

public func !=<A: AttributeType>(lhs: A, rhs: BooleanType?) -> NSPredicate {
    if let rhs = rhs {
        let constant = rhs ? "YES" : "NO"
        return NSPredicate(format: "%K != \(constant)", lhs.description)
    } else {
        return NSPredicate(format: "%K != NIL", lhs.description)
    }
}

/* > */

public func ><A: AttributeType>(lhs: A, rhs: NSObject?) -> NSPredicate {
    return predicate(lhs, ">", rhs) {$0}
}

public func ><A: AttributeType>(lhs: A, rhs: String?) -> NSPredicate {
    return predicate(lhs, ">", rhs) {$0 as NSString}
}

public func ><A: AttributeType>(lhs: A, rhs: UInt8?) -> NSPredicate {
    return predicate(lhs, ">", rhs) {NSNumber(unsignedChar: $0)}
}

public func ><A: AttributeType>(lhs: A, rhs: UInt16?) -> NSPredicate {
    return predicate(lhs, ">", rhs) {NSNumber(unsignedShort: $0)}
}

public func ><A: AttributeType>(lhs: A, rhs: Int16?) -> NSPredicate {
    return predicate(lhs, ">", rhs) {NSNumber(short: $0)}
}

public func ><A: AttributeType>(lhs: A, rhs: UInt32?) -> NSPredicate {
    return predicate(lhs, ">", rhs) {NSNumber(unsignedInt: $0)}
}

public func ><A: AttributeType>(lhs: A, rhs: Int32?) -> NSPredicate {
    return predicate(lhs, ">", rhs) {NSNumber(int: $0)}
}

public func ><A: AttributeType>(lhs: A, rhs: UInt64?) -> NSPredicate {
    return predicate(lhs, ">", rhs) {NSNumber(unsignedLongLong: $0)}
}

public func ><A: AttributeType>(lhs: A, rhs: Int64?) -> NSPredicate {
    return predicate(lhs, ">", rhs) {NSNumber(longLong: $0)}
}

public func ><A: AttributeType>(lhs: A, rhs: Int?) -> NSPredicate {
    return predicate(lhs, ">", rhs) {NSNumber(integer: $0)}
}

public func ><A: AttributeType>(lhs: A, rhs: Float?) -> NSPredicate {
    return predicate(lhs, ">", rhs) {NSNumber(float: $0)}
}

public func ><A: AttributeType>(lhs: A, rhs: Double?) -> NSPredicate {
    return predicate(lhs, ">", rhs) {NSNumber(double: $0)}
}

/* >= */

public func >=<A: AttributeType>(lhs: A, rhs: NSObject?) -> NSPredicate {
    return predicate(lhs, ">=", rhs) {$0}
}

public func >=<A: AttributeType>(lhs: A, rhs: String?) -> NSPredicate {
    return predicate(lhs, ">=", rhs) {$0 as NSString}
}

public func >=<A: AttributeType>(lhs: A, rhs: UInt8?) -> NSPredicate {
    return predicate(lhs, ">=", rhs) {NSNumber(unsignedChar: $0)}
}

public func >=<A: AttributeType>(lhs: A, rhs: UInt16?) -> NSPredicate {
    return predicate(lhs, ">=", rhs) {NSNumber(unsignedShort: $0)}
}

public func >=<A: AttributeType>(lhs: A, rhs: Int16?) -> NSPredicate {
    return predicate(lhs, ">=", rhs) {NSNumber(short: $0)}
}

public func >=<A: AttributeType>(lhs: A, rhs: UInt32?) -> NSPredicate {
    return predicate(lhs, ">=", rhs) {NSNumber(unsignedInt: $0)}
}

public func >=<A: AttributeType>(lhs: A, rhs: Int32?) -> NSPredicate {
    return predicate(lhs, ">=", rhs) {NSNumber(int: $0)}
}

public func >=<A: AttributeType>(lhs: A, rhs: UInt64?) -> NSPredicate {
    return predicate(lhs, ">=", rhs) {NSNumber(unsignedLongLong: $0)}
}

public func >=<A: AttributeType>(lhs: A, rhs: Int64?) -> NSPredicate {
    return predicate(lhs, ">=", rhs) {NSNumber(longLong: $0)}
}

public func >=<A: AttributeType>(lhs: A, rhs: Int?) -> NSPredicate {
    return predicate(lhs, ">=", rhs) {NSNumber(integer: $0)}
}

public func >=<A: AttributeType>(lhs: A, rhs: Float?) -> NSPredicate {
    return predicate(lhs, ">=", rhs) {NSNumber(float: $0)}
}

public func >=<A: AttributeType>(lhs: A, rhs: Double?) -> NSPredicate {
    return predicate(lhs, ">=", rhs) {NSNumber(double: $0)}
}

/* < */

public func <<A: AttributeType>(lhs: A, rhs: NSObject?) -> NSPredicate {
    return predicate(lhs, "<", rhs) {$0}
}

public func <<A: AttributeType>(lhs: A, rhs: String?) -> NSPredicate {
    return predicate(lhs, "<", rhs) {$0 as NSString}
}

public func <<A: AttributeType>(lhs: A, rhs: UInt8?) -> NSPredicate {
    return predicate(lhs, "<", rhs) {NSNumber(unsignedChar: $0)}
}

public func <<A: AttributeType>(lhs: A, rhs: UInt16?) -> NSPredicate {
    return predicate(lhs, "<", rhs) {NSNumber(unsignedShort: $0)}
}

public func <<A: AttributeType>(lhs: A, rhs: Int16?) -> NSPredicate {
    return predicate(lhs, "<", rhs) {NSNumber(short: $0)}
}

public func <<A: AttributeType>(lhs: A, rhs: UInt32?) -> NSPredicate {
    return predicate(lhs, "<", rhs) {NSNumber(unsignedInt: $0)}
}

public func <<A: AttributeType>(lhs: A, rhs: Int32?) -> NSPredicate {
    return predicate(lhs, "<", rhs) {NSNumber(int: $0)}
}

public func <<A: AttributeType>(lhs: A, rhs: UInt64?) -> NSPredicate {
    return predicate(lhs, "<", rhs) {NSNumber(unsignedLongLong: $0)}
}

public func <<A: AttributeType>(lhs: A, rhs: Int64?) -> NSPredicate {
    return predicate(lhs, "<", rhs) {NSNumber(longLong: $0)}
}

public func <<A: AttributeType>(lhs: A, rhs: Int?) -> NSPredicate {
    return predicate(lhs, "<", rhs) {NSNumber(integer: $0)}
}

public func <<A: AttributeType>(lhs: A, rhs: Float?) -> NSPredicate {
    return predicate(lhs, "<", rhs) {NSNumber(float: $0)}
}

public func <<A: AttributeType>(lhs: A, rhs: Double?) -> NSPredicate {
    return predicate(lhs, "<", rhs) {NSNumber(double: $0)}
}

/* <= */

public func <=<A: AttributeType>(lhs: A, rhs: NSObject?) -> NSPredicate {
    return predicate(lhs, "<=", rhs) {$0}
}

public func <=<A: AttributeType>(lhs: A, rhs: String?) -> NSPredicate {
    return predicate(lhs, "<=", rhs) {$0 as NSString}
}

public func <=<A: AttributeType>(lhs: A, rhs: UInt8?) -> NSPredicate {
    return predicate(lhs, "<=", rhs) {NSNumber(unsignedChar: $0)}
}

public func <=<A: AttributeType>(lhs: A, rhs: UInt16?) -> NSPredicate {
    return predicate(lhs, "<=", rhs) {NSNumber(unsignedShort: $0)}
}

public func <=<A: AttributeType>(lhs: A, rhs: Int16?) -> NSPredicate {
    return predicate(lhs, "<=", rhs) {NSNumber(short: $0)}
}

public func <=<A: AttributeType>(lhs: A, rhs: UInt32?) -> NSPredicate {
    return predicate(lhs, "<=", rhs) {NSNumber(unsignedInt: $0)}
}

public func <=<A: AttributeType>(lhs: A, rhs: Int32?) -> NSPredicate {
    return predicate(lhs, "<=", rhs) {NSNumber(int: $0)}
}

public func <=<A: AttributeType>(lhs: A, rhs: UInt64?) -> NSPredicate {
    return predicate(lhs, "<=", rhs) {NSNumber(unsignedLongLong: $0)}
}

public func <=<A: AttributeType>(lhs: A, rhs: Int64?) -> NSPredicate {
    return predicate(lhs, "<=", rhs) {NSNumber(longLong: $0)}
}

public func <=<A: AttributeType>(lhs: A, rhs: Int?) -> NSPredicate {
    return predicate(lhs, "<=", rhs) {NSNumber(integer: $0)}
}

public func <=<A: AttributeType>(lhs: A, rhs: Float?) -> NSPredicate {
    return predicate(lhs, "<=", rhs) {NSNumber(float: $0)}
}

public func <=<A: AttributeType>(lhs: A, rhs: Double?) -> NSPredicate {
    return predicate(lhs, "<=", rhs) {NSNumber(double: $0)}
}

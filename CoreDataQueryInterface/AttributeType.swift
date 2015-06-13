//
//  AttributedType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

public protocol AttributeType: CustomStringConvertible {
    init(_ name: String?, parent: AttributeType?)
}

public func predicate<A: AttributeType, T>(lhs: A, _ op: String, _ rhs: T?, _ convert: T -> NSObject) -> NSPredicate {
    let key = String(lhs)
    if let rhs = rhs where !key.isEmpty {
        return NSPredicate(format: "%K \(op) %@", String(lhs), convert(rhs))
    } else if let rhs = rhs where key.isEmpty {
        return NSPredicate(format: "SELF \(op) %@", convert(rhs))
    } else if !key.isEmpty {
        return NSPredicate(format: "%K \(op) NIL", String(lhs))
    } else {
        return NSPredicate(format: "SELF \(op) NIL")
    }
}

public func predicate<A: AttributeType, B: AttributeType>(lhs: A, _ op: String, _ rhs: B) -> NSPredicate {
    return NSPredicate(format: "%K \(op) %K", String(lhs), String(rhs))
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
        return NSPredicate(format: "%K == \(constant)", String(lhs))
    } else {
        return NSPredicate(format: "%K == NIL", String(lhs))
    }
}

public func ==<A: AttributeType>(lhs: A, rhs: [AnyObject]) -> NSPredicate {
    let key = String(lhs)
    if !key.isEmpty {
        return NSPredicate(format: "%K IN %@", String(lhs), rhs)
    } else {
        return NSPredicate(format: "SELF IN %@", rhs)
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
        return NSPredicate(format: "%K != \(constant)", String(lhs))
    } else {
        return NSPredicate(format: "%K != NIL", String(lhs))
    }
}

public func !=<A: AttributeType>(lhs: A, rhs: [AnyObject]) -> NSPredicate {
    return !(lhs == rhs)
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

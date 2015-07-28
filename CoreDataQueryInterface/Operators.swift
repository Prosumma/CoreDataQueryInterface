//
//  Operators.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/20/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

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

public func !=<A: AttributeType>(lhs: A, rhs: NSObject?) -> NSPredicate {
    return predicate(lhs, "!=", "%@", rhs)
}

public func ><A: AttributeType>(lhs: A, rhs: NSObject) -> NSPredicate {
    return predicate(lhs, ">", "%@", rhs)
}

public func >=<A: AttributeType>(lhs: A, rhs: NSObject) -> NSPredicate {
    return predicate(lhs, ">=", "%@", rhs)
}

public func <<A: AttributeType>(lhs: A, rhs: NSObject) -> NSPredicate {
    return predicate(lhs, "<", "%@", rhs)
}

public func <=<A: AttributeType>(lhs: A, rhs: NSObject) -> NSPredicate {
    return predicate(lhs, "<=", "%@", rhs)
}

// [NSObject]

public func ==<A: AttributeType>(lhs: A, rhs: [NSObject]) -> NSPredicate {
    return predicate(lhs, "IN", "%@", rhs as NSArray)
}

public func !=<A: AttributeType>(lhs: A, rhs: [NSObject]) -> NSPredicate {
    return NSCompoundPredicate(notPredicateWithSubpredicate: lhs == rhs)
}

// String

public func ==<A: AttributeType>(lhs: A, rhs: String) -> NSPredicate {
    return predicate(lhs, "==", "%@", rhs as NSString)
}

public func !=<A: AttributeType>(lhs: A, rhs: String) -> NSPredicate {
    return predicate(lhs, "!=", "%@", rhs as NSString)
}

public func ><A: AttributeType>(lhs: A, rhs: String) -> NSPredicate {
    return predicate(lhs, ">", "%@", rhs as NSString)
}

public func >=<A: AttributeType>(lhs: A, rhs: String) -> NSPredicate {
    return predicate(lhs, ">=", "%@", rhs as NSString)
}

public func <<A: AttributeType>(lhs: A, rhs: String) -> NSPredicate {
    return predicate(lhs, "<", "%@", rhs as NSString)
}

public func <=<A: AttributeType>(lhs: A, rhs: String) -> NSPredicate {
    return predicate(lhs, "<=", "%@", rhs as NSString)
}

// [String]

public func ==<A: AttributeType>(lhs: A, rhs: [String]) -> NSPredicate {
    return predicate(lhs, "IN", "%@", rhs as NSArray)
}

public func !=<A: AttributeType>(lhs: A, rhs: [String]) -> NSPredicate {
    return NSCompoundPredicate(notPredicateWithSubpredicate: lhs == rhs)
}

// Int

public func ==<A: AttributeType>(lhs: A, rhs: Int) -> NSPredicate {
    return lhs == NSNumber(integer: rhs)
}

public func !=<A: AttributeType>(lhs: A, rhs: Int) -> NSPredicate {
    return lhs != NSNumber(integer: rhs)
}

public func ><A: AttributeType>(lhs: A, rhs: Int) -> NSPredicate {
    return lhs > NSNumber(integer: rhs)
}

public func >=<A: AttributeType>(lhs: A, rhs: Int) -> NSPredicate {
    return lhs >= NSNumber(integer: rhs)
}

public func <<A: AttributeType>(lhs: A, rhs: Int) -> NSPredicate {
    return lhs < NSNumber(integer: rhs)
}

public func <=<A: AttributeType>(lhs: A, rhs: Int) -> NSPredicate {
    return lhs <= NSNumber(integer: rhs)
}

// Int8

public func ==<A: AttributeType>(lhs: A, rhs: Int8) -> NSPredicate {
    return lhs == NSNumber(char: rhs)
}

public func !=<A: AttributeType>(lhs: A, rhs: Int8) -> NSPredicate {
    return lhs != NSNumber(char: rhs)
}

public func ><A: AttributeType>(lhs: A, rhs: Int8) -> NSPredicate {
    return lhs > NSNumber(char: rhs)
}

public func >=<A: AttributeType>(lhs: A, rhs: Int8) -> NSPredicate {
    return lhs >= NSNumber(char: rhs)
}

public func <<A: AttributeType>(lhs: A, rhs: Int8) -> NSPredicate {
    return lhs < NSNumber(char: rhs)
}

public func <=<A: AttributeType>(lhs: A, rhs: Int8) -> NSPredicate {
    return lhs <= NSNumber(char: rhs)
}

// Int16

public func ==<A: AttributeType>(lhs: A, rhs: Int16) -> NSPredicate {
    return lhs == NSNumber(short: rhs)
}

public func !=<A: AttributeType>(lhs: A, rhs: Int16) -> NSPredicate {
    return lhs != NSNumber(short: rhs)
}

public func ><A: AttributeType>(lhs: A, rhs: Int16) -> NSPredicate {
    return lhs > NSNumber(short: rhs)
}

public func >=<A: AttributeType>(lhs: A, rhs: Int16) -> NSPredicate {
    return lhs >= NSNumber(short: rhs)
}

public func <<A: AttributeType>(lhs: A, rhs: Int16) -> NSPredicate {
    return lhs < NSNumber(short: rhs)
}

public func <=<A: AttributeType>(lhs: A, rhs: Int16) -> NSPredicate {
    return lhs <= NSNumber(short: rhs)
}

// Int32

public func ==<A: AttributeType>(lhs: A, rhs: Int32) -> NSPredicate {
    return lhs == NSNumber(int: rhs)
}

public func !=<A: AttributeType>(lhs: A, rhs: Int32) -> NSPredicate {
    return lhs != NSNumber(int: rhs)
}

public func ><A: AttributeType>(lhs: A, rhs: Int32) -> NSPredicate {
    return lhs > NSNumber(int: rhs)
}

public func >=<A: AttributeType>(lhs: A, rhs: Int32) -> NSPredicate {
    return lhs >= NSNumber(int: rhs)
}

public func <<A: AttributeType>(lhs: A, rhs: Int32) -> NSPredicate {
    return lhs < NSNumber(int: rhs)
}

public func <=<A: AttributeType>(lhs: A, rhs: Int32) -> NSPredicate {
    return lhs <= NSNumber(int: rhs)
}

// Int64

public func ==<A: AttributeType>(lhs: A, rhs: Int64) -> NSPredicate {
    return lhs == NSNumber(longLong: rhs)
}

public func !=<A: AttributeType>(lhs: A, rhs: Int64) -> NSPredicate {
    return lhs != NSNumber(longLong: rhs)
}

public func ><A: AttributeType>(lhs: A, rhs: Int64) -> NSPredicate {
    return lhs > NSNumber(longLong: rhs)
}

public func >=<A: AttributeType>(lhs: A, rhs: Int64) -> NSPredicate {
    return lhs >= NSNumber(longLong: rhs)
}

public func <<A: AttributeType>(lhs: A, rhs: Int64) -> NSPredicate {
    return lhs < NSNumber(longLong: rhs)
}

public func <=<A: AttributeType>(lhs: A, rhs: Int64) -> NSPredicate {
    return lhs <= NSNumber(longLong: rhs)
}

// UInt

public func ==<A: AttributeType>(lhs: A, rhs: UInt) -> NSPredicate {
    return lhs == NSNumber(unsignedLong: rhs)
}

public func !=<A: AttributeType>(lhs: A, rhs: UInt) -> NSPredicate {
    return lhs != NSNumber(unsignedLong: rhs)
}

public func ><A: AttributeType>(lhs: A, rhs: UInt) -> NSPredicate {
    return lhs > NSNumber(unsignedLong: rhs)
}

public func >=<A: AttributeType>(lhs: A, rhs: UInt) -> NSPredicate {
    return lhs >= NSNumber(unsignedLong: rhs)
}

public func <<A: AttributeType>(lhs: A, rhs: UInt) -> NSPredicate {
    return lhs < NSNumber(unsignedLong: rhs)
}

public func <=<A: AttributeType>(lhs: A, rhs: UInt) -> NSPredicate {
    return lhs <= NSNumber(unsignedLong: rhs)
}

// UInt8

public func ==<A: AttributeType>(lhs: A, rhs: UInt8) -> NSPredicate {
    return lhs == NSNumber(unsignedChar: rhs)
}

public func !=<A: AttributeType>(lhs: A, rhs: UInt8) -> NSPredicate {
    return lhs != NSNumber(unsignedChar: rhs)
}

public func ><A: AttributeType>(lhs: A, rhs: UInt8) -> NSPredicate {
    return lhs > NSNumber(unsignedChar: rhs)
}

public func >=<A: AttributeType>(lhs: A, rhs: UInt8) -> NSPredicate {
    return lhs >= NSNumber(unsignedChar: rhs)
}

public func <<A: AttributeType>(lhs: A, rhs: UInt8) -> NSPredicate {
    return lhs < NSNumber(unsignedChar: rhs)
}

public func <=<A: AttributeType>(lhs: A, rhs: UInt8) -> NSPredicate {
    return lhs <= NSNumber(unsignedChar: rhs)
}

// UInt16

public func ==<A: AttributeType>(lhs: A, rhs: UInt16) -> NSPredicate {
    return lhs == NSNumber(unsignedShort: rhs)
}

public func !=<A: AttributeType>(lhs: A, rhs: UInt16) -> NSPredicate {
    return lhs != NSNumber(unsignedShort: rhs)
}

public func ><A: AttributeType>(lhs: A, rhs: UInt16) -> NSPredicate {
    return lhs > NSNumber(unsignedShort: rhs)
}

public func >=<A: AttributeType>(lhs: A, rhs: UInt16) -> NSPredicate {
    return lhs >= NSNumber(unsignedShort: rhs)
}

public func <<A: AttributeType>(lhs: A, rhs: UInt16) -> NSPredicate {
    return lhs < NSNumber(unsignedShort: rhs)
}

public func <=<A: AttributeType>(lhs: A, rhs: UInt16) -> NSPredicate {
    return lhs <= NSNumber(unsignedShort: rhs)
}

// UInt32

public func ==<A: AttributeType>(lhs: A, rhs: UInt32) -> NSPredicate {
    return lhs == NSNumber(unsignedInt: rhs)
}

public func !=<A: AttributeType>(lhs: A, rhs: UInt32) -> NSPredicate {
    return lhs != NSNumber(unsignedInt: rhs)
}

public func ><A: AttributeType>(lhs: A, rhs: UInt32) -> NSPredicate {
    return lhs > NSNumber(unsignedInt: rhs)
}

public func >=<A: AttributeType>(lhs: A, rhs: UInt32) -> NSPredicate {
    return lhs >= NSNumber(unsignedInt: rhs)
}

public func <<A: AttributeType>(lhs: A, rhs: UInt32) -> NSPredicate {
    return lhs < NSNumber(unsignedInt: rhs)
}

public func <=<A: AttributeType>(lhs: A, rhs: UInt32) -> NSPredicate {
    return lhs <= NSNumber(unsignedInt: rhs)
}

// UInt64

public func ==<A: AttributeType>(lhs: A, rhs: UInt64) -> NSPredicate {
    return lhs == NSNumber(unsignedLongLong: rhs)
}

public func !=<A: AttributeType>(lhs: A, rhs: UInt64) -> NSPredicate {
    return lhs != NSNumber(unsignedLongLong: rhs)
}

public func ><A: AttributeType>(lhs: A, rhs: UInt64) -> NSPredicate {
    return lhs > NSNumber(unsignedLongLong: rhs)
}

public func >=<A: AttributeType>(lhs: A, rhs: UInt64) -> NSPredicate {
    return lhs >= NSNumber(unsignedLongLong: rhs)
}

public func <<A: AttributeType>(lhs: A, rhs: UInt64) -> NSPredicate {
    return lhs < NSNumber(unsignedLongLong: rhs)
}

public func <=<A: AttributeType>(lhs: A, rhs: UInt64) -> NSPredicate {
    return lhs <= NSNumber(unsignedLongLong: rhs)
}

// Float

public func ==<A: AttributeType>(lhs: A, rhs: Float) -> NSPredicate {
    return lhs == NSNumber(float: rhs)
}

public func !=<A: AttributeType>(lhs: A, rhs: Float) -> NSPredicate {
    return lhs != NSNumber(float: rhs)
}

public func ><A: AttributeType>(lhs: A, rhs: Float) -> NSPredicate {
    return lhs > NSNumber(float: rhs)
}

public func >=<A: AttributeType>(lhs: A, rhs: Float) -> NSPredicate {
    return lhs >= NSNumber(float: rhs)
}

public func <<A: AttributeType>(lhs: A, rhs: Float) -> NSPredicate {
    return lhs < NSNumber(float: rhs)
}

public func <=<A: AttributeType>(lhs: A, rhs: Float) -> NSPredicate {
    return lhs <= NSNumber(float: rhs)
}

// Double

public func ==<A: AttributeType>(lhs: A, rhs: Double) -> NSPredicate {
    return lhs == NSNumber(double: rhs)
}

public func !=<A: AttributeType>(lhs: A, rhs: Double) -> NSPredicate {
    return lhs != NSNumber(double: rhs)
}

public func ><A: AttributeType>(lhs: A, rhs: Double) -> NSPredicate {
    return lhs > NSNumber(double: rhs)
}

public func >=<A: AttributeType>(lhs: A, rhs: Double) -> NSPredicate {
    return lhs >= NSNumber(double: rhs)
}

public func <<A: AttributeType>(lhs: A, rhs: Double) -> NSPredicate {
    return lhs < NSNumber(double: rhs)
}

public func <=<A: AttributeType>(lhs: A, rhs: Double) -> NSPredicate {
    return lhs <= NSNumber(double: rhs)
}


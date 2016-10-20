//
//  Types.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 9/25/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension Int: TypedExpressionConvertible {
    public typealias CDQIComparisonType = NSNumber
#if arch(x86_64) || arch(arm64)
    public static let cdqiStaticType = NSAttributeType.integer64AttributeType
#else
    public static let cdqiStaticType = NSAttributeType.integer32AttributeType
#endif
    public var cdqiExpression: NSExpression {
        let number = NSNumber(value: self)
        return NSExpression(forConstantValue: number)
    }    
}

extension Int16: TypedExpressionConvertible {
    public typealias CDQIComparisonType = NSNumber
    public static let cdqiStaticType = NSAttributeType.integer16AttributeType
    public var cdqiExpression: NSExpression {
        let number = NSNumber(value: self)
        return NSExpression(forConstantValue: number)
    }
}

extension Int32: TypedExpressionConvertible {
    public typealias CDQIComparisonType = NSNumber
    public static let cdqiStaticType = NSAttributeType.integer32AttributeType
    public var cdqiExpression: NSExpression {
        let number = NSNumber(value: self)
        return NSExpression(forConstantValue: number)
    }
}

extension Int64: TypedExpressionConvertible {
    public typealias CDQIComparisonType = NSNumber
    public static let cdqiStaticType = NSAttributeType.integer64AttributeType
    public var cdqiExpression: NSExpression {
        let number = NSNumber(value: self)
        return NSExpression(forConstantValue: number)
    }
}

extension UInt: TypedExpressionConvertible {
    public typealias CDQIComparisonType = NSNumber
#if arch(x86_64) || arch(arm64)
    public static let cdqiStaticType = NSAttributeType.integer64AttributeType
#else
    public static let cdqiStaticType = NSAttributeType.integer32AttributeType
#endif
    public var cdqiExpression: NSExpression {
        let number = NSNumber(value: self)
        return NSExpression(forConstantValue: number)
    }
}

extension UInt16: TypedExpressionConvertible {
    public typealias CDQIComparisonType = NSNumber
    public static let cdqiStaticType = NSAttributeType.integer16AttributeType
    public var cdqiExpression: NSExpression {
        let number = NSNumber(value: self)
        return NSExpression(forConstantValue: number)
    }
}

extension UInt32: TypedExpressionConvertible {
    public typealias CDQIComparisonType = NSNumber
    public static let cdqiStaticType = NSAttributeType.integer32AttributeType
    public var cdqiExpression: NSExpression {
        let number = NSNumber(value: self)
        return NSExpression(forConstantValue: number)
    }
}

extension UInt64: TypedExpressionConvertible {
    public typealias CDQIComparisonType = NSNumber
    public static let cdqiStaticType = NSAttributeType.integer32AttributeType
    public var cdqiExpression: NSExpression {
        let number = NSNumber(value: self)
        return NSExpression(forConstantValue: number)
    }
}

extension Date: TypedConstantExpressionConvertible {
    public typealias CDQIComparisonType = Date
    public static let cdqiStaticType = NSAttributeType.dateAttributeType
}

extension String: TypedConstantExpressionConvertible {
    public typealias CDQIComparisonType = String
    public static let cdqiStaticType = NSAttributeType.stringAttributeType
}

extension Bool: TypedConstantExpressionConvertible {
    public typealias CDQIComparisonType = Bool
    public static let cdqiStaticType = NSAttributeType.booleanAttributeType
}

extension Decimal: TypedConstantExpressionConvertible {
    public typealias CDQIComparisonType = NSNumber
    public static let cdqiStaticType = NSAttributeType.decimalAttributeType
}

extension Double: TypedConstantExpressionConvertible {
    public typealias CDQIComparisonType = NSNumber
    public static let cdqiStaticType = NSAttributeType.doubleAttributeType
}

extension Float: TypedConstantExpressionConvertible {
    public typealias CDQIComparisonType = NSNumber
    public static let cdqiStaticType = NSAttributeType.floatAttributeType
}

extension NSNumber: TypedConstantExpressionConvertible {
    public typealias CDQIComparisonType = NSNumber
    @nonobjc public static let cdqiStaticType = NSAttributeType.doubleAttributeType
}

extension Data: TypedConstantExpressionConvertible {
    public typealias CDQIComparisonType = Data
    public static let cdqiStaticType = NSAttributeType.binaryDataAttributeType
}

extension NSData: TypedConstantExpressionConvertible {
    public typealias CDQIComparisonType = Data
    @nonobjc public static let cdqiStaticType = NSAttributeType.binaryDataAttributeType
}

extension NSManagedObjectID: TypedConstantExpressionConvertible {
    public typealias CDQIComparisonType = NSManagedObjectID
    @nonobjc public static let cdqiStaticType = NSAttributeType.objectIDAttributeType
}

extension NSManagedObject: TypedConstantExpressionConvertible {
    public typealias CDQIComparisonType = NSManagedObjectID
    @nonobjc public static let cdqiStaticType = NSAttributeType.objectIDAttributeType
}

//
//  Types.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 9/25/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension Int: TypedConstantExpressionConvertible {
    public typealias CDQIComparisonType = NSNumber
#if arch(x86_64) || arch(arm64)
    public static let cdqiStaticType = NSAttributeType.integer64AttributeType
#else
    public static let cdqiStaticType = NSAttributeType.integer32AttributeType
#endif
}

extension Int32: TypedConstantExpressionConvertible {
    public typealias CDQIComparisonType = NSNumber
    public static let cdqiStaticType = NSAttributeType.integer32AttributeType
}

extension Int64: TypedConstantExpressionConvertible {
    public typealias CDQIComparisonType = NSNumber
    public static let cdqiStaticType = NSAttributeType.integer64AttributeType
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

extension Double: TypedConstantExpressionConvertible {
    public typealias CDQIComparisonType = NSNumber
    public static let cdqiStaticType = NSAttributeType.doubleAttributeType
}

extension NSNumber: TypedConstantExpressionConvertible {
    public typealias CDQIComparisonType = NSNumber
    @nonobjc public static let cdqiStaticType = NSAttributeType.doubleAttributeType
}

extension NSManagedObjectID: TypedConstantExpressionConvertible {
    public typealias CDQIComparisonType = NSManagedObjectID
    @nonobjc public static let cdqiStaticType = NSAttributeType.objectIDAttributeType
}

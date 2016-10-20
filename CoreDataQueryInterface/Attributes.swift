//
//  Attribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 9/25/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

open class EntityAttribute: PredicateComparableTypedExpressionConvertible, KeyPathExpressionConvertible, PropertyConvertible {
    public typealias CDQIComparisonType = NSManagedObjectID
    
    public let cdqiKey: String?
    public let cdqiParent: KeyPathExpressionConvertible?
    
    public required init(key: String? = nil, parent: KeyPathExpressionConvertible? = nil) {
        // You can have a key without a parent, but you can't have a parent without a key.
        assert(key != nil || parent == nil, "Parent without key in Attribute.")
        // If key is a variable, i.e., starts with a $, it can't have a parent.
        assert(!(key?.hasPrefix("$") ?? false) || parent == nil, "Variable with parent in Attribute.")
        cdqiKey = key
        cdqiParent = parent
    }
    
    public required convenience init(variable: String) {
        self.init(key: "$\(variable)")
    }
}

public struct ScalarAttribute<E: TypedExpressionConvertible>: PredicateComparableTypedExpressionConvertible, KeyPathExpressionConvertible, PropertyConvertible {
    public typealias CDQIComparisonType = E.CDQIComparisonType
    
    public let cdqiKey: String?
    public let cdqiParent: KeyPathExpressionConvertible?
    public let cdqiType: NSAttributeType = E.cdqiStaticType
    
    public init(key: String, parent: KeyPathExpressionConvertible) {
        assert(!key.hasPrefix("$"), "Variable used as key for ScalarAttribute.")
        cdqiKey = key
        cdqiParent = parent
    }
}

public typealias BoolAttribute = ScalarAttribute<Bool>
public typealias StringAttribute = ScalarAttribute<String>
public typealias Integer16Attribute = ScalarAttribute<Int16>
public typealias Integer32Attribute = ScalarAttribute<Int32>
public typealias Integer64Attribute = ScalarAttribute<Int64>
public typealias DoubleAttribute = ScalarAttribute<Double>
public typealias DataAttribute = ScalarAttribute<Data>
public typealias DateAttribute = ScalarAttribute<Date>
public typealias DecimalAttribute = ScalarAttribute<Decimal>
public typealias FloatAttribute = ScalarAttribute<Float>

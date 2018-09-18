//
//  DecimalAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

/// Represents a decimal in a Core Data model.
public struct DecimalAttribute: ScalarAttribute {
    public typealias CDQIComparableType = NSNumber
    
    public let cdqiAttributeType: NSAttributeType = .decimalAttributeType
    public let cdqiExpressionKeyPath: ExpressionKeyPath
    
    public init(key: String, parent: EntityAttribute) {
        cdqiExpressionKeyPath = .keyPath(key, parent)
    }
}

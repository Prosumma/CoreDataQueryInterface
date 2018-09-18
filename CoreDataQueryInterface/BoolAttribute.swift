//
//  BoolAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

/// Represents a Boolean attribute in a Core Data model.
public struct BoolAttribute: ScalarAttribute {
    public typealias CDQIComparableType = Bool
    
    public let cdqiAttributeType: NSAttributeType = .booleanAttributeType
    public let cdqiExpressionKeyPath: ExpressionKeyPath
    
    public init(key: String, parent: EntityAttribute) {
        cdqiExpressionKeyPath = .keyPath(key, parent)
    }
}

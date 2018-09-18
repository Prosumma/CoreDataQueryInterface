//
//  DateAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

/// Represents a `Date` in a Core Data model.
public struct DateAttribute: ScalarAttribute {
    public typealias CDQIComparableType = Date
    
    public let cdqiAttributeType: NSAttributeType = .dateAttributeType
    public let cdqiExpressionKeyPath: ExpressionKeyPath
    
    public init(key: String, parent: EntityAttribute) {
        cdqiExpressionKeyPath = .keyPath(key, parent)
    }
}

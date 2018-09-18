//
//  DataAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

/// Represents a binary data attribute in a Core Data model.
public struct DataAttribute: ScalarAttribute {
    public typealias CDQIComparableType = Data
    
    public let cdqiAttributeType: NSAttributeType = .binaryDataAttributeType
    public let cdqiExpressionKeyPath: ExpressionKeyPath
    
    public init(key: String, parent: EntityAttribute) {
        cdqiExpressionKeyPath = .keyPath(key, parent)
    }
}

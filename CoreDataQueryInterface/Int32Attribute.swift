//
//  Int32Attribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public struct Int32Attribute: ScalarAttribute {
    public typealias CDQIComparableType = NSNumber
    
    public let cdqiAttributeType: NSAttributeType = .integer32AttributeType
    public let cdqiExpressionKeyPath: ExpressionKeyPath
    
    public init(key: String, parent: EntityAttribute) {
        cdqiExpressionKeyPath = .keyPath(key, parent)
    }
}

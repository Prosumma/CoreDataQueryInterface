//
//  DoubleAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public struct DoubleAttribute: ScalarAttribute {
    public typealias CDQIComparableType = NSNumber
    
    public let cdqiType: NSAttributeType = .doubleAttributeType
    public let cdqiExpressionKeyPath: ExpressionKeyPath
    
    public init(key: String, parent: EntityAttribute) {
        cdqiExpressionKeyPath = .keyPath(key, parent)
    }
}

//
//  AttributedType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

/**
The protocol implemented by classes that represent object dot notation.
*/
public protocol AttributeType: CustomStringConvertible, OrderType, ExpressionType {
    init(_ name: String?, parent: AttributeType?)
}

extension AttributeType {
    public func toPropertyDescription(entityDescription: NSEntityDescription) -> NSPropertyDescription {
        return String(self).toPropertyDescription(entityDescription)
    }
    public func toExpression(entityDescription: NSEntityDescription) -> NSExpression {
        return String(self).toExpression(entityDescription)
    }
}


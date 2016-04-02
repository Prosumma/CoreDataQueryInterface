//
//  EntityAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject: TypedExpressionConvertible, ComparableExpression {
    
    public typealias ExpressionValueType = NSManagedObject
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}

public class EntityAttribute: Attribute, TypedExpressionConvertible {
    public typealias ExpressionValueType = NSManagedObject
}
//
//  NSManagedObjectID.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import CoreData

extension NSManagedObjectID: TypedExpressionConvertible {
    public typealias ExpressionValueType = NSManagedObject
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}
//
//  DataAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

extension NSData: TypedExpressionConvertible, EquatableExpression {
    public typealias ExpressionValueType = NSData
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}

public class DataAttribute: KeyAttribute, TypedExpressionConvertible {
    public typealias ExpressionValueType = NSData
}


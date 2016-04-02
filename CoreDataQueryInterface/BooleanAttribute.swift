//
//  BooleanAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

extension Bool: TypedExpressionConvertible, EquatableExpression {
    public typealias ExpressionValueType = Bool
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}

public class BooleanAttribute: KeyAttribute, TypedExpressionConvertible {
    public typealias ExpressionValueType = Bool
}


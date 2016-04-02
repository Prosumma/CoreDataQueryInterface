//
//  DateAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

public class DateAttribute: KeyAttribute, TypedExpressionConvertible {
    public typealias ExpressionValueType = NSDate
}

extension NSDate: TypedExpressionConvertible, ComparableExpression {
    public typealias ExpressionValueType = NSDate
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}
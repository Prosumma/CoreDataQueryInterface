//
//  DateAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

public class DateAttribute: KeyAttribute, TypedExpressionConvertible {
    public typealias ExpressionValueType = Date
}

extension NSDate: TypedExpressionConvertible {
    public typealias ExpressionValueType = Date
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}

public struct Date: Comparable {
    
}

public func ==(lhs: Date, rhs: Date) -> Bool {
    return true
}

public func <(lhs: Date, rhs: Date) -> Bool {
    return true
}
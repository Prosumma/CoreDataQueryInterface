//
//  NumericAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

public class NumericAttribute: KeyAttribute, TypedExpressionConvertible {
    public typealias ExpressionValueType = NSNumber
}

extension Int: TypedExpressionConvertible {
    public typealias ExpressionValueType = NSNumber
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}

extension Int16: TypedExpressionConvertible {
    public typealias ExpressionValueType = NSNumber
    public var expression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(short: self))
    }
}

extension Int32: TypedExpressionConvertible {
    public typealias ExpressionValueType = NSNumber
    public var expression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(int: self))
    }
}

extension Int64: TypedExpressionConvertible {
    public typealias ExpressionValueType = NSNumber
    public var expression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(longLong: self))
    }
}

extension UInt: TypedExpressionConvertible {
    public typealias ExpressionValueType = NSNumber
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}

extension UInt16: TypedExpressionConvertible {
    public typealias ExpressionValueType = NSNumber
    public var expression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(unsignedShort: self))
    }
}

extension UInt32: TypedExpressionConvertible {
    public typealias ExpressionValueType = NSNumber
    public var expression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(unsignedInt: self))
    }
}

extension UInt64: TypedExpressionConvertible {
    public typealias ExpressionValueType = NSNumber
    public var expression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(unsignedLongLong: self))
    }
}

extension Float: TypedExpressionConvertible {
    public typealias ExpressionValueType = NSNumber
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}

extension Double: TypedExpressionConvertible {
    public typealias ExpressionValueType = NSNumber
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}

extension NSNumber: TypedExpressionConvertible, ComparableExpression {
    public typealias ExpressionValueType = NSNumber
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}


//
//  NumericAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

public class NumericAttribute: KeyAttribute, TypedExpressionConvertible {
    public typealias ExpressionValueType = Int
}

extension Int16: TypedExpressionConvertible {
    public typealias ExpressionValueType = Int
    public var expression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(short: self))
    }
}

extension Int32: TypedExpressionConvertible {
    public typealias ExpressionValueType = Int
    public var expression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(int: self))
    }
}

extension Int64: TypedExpressionConvertible {
    public typealias ExpressionValueType = Int
    public var expression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(longLong: self))
    }
}

extension UInt: TypedExpressionConvertible {
    public typealias ExpressionValueType = Int
    public var expression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(unsignedLong: self))
    }
}

extension Float: TypedExpressionConvertible {
    public typealias ExpressionValueType = Int
    public var expression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(float: self))
    }
}

extension Double: TypedExpressionConvertible {
    public typealias ExpressionValueType = Int
    public var expression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(double: self))
    }
}

extension NSNumber: TypedExpressionConvertible {
    public typealias ExpressionValueType = Int
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}


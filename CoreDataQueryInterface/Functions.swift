//
//  Functions.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 9/25/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public enum Function: String {
    case count = "count:"
    case sum = "sum:"
    case stddev = "stddev:"
}

public struct FunctionExpression<E: TypedExpressionConvertible>: PredicateComparableTypedExpressionConvertible, KeyPathExpressionConvertible, PropertyConvertible {
    public typealias CDQIComparisonType = E.CDQIComparisonType
    
    public let function: String
    public let expression: ExpressionConvertible
    
    public let cdqiKey: String?
    public let cdqiParent: KeyPathExpressionConvertible?
    public let cdqiType: NSAttributeType
    
    public init(function: Function, expression: ExpressionConvertible, type: NSAttributeType? = nil) {
        self.function = function.rawValue
        self.expression = expression
        if let type = type {
            cdqiType = type
        } else if let typed = expression as? Typed {
            cdqiType = typed.cdqiType
        } else {
            cdqiType = E.cdqiStaticType
        }
        if let keyPath = expression as? KeyPathExpressionConvertible {
            cdqiParent = keyPath
        } else {
            cdqiParent = nil
        }
        let range = self.function.range(of: ":")!
        cdqiKey = self.function.substring(to: range.lowerBound)
    }
    
    public var cdqiExpression: NSExpression {
        return NSExpression(forFunction: function, arguments: [expression.cdqiExpression])
    }
    
    public var cdqiKeyPath: String {
        assertionFailure("Can't build keypath from function.")
        return ""
    }
}

public func count(_ expression: ExpressionConvertible) -> FunctionExpression<Int> {
    return FunctionExpression(function: .count, expression: expression, type: Int.cdqiStaticType)
}

public func count(_ expression: ExpressionConvertible, alias name: String) -> PropertyConvertible {
    return alias(count(expression), name: name)
}

public func sum(_ expression: ExpressionConvertible, type: NSAttributeType? = nil) -> FunctionExpression<Double> {
    return FunctionExpression(function: .sum, expression: expression, type: type)
}

public func sum(_ expression: ExpressionConvertible, name: String, type: NSAttributeType? = nil) -> PropertyConvertible {
    let f = sum(expression)
    return alias(f, name: name, type: type ?? f.cdqiType)
}

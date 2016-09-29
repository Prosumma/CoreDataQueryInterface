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
    case max = "max:"
    case min = "min:"
    case sum = "sum:"
    case stddev = "stddev:"
}

public struct FunctionExpression: PredicateComparableTypedExpressionConvertible, KeyPathExpressionConvertible, PropertyConvertible {
    public typealias CDQIComparisonType = NSNumber
    
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
            cdqiType = .doubleAttributeType // Return the "widest" possible numeric type
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

public func function(function: Function, expression: ExpressionConvertible, alias name: String? = nil, type: NSAttributeType? = nil) -> PropertyConvertible {
    let functionExpression = FunctionExpression(function: function, expression: expression, type: type)
    guard let name = name else { return functionExpression }
    return alias(functionExpression, name: name, type: functionExpression.cdqiType)
}

public func count(_ expression: ExpressionConvertible, alias name: String? = nil, type: NSAttributeType? = nil) -> PropertyConvertible {
    return function(function: .count, expression: expression, alias: name, type: type)
}

public func max(_ expression: ExpressionConvertible, alias name: String? = nil, type: NSAttributeType? = nil) -> PropertyConvertible {
    return function(function: .max, expression: expression, alias: name, type: type)
}

public func min(_ expression: ExpressionConvertible, alias name: String? = nil, type: NSAttributeType? = nil) -> PropertyConvertible {
    return function(function: .min, expression: expression, alias: name, type: type)
}

public func sum(_ expression: ExpressionConvertible, alias name: String? = nil, type: NSAttributeType? = nil) -> PropertyConvertible {
    return function(function: .sum, expression: expression, alias: name, type: type)
}


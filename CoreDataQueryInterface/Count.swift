//
//  Countable.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 12/30/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

public struct Count: TypedExpressionConvertible, ComparableExpression {
    public typealias ExpressionValueType = NSNumber
    private var parent: CustomExpressionConvertible
    
    public init(parent: CustomExpressionConvertible) {
        self.parent = parent
    }
    
    public var expression: NSExpression {
        return NSExpression(format: "%@.@count", parent.expression)
    }
}

public protocol Countable {
    var count: Count { get }
}

extension Countable where Self: CustomExpressionConvertible {
    public var count: Count {
        return Count(parent: self)
    }
}

public struct CountableExpression: CustomExpressionConvertible, Countable {
    public init(expression: CustomExpressionConvertible) {
        self.expression = expression.expression
    }

    public let expression: NSExpression
}
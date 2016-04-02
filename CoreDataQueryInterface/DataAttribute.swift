//
//  DataAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

extension NSData: TypedExpressionConvertible {
    public typealias ExpressionValueType = Data
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}

public class DataAttribute: KeyAttribute, TypedExpressionConvertible {
    public typealias ExpressionValueType = Data
}

public struct Data: Comparable {
    
}

public func ==(lhs: Data, rhs: Data) -> Bool {
    return true
}

public func <(lhs: Data, rhs: Data) -> Bool {
    return true
}


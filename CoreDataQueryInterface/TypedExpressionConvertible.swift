//
//  TypedExpressionConvertible.swift
//  CoreDataQueryInterface
//
//  Created by Patrick Goley on 3/28/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

// MARK: Protocols

public protocol ExpressionValueType {
    
    var boxedValue: AnyObject { get } // provide a boxed value for NSExpression
}

public protocol TypedExpressionConvertible: CustomExpressionConvertible {
    
    associatedtype ValueType: ExpressionValueType
}

// MARK: String

extension String: ExpressionValueType {
    
    public var boxedValue: AnyObject {
        
        return self as NSString
    }
}

public class StringAttribute: KeyAttribute, TypedExpressionConvertible {
    
    public typealias ValueType = String
}

// MARK: Date

extension NSDate: ExpressionValueType {
    
    public var boxedValue: AnyObject {
        
        return self
    }
}

public class DateAttribute: KeyAttribute, TypedExpressionConvertible {
    
    public typealias ValueType = NSDate
}


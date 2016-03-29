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


// MARK: Numbers

extension Int: ExpressionValueType {
    
    public var boxedValue: AnyObject {
        
        return self as NSNumber
    }
}

extension Float: ExpressionValueType {
    
    public var boxedValue: AnyObject {
        
        return self as NSNumber
    }
}

extension Double: ExpressionValueType {
    
    public var boxedValue: AnyObject {
        
        return self as NSNumber
    }
}

public class Integer16Attribute: KeyAttribute, TypedExpressionConvertible {
    
    public typealias ValueType = Int
}

public class Integer32Attribute: KeyAttribute, TypedExpressionConvertible {
    
    public typealias ValueType = Int
}

public class Integer64Attribute: KeyAttribute, TypedExpressionConvertible {
    
    public typealias ValueType = Int
}

public class FloatAttribute: KeyAttribute, TypedExpressionConvertible {
    
    public typealias ValueType = Float
}

public class Double64Attribute: KeyAttribute, TypedExpressionConvertible {
    
    public typealias ValueType = Double
}

public class DecimalAttribute: KeyAttribute, TypedExpressionConvertible {
    
    public typealias ValueType = Float
}


// MARK: Data

extension NSData: ExpressionValueType {
    
    public var boxedValue: AnyObject {
        
        return self
    }
}

public class DataAttribute: KeyAttribute, TypedExpressionConvertible {
    
    public typealias ValueType = NSData
}



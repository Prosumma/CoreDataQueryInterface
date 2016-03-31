//
//  TypedExpressionConvertible.swift
//  CoreDataQueryInterface
//
//  Created by Patrick Goley on 3/28/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation


public protocol ExpressionValueType {
    
    var boxedValue: AnyObject { get }
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


// MARK: Boolean

extension Bool: ExpressionValueType {
    
    public var boxedValue: AnyObject {
        
        return NSNumber(bool: self)
    }
}

public class BooleanAttribute: KeyAttribute, TypedExpressionConvertible {
    
    public typealias ValueType = Bool
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

public protocol NumericValueType {
    
    var numberValue: NSNumber { get }
}

extension Int16: NumericValueType {
    
    public var numberValue: NSNumber {
        
        return NSNumber(short: self)
    }
}

extension Int32: NumericValueType {
    
    public var numberValue: NSNumber {
        
        return NSNumber(int: self)
    }
}

extension Int64: NumericValueType {
    
    public var numberValue: NSNumber {
        
        return NSNumber(longLong: self)
    }
}

extension NSNumber: ExpressionValueType {
    
    public var boxedValue: AnyObject {
        
        return self
    }
}

public class NumericAttribute: KeyAttribute, TypedExpressionConvertible {
    
    public typealias ValueType = NSNumber
}


// MARK: Data

extension NSData: ExpressionValueType {
    
    public var boxedValue: AnyObject {
        
        return self
    }
}

public class BinaryAttribute: KeyAttribute, TypedExpressionConvertible {
    
    public typealias ValueType = NSData
}


// MARK: Transformable
//
//public class TransformableAttribute<V: ExpressionValueType>: KeyAttribute, TypedExpressionConvertible {
//    
//    public typealias ValueType = V
//}


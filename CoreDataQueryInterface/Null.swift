//
//  File.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

/**
 Represents `nil` in CDQI filter predicates, e.g., `employee.lastName == nil`.
 
 - note: Because `Null` implements `NilLiteralConvertible`, it is not necessary to create
 instances of it. Simply use `nil` in filter expressions, and an instance of `Null`
 will be created.
 */
public struct Null: CustomExpressionConvertible, NilLiteralConvertible {
    public init(nilLiteral: ()) {
        
    }
    
    public init() {
        
    }
    
    public var expression: NSExpression {
        return NSExpression(forConstantValue: nil)
    }
}
//
//  Null.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

/**
 A type used to construct an `NSExpression` for `NULL` and for
 use in predicates.
 
 ```
 query.filter(Employee.e.middleName == Null.null)
 ```
 
 However, since `Null` implements `ExpressibleByNilLiteral`,
 a simple `nil` can (and should) be used in most cases:
 
 ```
 query.filter(Employee.e.middleName == nil)
 ```
 */
public struct Null: ExpressibleByNilLiteral, Expression {
    public init(nilLiteral: ()) {
        
    }
    
    public var cdqiExpression: NSExpression {
        return NSExpression(forConstantValue: nil)
    }
    
    public static let null: Null = nil
}


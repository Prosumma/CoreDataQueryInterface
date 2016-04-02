//
//  File.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

public struct Null: CustomExpressionConvertible, NilLiteralConvertible {
    public init(nilLiteral: ()) {
        
    }
    
    public init() {
        
    }
    
    public var expression: NSExpression {
        return NSExpression(forConstantValue: nil)
    }
}
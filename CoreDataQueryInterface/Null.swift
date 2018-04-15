//
//  Null.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

public struct Null: ExpressibleByNilLiteral, Expression {
    public init(nilLiteral: ()) {
        
    }
    
    public var cdqiExpression: NSExpression {
        return NSExpression(forConstantValue: nil)
    }
    
    public static let null: Null = nil
}


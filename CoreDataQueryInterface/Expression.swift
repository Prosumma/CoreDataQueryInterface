//
//  Expression.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/14/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

public struct Expression {
    
}

extension Expression {
    
    public static func alias(name: String, expression: ExpressionType) -> Alias {
        return Alias(name: name, expression: expression)
    }
    
}
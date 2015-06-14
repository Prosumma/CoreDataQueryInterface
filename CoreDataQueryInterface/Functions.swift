//
//  Functions.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/13/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension Expression {
    
    public static func max(attribute: String, type: NSAttributeType? = nil) -> Expression {
        return Expression.Function("max:", attribute, type)
    }
    
}
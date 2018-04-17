//
//  Subquery.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public struct Subquery: Expression & Named {
    
    public let cdqiExpression: NSExpression
    public let cdqiName = "subquery"
    
    init(_ subentity: Expression, variable: String, predicate: NSPredicate) {
        cdqiExpression = NSExpression(forSubquery: subentity.cdqiExpression, usingIteratorVariable: variable, predicate: predicate)
    }
}

public func subquery(_ subentity: Expression, variable: String, predicate: NSPredicate) -> Subquery {
    return Subquery(subentity, variable: variable, predicate: predicate)
}


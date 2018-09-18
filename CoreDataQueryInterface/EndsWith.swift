//
//  EndsWith.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

/**
 Creates a Core Data `ENDSWITH` predicate.
 
 For example:
 
 ```
 query.filter(endsWith(Employee.e.lastName, "e"))
 ```
 */
public func endsWith<L: Expression & TypeComparable>(_ lhs: L, _ rhs: String, options: NSComparisonPredicate.Options = []) -> NSPredicate where L.CDQIComparableType == String {
    return NSComparisonPredicate(leftExpression: lhs.cdqiExpression, rightExpression: NSExpression(forConstantValue: rhs), modifier: .direct, type: .endsWith, options: options)
}

public extension Expression where Self: TypeComparable, Self.CDQIComparableType == String {
    
    /**
     Creates a Core Data `ENDSWITH` predicate from the receiver.
     
     For example:
     
     ```
     query.filter(Employee.e.lastName.cdqiEndsWith("e"))
     ```
    */
    func cdqiEndsWith(_ rhs: String, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return endsWith(self, rhs, options: options)
    }
    
}


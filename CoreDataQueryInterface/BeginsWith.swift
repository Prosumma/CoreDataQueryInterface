//
//  BeginsWith.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

/**
 Creates a Core Data `BEGINSWITH` predicate.
 
 For example:
 
 ```
 query.filter(beginsWith(band.e.genre, "M"))
 ```
 */
public func beginsWith<L: Expression & TypeComparable>(_ lhs: L, _ rhs: String, options: NSComparisonPredicate.Options = []) -> NSPredicate where L.CDQIComparableType == String {
    return NSComparisonPredicate(leftExpression: lhs.cdqiExpression, rightExpression: NSExpression(forConstantValue: rhs), modifier: .direct, type: .beginsWith, options: options)
}

public extension Expression where Self: TypeComparable, Self.CDQIComparableType == String {
    
    /**
     Creates a Core Data `BEGINSWITH` predicate from the receiver.
     
     For example:
     
     ```
     query.filter(band.e.genre.beginsWith("M"))
     ```
    */
    func cdqiBeginsWith(_ rhs: String, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return beginsWith(self, rhs, options: options)
    }
    
}


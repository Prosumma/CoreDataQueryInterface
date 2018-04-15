//
//  EndsWith.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

public func endsWith<L: Expression & TypeComparable>(_ lhs: L, _ rhs: String, options: NSComparisonPredicate.Options = []) -> NSPredicate where L.CDQIComparableType == String {
    return NSComparisonPredicate(leftExpression: lhs.cdqiExpression, rightExpression: NSExpression(forConstantValue: rhs), modifier: .direct, type: .endsWith, options: options)
}

public extension Expression where Self: TypeComparable, Self.CDQIComparableType == String {
    
    func cdqiEndsWith(_ rhs: String, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return endsWith(self, rhs, options: options)
    }
    
}


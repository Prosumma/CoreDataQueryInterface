//
//  Matches.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

infix operator =~: ComparisonPrecedence

public func matches<L: Expression & TypeComparable>(_ lhs: L, _ rhs: String, options: NSComparisonPredicate.Options = [], modifier: NSComparisonPredicate.Modifier = .direct) -> NSPredicate where L.CDQIComparableType == String {
    return NSComparisonPredicate(leftExpression: lhs.cdqiExpression, rightExpression: NSExpression(forConstantValue: rhs), modifier: modifier, type: .matches, options: options)
}

public extension Expression where Self: TypeComparable, Self.CDQIComparableType == String {
    
    func cdqiMatches(_ rhs: String, options: NSComparisonPredicate.Options = [], modifier: NSComparisonPredicate.Modifier = .direct) -> NSPredicate {
        return matches(self, rhs, options: options, modifier: modifier)
    }
    
}

public func =~<L: Expression & Inconstant & TypeComparable>(lhs: L, rhs: String) -> NSPredicate where L.CDQIComparableType == String {
    return matches(lhs, rhs)
}

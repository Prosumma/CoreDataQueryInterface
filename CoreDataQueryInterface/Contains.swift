//
//  Contains.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

infix operator =%=: ComparisonPrecedence

public func contains<L: Expression & TypeComparable>(_ lhs: L, _ rhs: String, options: NSComparisonPredicate.Options = [], modifier: NSComparisonPredicate.Modifier = .direct) -> NSPredicate where L.CDQIComparableType == String {
    return NSComparisonPredicate(leftExpression: lhs.cdqiExpression, rightExpression: NSExpression(forConstantValue: rhs), modifier: modifier, type: .contains, options: options)
}

public extension Expression where Self: TypeComparable, Self.CDQIComparableType == String {
    
    func cdqiContains(_ rhs: String, options: NSComparisonPredicate.Options = [], modifier: NSComparisonPredicate.Modifier = .direct) -> NSPredicate {
        return contains(self, rhs, options: options, modifier: modifier)
    }
    
}

public func =%=<L: Expression & Inconstant & TypeComparable>(lhs: L, rhs: String) -> NSPredicate where L.CDQIComparableType == String {
    return contains(lhs, rhs)
}


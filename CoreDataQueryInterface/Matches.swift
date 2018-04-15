//
//  Matches.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

public func matches<L: Expression & TypeComparable>(_ lhs: L, _ rhs: String, options: NSComparisonPredicate.Options = []) -> NSPredicate where L.CDQIComparableType == String {
    return NSComparisonPredicate(leftExpression: lhs.cdqiExpression, rightExpression: NSExpression(forConstantValue: rhs), modifier: .direct, type: .matches, options: options)
}

public func matches<L: Expression & TypeComparable>(_ lhs: L, _ rhs: Regex, options: NSComparisonPredicate.Options = []) -> NSPredicate where L.CDQIComparableType == String {
    return matches(lhs, String(describing: rhs))
}

public extension Expression where Self: TypeComparable, Self.CDQIComparableType == String {
    
    func cdqiMatches(_ rhs: String, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return matches(self, rhs, options: options)
    }

    func cdqiMatches(_ rhs: Regex, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return matches(self, rhs, options: options)
    }
    
}

public func ~=<R: Expression & Inconstant & TypeComparable>(pattern: Regex, value: R) -> NSPredicate where R.CDQIComparableType == String {
    return matches(value, pattern)
}


//
//  Between.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

public func between(_ lhs: Expression, _ rhs1: Expression, and rhs2: Expression, options: NSComparisonPredicate.Options = [], modifier: NSComparisonPredicate.Modifier = .direct) -> NSPredicate {
    return NSComparisonPredicate(leftExpression: lhs.cdqiExpression, rightExpression: NSExpression(forAggregate: [rhs1.cdqiExpression, rhs2.cdqiExpression]), modifier: modifier, type: .between, options: options)
}

public extension Expression where Self: TypeComparable {
    func cdqiBetween<R1: Expression & TypeComparable, R2: Expression & TypeComparable>(_ rhs1: R1, and rhs2: R2, options: NSComparisonPredicate.Options = [], modifier: NSComparisonPredicate.Modifier = .direct) -> NSPredicate where CDQIComparableType == R1.CDQIComparableType, CDQIComparableType == R2.CDQIComparableType {
        return between(self, rhs1, and: rhs2, options: options, modifier: modifier)
    }
}

public func ~=<L: Expression & TypeComparable & Comparable, R: Expression & Inconstant & TypeComparable>(pattern: ClosedRange<L>, value: R) -> NSPredicate where L.CDQIComparableType == R.CDQIComparableType {
    return between(value, pattern.lowerBound, and: pattern.upperBound)
}

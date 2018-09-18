//
//  Between.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

/**
 Creates a Core Data `BETWEEN` predicate.
 
 For example:
 
 ```
 query.filter(between(Employee.e.salary, 70_000, 100_000))
 ```
 */
public func between(_ lhs: Expression, _ lowerBound: Expression, and upperBound: Expression, options: NSComparisonPredicate.Options = []) -> NSPredicate {
    return NSComparisonPredicate(leftExpression: lhs.cdqiExpression, rightExpression: NSExpression(forAggregate: [lowerBound.cdqiExpression, upperBound.cdqiExpression]), modifier: .direct, type: .between, options: options)
}

public extension Expression where Self: TypeComparable {
    /**
     Creates a Core Data `BETWEEN` predicate from the receiver.
     
     For example:
     
     ```
     query.filter(Employee.e.salary.cdqiBetween(70_000, and: 100_000))
     ```
    */
    func cdqiBetween<R1: Expression & TypeComparable, R2: Expression & TypeComparable>(_ lowerBound: R1, and upperBound: R2, options: NSComparisonPredicate.Options = []) -> NSPredicate where CDQIComparableType == R1.CDQIComparableType, CDQIComparableType == R2.CDQIComparableType {
        return between(self, lowerBound, and: upperBound, options: options)
    }
}

/**
 Creates a Core Data `BETWEEN` predicate.
 
 For example:
 
 ```
 query.filter(70_000...100_000 ~= Employee.e.salary)
 ```
 */
public func ~=<L: Expression & TypeComparable & Comparable, R: Expression & Inconstant & TypeComparable>(pattern: ClosedRange<L>, value: R) -> NSPredicate where L.CDQIComparableType == R.CDQIComparableType {
    return between(value, pattern.lowerBound, and: pattern.upperBound)
}

//
//  Comparisons.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 9/25/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

public func aggregate<S: Sequence>(_ expressions: S) -> ExpressionConvertible where S.Iterator.Element: ExpressionConvertible {
    let items = expressions.map{ $0.cdqiExpression }
    return NSExpression(forAggregate: items)
}

public func compare(_ lhs: ExpressionConvertible, _ op: NSComparisonPredicate.Operator, _ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
    let (le, re) = (lhs.cdqiExpression, rhs.cdqiExpression)
    return NSComparisonPredicate(leftExpression: le, rightExpression: re, modifier: .direct, type: op, options: options)
}

public func equalTo(_ lhs: ExpressionConvertible, _ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
    return compare(lhs, .equalTo, rhs, options: options)
}

public func notEqualTo(_ lhs: ExpressionConvertible, _ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
    return compare(lhs, .notEqualTo, rhs, options: options)
}

public func lessThan(_ lhs: ExpressionConvertible, _ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
    return compare(lhs, .lessThan, rhs, options: options)
}

public func lessThanOrEqualTo(_ lhs: ExpressionConvertible, _ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
    return compare(lhs, .lessThanOrEqualTo, rhs, options: options)
}

public func greaterThan(_ lhs: ExpressionConvertible, _ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
    return compare(lhs, .greaterThan, rhs, options: options)
}

public func greaterThanOrEqualTo(_ lhs: ExpressionConvertible, _ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
    return compare(lhs, .greaterThanOrEqualTo, rhs, options: options)
}

public func among<R: Sequence>(_ lhs: ExpressionConvertible, _ rhs: R, options: NSComparisonPredicate.Options = []) -> NSPredicate where R.Iterator.Element: ExpressionConvertible {
    return compare(lhs, .in, aggregate(rhs), options: options)
}

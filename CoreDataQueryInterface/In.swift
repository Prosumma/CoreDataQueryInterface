//
//  In.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

public func `in`<Expressions: Sequence>(_ lhs: Expression, _ rhs: Expressions, options: NSComparisonPredicate.Options = []) -> NSPredicate where Expressions.Element: Expression {
    return NSComparisonPredicate(leftExpression: lhs.cdqiExpression, rightExpression: NSExpression(forAggregate: rhs.map(\.cdqiExpression)), modifier: .direct, type: .in, options: options)
}

public func `in`<E: Expression>(_ lhs: Expression, _ rhs: E...) -> NSPredicate {
    return `in`(lhs, rhs)
}

public func ==<L: Expression & Inconstant & TypeComparable, R: Expression & TypeComparable, Expressions: Sequence>(lhs: L, rhs: Expressions) -> NSPredicate where L.CDQIComparableType == R.CDQIComparableType, Expressions.Element == R {
    return `in`(lhs, rhs)
}

public func ==<L: Expression & TypeComparable, R: Expression & Inconstant & TypeComparable, Expressions: Sequence>(lhs: Expressions, rhs: R) -> NSPredicate where L.CDQIComparableType == R.CDQIComparableType, Expressions.Element == L {
    return `in`(rhs, lhs)
}

public func !=<L: Expression & Inconstant & TypeComparable, R: Expression & TypeComparable, Expressions: Sequence>(lhs: L, rhs: Expressions) -> NSPredicate where L.CDQIComparableType == R.CDQIComparableType, Expressions.Element == R {
    return !`in`(lhs, rhs)
}

public func !=<L: Expression & TypeComparable, R: Expression & Inconstant & TypeComparable, Expressions: Sequence>(lhs: Expressions, rhs: R) -> NSPredicate where L.CDQIComparableType == R.CDQIComparableType, Expressions.Element == L {
    return !`in`(rhs, lhs)
}

public extension Expression where Self: TypeComparable {
    
    func cdqiIn<Expressions: Sequence, E: Expression & TypeComparable>(_ rhs: Expressions, options: NSComparisonPredicate.Options = []) -> NSPredicate where Expressions.Element == E, CDQIComparableType == E.CDQIComparableType {
        return `in`(self, rhs, options: options)
    }
    
    func cdqiIn<E: Expression & TypeComparable>(_ rhs: E...) -> NSPredicate where CDQIComparableType == E.CDQIComparableType {
        return cdqiIn(rhs)
    }
}

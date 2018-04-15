//
//  GreaterThan.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

public func greaterThan(_ lhs: Expression, _ rhs: Expression, options: NSComparisonPredicate.Options = []) -> NSPredicate {
    return NSComparisonPredicate(leftExpression: lhs.cdqiExpression, rightExpression: rhs.cdqiExpression, modifier: .direct, type: .greaterThan, options: options)
}

public func ><L: Expression & Inconstant & TypeComparable, R: Expression & TypeComparable>(lhs: L, rhs: R) -> NSPredicate where L.CDQIComparableType == R.CDQIComparableType {
    return greaterThan(lhs, rhs)
}

public func ><L: Expression & TypeComparable, R: Expression & Inconstant & TypeComparable>(lhs: L, rhs: R) -> NSPredicate where L.CDQIComparableType == R.CDQIComparableType {
    return greaterThan(lhs, rhs)
}

public func ><L: Expression & Inconstant>(lhs: L, rhs: Null) -> NSPredicate {
    return greaterThan(lhs, rhs)
}

public func ><R: Expression & Inconstant>(lhs: Null, rhs: R) -> NSPredicate {
    return greaterThan(lhs, rhs)
}

public extension Expression where Self: TypeComparable {
    
    func cdqiGreaterThan<E: Expression & TypeComparable>(_ rhs: E, options: NSComparisonPredicate.Options = []) -> NSPredicate where CDQIComparableType == E.CDQIComparableType {
        return greaterThan(self, rhs, options: options)
    }
    
}

public extension Expression {
    
    func cdqiGreaterThan(_ null: Null) -> NSPredicate {
        return greaterThan(self, null)
    }
    
}



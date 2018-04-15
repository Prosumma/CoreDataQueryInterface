//
//  LessThanOrEqualTo.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

func lessThanOrEqualTo(_ lhs: Expression, _ rhs: Expression, options: NSComparisonPredicate.Options = []) -> NSPredicate {
    return NSComparisonPredicate(leftExpression: lhs.cdqiExpression, rightExpression: rhs.cdqiExpression, modifier: .direct, type: .lessThanOrEqualTo, options: options)
}

func <=<L: Expression & Inconstant & TypeComparable, R: Expression & TypeComparable>(lhs: L, rhs: R) -> NSPredicate where L.CDQIComparableType == R.CDQIComparableType {
    return lessThanOrEqualTo(lhs, rhs)
}

func <=<L: Expression & TypeComparable, R: Expression & Inconstant & TypeComparable>(lhs: L, rhs: R) -> NSPredicate where L.CDQIComparableType == R.CDQIComparableType {
    return lessThanOrEqualTo(lhs, rhs)
}

func <=<L: Expression & Inconstant>(lhs: L, rhs: Null) -> NSPredicate {
    return lessThanOrEqualTo(lhs, rhs)
}

func <=<R: Expression & Inconstant>(lhs: Null, rhs: R) -> NSPredicate {
    return lessThanOrEqualTo(lhs, rhs)
}

extension Expression where Self: TypeComparable {
    
    func cdqiLessThanOrEqualTo<E: Expression & TypeComparable>(_ rhs: E, options: NSComparisonPredicate.Options = []) -> NSPredicate where CDQIComparableType == E.CDQIComparableType {
        return lessThanOrEqualTo(self, rhs, options: options)
    }
    
}

extension Expression {
    
    func cdqiLessThanOrEqualTo(_ null: Null) -> NSPredicate {
        return lessThanOrEqualTo(self, null)
    }
    
}


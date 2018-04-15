//
//  NotEqualTo.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

func notEqualTo(_ lhs: Expression, _ rhs: Expression, options: NSComparisonPredicate.Options = [], modifier: NSComparisonPredicate.Modifier = .direct) -> NSPredicate {
    return NSComparisonPredicate(leftExpression: lhs.cdqiExpression, rightExpression: rhs.cdqiExpression, modifier: modifier, type: .notEqualTo, options: options)
}

func !=<L: Expression & Inconstant & TypeComparable, R: Expression & TypeComparable>(lhs: L, rhs: R) -> NSPredicate where L.CDQIComparableType == R.CDQIComparableType {
    return notEqualTo(lhs, rhs)
}

func !=<L: Expression & Inconstant>(lhs: L, rhs: Null) -> NSPredicate {
    return notEqualTo(lhs, rhs)
}

extension Expression where Self: TypeComparable {
    
    func cdqiNotEqualTo<E: Expression & TypeComparable>(_ rhs: E, options: NSComparisonPredicate.Options = [], modifier: NSComparisonPredicate.Modifier = .direct) -> NSPredicate where CDQIComparableType == E.CDQIComparableType {
        return notEqualTo(self, rhs, options: options, modifier: modifier)
    }
    
}

extension Expression {
    
    func cdqiNotEqualTo(_ null: Null) -> NSPredicate {
        return notEqualTo(self, null)
    }
    
}

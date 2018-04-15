//
//  EqualTo.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

public func equalTo(_ lhs: Expression, _ rhs: Expression, options: NSComparisonPredicate.Options = []) -> NSPredicate {
    return NSComparisonPredicate(leftExpression: lhs.cdqiExpression, rightExpression: rhs.cdqiExpression, modifier: .direct, type: .equalTo, options: options)
}

public func ==<L: Expression & Inconstant & TypeComparable, R: Expression & TypeComparable>(lhs: L, rhs: R) -> NSPredicate where L.CDQIComparableType == R.CDQIComparableType {
    return equalTo(lhs, rhs)
}

public func ==<L: Expression & TypeComparable, R: Expression & Inconstant & TypeComparable>(lhs: L, rhs: R) -> NSPredicate where L.CDQIComparableType == R.CDQIComparableType {
    return equalTo(lhs, rhs)
}

public func ==<L: Expression & Inconstant>(lhs: L, rhs: Null) -> NSPredicate {
    return equalTo(lhs, rhs)
}

public func ==<R: Expression & Inconstant>(lhs: Null, rhs: R) -> NSPredicate {
    return equalTo(lhs, rhs)
}

public extension Expression where Self: TypeComparable {
    
    func cdqiEqualTo<E: Expression & TypeComparable>(_ rhs: E, options: NSComparisonPredicate.Options = []) -> NSPredicate where CDQIComparableType == E.CDQIComparableType {
        return equalTo(self, rhs, options: options)
    }
    
}

public extension Expression {
    
    func cdqiEqualTo(_ null: Null) -> NSPredicate {
        return equalTo(self, null)
    }
    
}


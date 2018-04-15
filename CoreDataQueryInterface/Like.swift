//
//  Like.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

import CoreData
import Foundation

public func like<L: Expression & TypeComparable>(_ lhs: L, _ rhs: String, options: NSComparisonPredicate.Options = []) -> NSPredicate where L.CDQIComparableType == String {
    return NSComparisonPredicate(leftExpression: lhs.cdqiExpression, rightExpression: NSExpression(forConstantValue: rhs), modifier: .direct, type: .like, options: options)
}

public extension Expression where Self: TypeComparable, Self.CDQIComparableType == String {
    
    func cdqiLike(_ rhs: String, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return like(self, rhs, options: options)
    }
    
}

public func ~=<R: Expression & Inconstant & TypeComparable>(pattern: String, value: R) -> NSPredicate where R.CDQIComparableType == String {
    return like(value, pattern)
}

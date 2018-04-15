//
//  Contains.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public func contains<L: Expression & TypeComparable>(_ lhs: L, _ rhs: String, options: NSComparisonPredicate.Options = []) -> NSPredicate where L.CDQIComparableType == String {
    return NSComparisonPredicate(leftExpression: lhs.cdqiExpression, rightExpression: NSExpression(forConstantValue: rhs), modifier: .direct, type: .contains, options: options)
}

public extension Expression where Self: TypeComparable, Self.CDQIComparableType == String {
    
    func cdqiContains(_ rhs: String, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return contains(self, rhs, options: options)
    }
    
}


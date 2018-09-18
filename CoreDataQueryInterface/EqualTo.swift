//
//  EqualTo.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

/**
 Creates a Core Data `=` predicate.
 
 ```
 query.filter(equalTo(Employee.e.lastName, "Smith"))
 ```
 */
public func equalTo(_ lhs: Expression, _ rhs: Expression, options: NSComparisonPredicate.Options = []) -> NSPredicate {
    return NSComparisonPredicate(leftExpression: lhs.cdqiExpression, rightExpression: rhs.cdqiExpression, modifier: .direct, type: .equalTo, options: options)
}

/**
 Creates a Core Data `=` predicate.
 
 ```
 query.filter(Employee.e.lastName == "Smith")
 ```
 */
public func ==<L: Expression & Inconstant & TypeComparable, R: Expression & TypeComparable>(lhs: L, rhs: R) -> NSPredicate where L.CDQIComparableType == R.CDQIComparableType {
    return equalTo(lhs, rhs)
}

/**
 Creates a Core Data `=` predicate.
 
 ```
 query.filter("Smith" == Employee.e.lastName)
 ```
 */
public func ==<L: Expression & TypeComparable, R: Expression & Inconstant & TypeComparable>(lhs: L, rhs: R) -> NSPredicate where L.CDQIComparableType == R.CDQIComparableType {
    return equalTo(lhs, rhs)
}

/**
 Creates a Core Data `=` predicate where the right-hand side is `nil`/`NULL`.
 
 ```
 query.filter(Employee.e.lastName == nil)
 ```
 */
public func ==<L: Expression & Inconstant>(lhs: L, rhs: Null) -> NSPredicate {
    return equalTo(lhs, rhs)
}

/**
 Creates a Core Data `=` predicate where the left-hand side is `nil`/`NULL`.
 
 ```
 query.filter(nil == Employee.e.lastName)
 ```
 */
public func ==<R: Expression & Inconstant>(lhs: Null, rhs: R) -> NSPredicate {
    return equalTo(lhs, rhs)
}

public extension Expression where Self: TypeComparable {
    
    /**
     Creates a Core Data `=` predicate from the receiver.
     
     ```
     query.filter(Employee.e.lastName.cdqiEqualTo("Smith"))
     ```
    */
    func cdqiEqualTo<E: Expression & TypeComparable>(_ rhs: E, options: NSComparisonPredicate.Options = []) -> NSPredicate where CDQIComparableType == E.CDQIComparableType {
        return equalTo(self, rhs, options: options)
    }
    
}

public extension Expression {
    
    /**
     Creates a Core Data `=` predicate from the receiver, for comparison to `nil`/`NULL`.
     
     ```
     query.filter(Employee.e.lastName.cdqiEqualTo(nil))
     ```
    */
    func cdqiEqualTo(_ null: Null) -> NSPredicate {
        return equalTo(self, null)
    }
    
}


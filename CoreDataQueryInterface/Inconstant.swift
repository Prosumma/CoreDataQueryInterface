//
//  Inconstant.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

#warning("Rename this!")

/**
 A protocol which allows clean overloading of Swift's built-in operators.
 
 CDQI overloads Swift's built-in operators such as `==` to produce
 `NSPredicate` instead of `Bool`. The problem is that such overloading
 could potentially confuse the compiler about which overload of an
 operator is intended, causing compilation to fail.
 
 The solution is that at least one participant in a CDQI predicate
 must implement `Inconstant`.
 
 ```
 filter(Person.e.age >= 30)
 ```
 
 In the example above, the `age` property is an `Int16Attribute`, and
 all attributes implement `Inconstant`, thus causing the expression
 `Person.e.age >= 30` to return `NSPredicate` instead of `Bool`.
 
 In the vast majority of cases in CDQI, this interface can be ignored,
 as it is already implemented where it needs to be.
 */
public protocol Inconstant {}


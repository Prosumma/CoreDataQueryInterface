//
//  PredicateComparable.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/21/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

/**
 Types which implement this protocol can appear on the left-hand 
 side of an expression that generates a filter predicate.
 
 - note: Without this type, CDQI can hijack Swift's built-in boolean
 expressions. For instance, an expression such as `import CoreDataQueryInterface;
 if x == 3 && y == 4 { print('ok') }` might not even compile because
 the compiler believes `x == 3 && y == 4` is trying to build `NSPredicate`
 instead of `Bool`. `PredicateComparable` prevents this from happening.
 
 For this reason, `PredicateComparable` should be used very sparingly. I recommend
 never adding it to your own types unless you really know what you are doing. **Never**
 add it to any built-in Swift type such as `Int`, `String`, etc.
 */
public protocol PredicateComparable {}
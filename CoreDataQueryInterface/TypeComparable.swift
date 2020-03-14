//
//  TypeComparable.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

/**
 A protocol that allows types to be compared whose `CDQIComparableType`
 is the same.
 
 CDQI supports a small DSL for generating `NSPredicate` instances
 for use in Core Data:
 
 ```
 filter(Person.e.age > 30)
 ```
 
 In this case, `age` is an `Int32Attribute`, which implements `TypeComparable`.
 `30` is an `Int` which also implements `TypeComparable`. Because both of
 these types have a `CDQIComparableType` of `NSNumber`, the above code
 compiles and works properly. However, if one were to say…
 
 ```
 filter(Person.e.age == "30")
 ```
 
 this would not compile. `String` *does* implement `TypeComparable`, but its
 `CDQIComparableType` is `String`, not `NSNumber`, which means it cannot
 participate in a comparison with `Person.e.age`.
 
 - note: In addition to implementing `TypeComparable`, at least one
 side of a comparison must also implement `Inconstant`.
 */
public protocol TypeComparable {
    /// Any two `TypeComparable` instances having the same `CDQIComparableType` may be compared.
    associatedtype CDQIComparableType: TypeComparable = Self
}

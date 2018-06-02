//
//  NSPredicate.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

public func &&(lhs: NSPredicate, rhs: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(andPredicateWithSubpredicates: [lhs, rhs])
}

public func &&<E>(lhs: NSPredicate, rhs: E) -> NSPredicate where E: Expression & TypeComparable, E.CDQIComparableType == Bool {
    return lhs && equalTo(rhs, true)
}

public func &&<E>(lhs: E, rhs: NSPredicate) -> NSPredicate where E: Expression & TypeComparable, E.CDQIComparableType == Bool {
    return equalTo(lhs, true) && rhs
}

public func &&<E1, E2>(lhs: E1, rhs: E2) -> NSPredicate where E1: Expression & Inconstant & TypeComparable, E1.CDQIComparableType == Bool, E2: Expression & TypeComparable, E2.CDQIComparableType == Bool {
    return equalTo(lhs, true) && equalTo(rhs, true)
}

public func &&<E1, E2>(lhs: E1, rhs: E2) -> NSPredicate where E1: Expression & TypeComparable, E1.CDQIComparableType == Bool, E2: Expression & Inconstant & TypeComparable, E2.CDQIComparableType == Bool {
    return equalTo(lhs, true) && equalTo(rhs, true)
}

public func ||(lhs: NSPredicate, rhs: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(orPredicateWithSubpredicates: [lhs, rhs])
}

public func ||<E>(lhs: NSPredicate, rhs: E) -> NSPredicate where E: Expression & TypeComparable, E.CDQIComparableType == Bool {
    return lhs || equalTo(rhs, true)
}

public func ||<E>(lhs: E, rhs: NSPredicate) -> NSPredicate where E: Expression & TypeComparable, E.CDQIComparableType == Bool {
    return equalTo(lhs, true) || rhs
}

public func ||<E1, E2>(lhs: E1, rhs: E2) -> NSPredicate where E1: Expression & Inconstant & TypeComparable, E1.CDQIComparableType == Bool, E2: Expression & TypeComparable, E2.CDQIComparableType == Bool {
    return equalTo(lhs, true) || equalTo(rhs, true)
}

public func ||<E1, E2>(lhs: E1, rhs: E2) -> NSPredicate where E1: Expression & TypeComparable, E1.CDQIComparableType == Bool, E2: Expression & Inconstant & TypeComparable, E2.CDQIComparableType == Bool {
    return equalTo(lhs, true) || equalTo(rhs, true)
}

public prefix func !(predicate: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(notPredicateWithSubpredicate: predicate)
}

public prefix func !<E>(predicate: E) -> NSPredicate where E: Expression & Inconstant & TypeComparable, E.CDQIComparableType == Bool {
    return notEqualTo(predicate, true)
}

public func any(_ predicate: NSPredicate) -> NSPredicate {
    return NSPredicate(format: "ANY \(predicate)")
}

public func none(_ predicate: NSPredicate) -> NSPredicate {
    return NSPredicate(format: "NONE \(predicate)")
}

public func all(_ predicate: NSPredicate) -> NSPredicate {
    return NSPredicate(format: "ALL \(predicate)")
}

//
//  Predicate.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

public func &&(lhs: NSPredicate, rhs: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(andPredicateWithSubpredicates: [lhs, rhs])
}

public func ||(lhs: NSPredicate, rhs: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(orPredicateWithSubpredicates: [lhs, rhs])
}

public prefix func !(predicate: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(notPredicateWithSubpredicate: predicate)
}

public func any(predicate: NSPredicate) -> NSPredicate {
    return NSPredicate(format: "ANY \(predicate)")
}

public func some(predicate: NSPredicate) -> NSPredicate {
    return NSPredicate(format: "SOME \(predicate)")
}

public func none(predicate: NSPredicate) -> NSPredicate {
    return NSPredicate(format: "NONE \(predicate)")
}

public func all(predicate: NSPredicate) -> NSPredicate {
    return NSPredicate(format: "ALL \(predicate)")
}

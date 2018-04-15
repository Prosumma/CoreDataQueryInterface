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

public func ||(lhs: NSPredicate, rhs: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(orPredicateWithSubpredicates: [lhs, rhs])
}

prefix func !(predicate: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(notPredicateWithSubpredicate: predicate)
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

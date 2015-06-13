//
//  Predicate.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

public func &&(lhs: NSPredicate, rhs: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate.andPredicateWithSubpredicates([lhs, rhs])
}

public func ||(lhs: NSPredicate, rhs: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate.orPredicateWithSubpredicates([lhs, rhs])
}

public prefix func !(predicate: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate.notPredicateWithSubpredicate(predicate)
}

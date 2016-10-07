//
//  Predicate.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 9/25/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

public func &&(lhs: NSPredicate, rhs: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(andPredicateWithSubpredicates: [lhs, rhs])
}

public func ||(lhs: NSPredicate, rhs: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(orPredicateWithSubpredicates: [lhs, rhs])
}

public prefix func !(predicate: NSPredicate) -> NSPredicate {
    return not(predicate)
}

public func all(_ predicate: NSPredicate) -> NSPredicate {
    return NSPredicate(format: "ALL \(predicate)")
}

public func any(_ predicate: NSPredicate) -> NSPredicate {
    return NSPredicate(format: "ANY \(predicate)")
}

public func some(_ predicate: NSPredicate) -> NSPredicate {
    return NSPredicate(format: "SOME \(predicate)")
}

public func none(_ predicate: NSPredicate) -> NSPredicate {
    return NSPredicate(format: "NONE \(predicate)")
}

public func not(_ predicate: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(notPredicateWithSubpredicate: predicate)
}

extension NSPredicate {
    public func cdqiAll() -> NSPredicate {
        return all(self)
    }
    public func cdqiAny() -> NSPredicate {
        return any(self)
    }
    public func cdqiSome() -> NSPredicate {
        return some(self)
    }
    public func cdqiNone() -> NSPredicate {
        return none(self)
    }
    public func cdqiNot() -> NSPredicate {
        return !self
    }
}

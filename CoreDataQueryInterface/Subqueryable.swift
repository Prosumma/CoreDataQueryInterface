//
//  Subqueryable.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public protocol Subqueryable {
    func cdqiSubquery(_ where: (Self) -> NSPredicate) -> Subquery
}

public extension Subqueryable where Self: EntityAttribute {
    func cdqiSubquery(_ where: (Self) -> NSPredicate) -> Subquery {
        let substvar = "v\(UUID().uuidString.prefix(8).lowercased())"
        let variable = Self.init(variable: substvar)
        return subquery(self, variable: substvar, predicate: `where`(variable))
    }
}

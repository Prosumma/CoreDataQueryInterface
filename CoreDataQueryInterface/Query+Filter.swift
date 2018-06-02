//
//  Query+Filter.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

public extension Query {
    
    func refilter() -> Query<M, R> {
        var query = self
        query.predicates = []
        return query
    }
    
    func filter(_ predicate: NSPredicate) -> Query<M, R> {
        var query = self
        query.predicates.append(predicate)
        return query
    }
    
    func filter<E>(_ expression: E) -> Query<M, R> where E: Expression & TypeComparable, E.CDQIComparableType == Bool {
        return filter(equalTo(expression, true))
    }
    
    func filter(_ where: Make<NSPredicate>) -> Query<M, R> {
        return filter(`where`(entity))
    }
}

//
//  Query+Filter.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

public extension Query {
    
    /// Removes all previously specified filters from the query.
    func refilter() -> Query<M, R> {
        var query = self
        query.predicates = []
        return query
    }
    
    /**
     Filter a query by `NSPredicate`.

     While an `NSPredicate` can be passed directly to this
     method, it is much better to use CDQI's attribute predicates,
     like so:
     
     ```
     query.filter(Person.e.age >= 18)
     // Alternatively:
     query.filter{ $0.age >= 18 }
     ```
    */
    func filter(_ predicate: NSPredicate) -> Query<M, R> {
        var query = self
        query.predicates.append(predicate)
        return query
    }
    
    /**
     Filter a query by a Boolean expression.
     
     This method is a convenience so that it is not necessary
     to compare a Boolean attribute to true. It is enough to say…
     
     ```
     query.filter(Person.e.awesome)
     ```
     
     It is not necessary to say…
     
     ```
     query.filter(Person.e.awesome == true)
     ```
     */
    func filter<E>(_ expression: E) -> Query<M, R> where E: Expression & TypeComparable, E.CDQIComparableType == Bool {
        return filter(equalTo(expression, true))
    }
    
    /**
     Filters a query by the `NSPredicate` returned as a result of executing
     the `where` function.
     
     This is easier that it sounds. A default instance of query's entity attribute
     is passed and can be used to generate a predicate, e.g.,
     
     ```
     managedObjectContext
        .from(Person.self)
        .filter{ person in person.age > 20 }
     ```
     */
    func filter(_ where: MakeResult<NSPredicate>) -> Query<M, R> {
        return filter(`where`(entity))
    }
}

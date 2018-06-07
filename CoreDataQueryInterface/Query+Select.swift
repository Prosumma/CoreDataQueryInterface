//
//  Query+Select.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public extension Query {
    
    func reselect() -> Query<M, R> {
        var query = self
        query.propertiesToFetch = []
        return query
    }
    
    func select(_ properties: [NSPropertyDescription]) -> Query<M, R> {
        var query = self
        query.propertiesToFetch.append(contentsOf: properties)
        return query
    }
    
    func select(_ properties: NSPropertyDescription...) -> Query<M, R> {
        return select(properties)
    }

    func select(_ expressions: [Property]) -> Query<M, R> {
        return select(expressions.map(NSExpressionDescription.init))
    }
    
    func select(_ expressions: Property...) -> Query<M, R> {
        return select(expressions)
    }
    
    func select(_ selector: MakeResult<[Property]>) -> Query<M, R> {
        return select(selector(entity))
    }
    
    func select(_ selectors: MakeResult<Property>...) -> Query<M, R> {
        return select(selectors.map { $0(entity) })
    }
    
    func select<K: Property>(_ keyPaths: [KeyPath<E, K>]) -> Query<M, R> {
        return select(keyPaths.map{ entity[keyPath: $0] })
    }
    
    func select<K: Property>(_ keyPaths: KeyPath<E, K>...) -> Query<M, R> {
        return select(keyPaths)
    }
}

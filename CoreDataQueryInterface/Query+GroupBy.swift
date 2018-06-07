//
//  Query+GroupBy.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public extension Query {
    
    public func regroup() -> Query<M, R> {
        var query = self
        query.propertiesToGroupBy = []
        return query
    }
    
    public func group(by properties: [NSPropertyDescription]) -> Query<M, NSDictionary> {
        var query = Query<M, NSDictionary>(self)
        query.propertiesToGroupBy.append(contentsOf: properties)
        return query
    }
    
    public func group(by properties: NSPropertyDescription...) -> Query<M, NSDictionary> {
        return group(by: properties)
    }
    
    public func group(by expressions: [Property]) -> Query<M, NSDictionary> {
        return group(by: expressions.map(NSExpressionDescription.init))
    }
    
    public func group(by expressions: Property...) -> Query<M, NSDictionary> {
        return group(by: expressions)
    }
    
    public func groupBy(_ grouper: MakeResult<[Property]>) -> Query<M, NSDictionary> {
        return group(by: grouper(entity))
    }
    
    public func groupBy(_ grouper: MakeResult<Property>...) -> Query<M, NSDictionary> {
        return group(by: grouper.map{ $0(entity) })
    }
    
    public func group<K: Property>(by keyPaths: [KeyPath<E, K>]) -> Query<M, NSDictionary> {
        return group(by: keyPaths.map{ entity[keyPath: $0] })
    }
    
    public func group<K: Property>(by keyPaths: KeyPath<E, K>...) -> Query<M, NSDictionary> {
        return group(by: keyPaths)
    }
}

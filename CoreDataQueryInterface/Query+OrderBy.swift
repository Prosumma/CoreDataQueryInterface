//
//  Query+OrderBy.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

public extension Query {
    
    func reorder() -> Query<M, R> {
        var query = self
        query.sortDescriptors = []
        return query
    }
    
    func order(by sortDescriptors: [NSSortDescriptor]) -> Query<M, R> {
        var query = self
        query.sortDescriptors.append(contentsOf: sortDescriptors)
        return query
    }
    
    func order(by sortDescriptors: NSSortDescriptor...) -> Query<M, R> {
        return order(by: sortDescriptors)
    }
    
    func order(by expressions: [KeyPathExpression]) -> Query<M, R> {
        return order(by: expressions.map { NSSortDescriptor(key: $0.cdqiKeyPath, ascending: true) })
    }
    
    func order(by expressions: KeyPathExpression...) -> Query<M, R> {
        return order(by: expressions)
    }

    func orderDesc(by expressions: [KeyPathExpression]) -> Query<M, R> {
        return order(by: expressions.map { NSSortDescriptor(key: $0.cdqiKeyPath, ascending: false) })
    }
    
    func orderDesc(by expressions: KeyPathExpression...) -> Query<M, R> {
        return orderDesc(by: expressions)
    }
    
    func orderBy(_ make: Make<[KeyPathExpression]>) -> Query<M, R> {
        return order(by: make(entity))
    }
    
    func orderBy(_ makers: Make<KeyPathExpression>...) -> Query<M, R> {
        return order(by: makers.map{ NSSortDescriptor(key: $0(entity).cdqiKeyPath, ascending: true) })
    }
    
    func orderDescBy(_ make: Make<[KeyPathExpression]>) -> Query<M, R> {
        return order(by: make(entity).map { NSSortDescriptor(key: $0.cdqiKeyPath, ascending: false) })
    }
    
    func orderDescBy(_ make: Make<KeyPathExpression>...) -> Query<M, R> {
        return order(by: make.map{ NSSortDescriptor(key: $0(entity).cdqiKeyPath, ascending: false) })
    }
    
    func order<K: KeyPathExpression>(by keyPaths: [KeyPath<E, K>]) -> Query<M, R> {
        return order(by: keyPaths.map{ NSSortDescriptor(key: entity[keyPath: $0].cdqiKeyPath, ascending: true) })
    }
    
    func order<K: KeyPathExpression>(by keyPaths: KeyPath<E, K>...) -> Query<M, R> {
        return order(by: keyPaths.map{ NSSortDescriptor(key: entity[keyPath: $0].cdqiKeyPath, ascending: true) })
    }
    
    func orderDesc<K: KeyPathExpression>(by keyPaths: [KeyPath<E, K>]) -> Query<M, R> {
        return order(by: keyPaths.map{ NSSortDescriptor(key: entity[keyPath: $0].cdqiKeyPath, ascending: false) })
    }
    
    func orderDesc<K: KeyPathExpression>(by keyPaths: KeyPath<E, K>...) -> Query<M, R> {
        return order(by: keyPaths.map{ NSSortDescriptor(key: entity[keyPath: $0].cdqiKeyPath, ascending: false) })
    }
    
}

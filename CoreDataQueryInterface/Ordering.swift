//
//  Ordering.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

extension QueryType {
    
    func order(keys: [OrderType]) -> Self {
        let descriptors = keys.map() { $0.toSortDescriptor(ascending: true) }
        var builder = self.builder
        builder.descriptors.extend(descriptors)
        return Self(builder: builder)
    }

    func order(keys: OrderType...) -> Self {
        return order(keys)
    }
    
    func order(keys: QueryEntityType.EntityAttributeType -> [OrderType]) -> Self {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return order(keys(attribute))
    }
    
    func order(keys: [QueryEntityType.EntityAttributeType -> OrderType]) -> Self {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return order(keys.map({$0(attribute)}))
    }

    func order(keys: (QueryEntityType.EntityAttributeType -> OrderType)...) -> Self {
        return order(keys)
    }
    
    func order(descending keys: [OrderType]) -> Self {
        let descriptors = keys.map() { $0.toSortDescriptor(ascending: false) }
        var builder = self.builder
        builder.descriptors.extend(descriptors)
        return Self(builder: builder)
    }
    
    func order(descending keys: OrderType...) -> Self {
        return order(descending: keys)
    }

    func order(descending keys: QueryEntityType.EntityAttributeType -> [OrderType]) -> Self {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return order(descending: keys(attribute))
    }
    
    func order(descending keys: [QueryEntityType.EntityAttributeType -> OrderType]) -> Self {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return order(descending: keys.map({$0(attribute)}))
    }
    
    func order(descending keys: (QueryEntityType.EntityAttributeType -> OrderType)...) -> Self {
        return order(descending: keys)
    }
    
}

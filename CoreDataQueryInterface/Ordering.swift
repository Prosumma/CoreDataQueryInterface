//
//  Ordering.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

extension QueryType {
    
    /**
    Sorts ascending by the given keys. However, if `NSSortDescriptor`s are passed,
    their implicit direction is honored.
    
    `order(NSSortDescriptor(key: "foo", ascending: false))` sorts _descending_, but
    `order("foo")` sorts _ascending_.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: An array of elements implementing the `OrderType` protocol.
    */
    func order(keys: [OrderType]) -> Self {
        let descriptors = keys.map() { $0.toSortDescriptor(ascending: true) }
        var builder = self.builder
        builder.descriptors.extend(descriptors)
        return Self(builder: builder)
    }

    /**
    Sorts ascending by the given keys. However, if `NSSortDescriptor`s are passed,
    their implicit direction is honored.
    
    `order(NSSortDescriptor(key: "foo", ascending: false))` sorts _descending_, but
    `order("foo")` sorts _ascending_.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: An array of elements implementing the `OrderType` protocol.
    */
    func order(keys: OrderType...) -> Self {
        return order(keys)
    }

    /**
    Sorts ascending by the keys returned from the block.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: A block which returns an array of `OrderType`s to sort by.
    */
    func order(keys: QueryEntityType.EntityAttributeType -> [OrderType]) -> Self {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return order(keys(attribute))
    }

    /**
    Sorts ascending by the keys returned from the array of blocks.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: An array of blocks each of which returns an `OrderType` for sorting.
    */
    func order(keys: [QueryEntityType.EntityAttributeType -> OrderType]) -> Self {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return order(keys.map({$0(attribute)}))
    }

    /**
    Sorts ascending by the keys returned from the array of blocks.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: An array of blocks each of which returns an `OrderType` for sorting.
    */
    func order(keys: (QueryEntityType.EntityAttributeType -> OrderType)...) -> Self {
        return order(keys)
    }
    
    /**
    Sorts descending by the given keys. However, if `NSSortDescriptor`s are passed,
    their implicit direction is honored.
    
    `order(NSSortDescriptor(key: "foo", ascending: false))` sorts _descending_, but
    `order("foo")` sorts _ascending_.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: An array of elements implementing the `OrderType` protocol.
    */
    func order(descending keys: [OrderType]) -> Self {
        let descriptors = keys.map() { $0.toSortDescriptor(ascending: false) }
        var builder = self.builder
        builder.descriptors.extend(descriptors)
        return Self(builder: builder)
    }
    
    /**
    Sorts descending by the given keys. However, if `NSSortDescriptor`s are passed,
    their implicit direction is honored.
    
    `order(NSSortDescriptor(key: "foo", ascending: false))` sorts _descending_, but
    `order("foo")` sorts _ascending_.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: An array of elements implementing the `OrderType` protocol.
    */
    func order(descending keys: OrderType...) -> Self {
        return order(descending: keys)
    }

    /**
    Sorts descending by the keys returned from the block.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: A block which returns an array of `OrderType`s to sort by.
    */
    func order(descending keys: QueryEntityType.EntityAttributeType -> [OrderType]) -> Self {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return order(descending: keys(attribute))
    }
    
    /**
    Sorts descending by the keys returned from the array of blocks.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: An array of blocks each of which returns an `OrderType` for sorting.
    */
    func order(descending keys: [QueryEntityType.EntityAttributeType -> OrderType]) -> Self {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return order(descending: keys.map({$0(attribute)}))
    }
    
    /**
    Sorts descending by the keys returned from the array of blocks.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: An array of blocks each of which returns an `OrderType` for sorting.
    */
    func order(descending keys: (QueryEntityType.EntityAttributeType -> OrderType)...) -> Self {
        return order(descending: keys)
    }
    
}

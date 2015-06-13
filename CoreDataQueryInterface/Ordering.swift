//
//  Ordering.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

extension QueryType {
    public func order(descriptors: [NSSortDescriptor]) -> Self {
        var builder = self.builder
        builder.descriptors.extend(descriptors)
        return Self(builder: builder)
    }
    public func order(descriptors: NSSortDescriptor...) -> Self {
        return order(descriptors)
    }
    public func order(keys: [String]) -> Self {
        let descriptors = keys.map() { NSSortDescriptor(key: $0, ascending: true) }
        return order(descriptors)
    }
    public func order(keys: String...) -> Self {
        return order(keys)
    }
    public func order(keys: [AttributeType]) -> Self {
        return order(keys.map({ String($0) }))
    }
    public func order(keys: AttributeType...) -> Self {
        return order(keys)
    }
    public func order(keys: QueryEntityType.EntityAttributeType -> [AttributeType]) -> Self {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return order(keys(attribute))
    }
    public func order(keys: [QueryEntityType.EntityAttributeType -> AttributeType]) -> Self {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return order(keys.map({ $0(attribute) }))
    }
    public func order(keys: (QueryEntityType.EntityAttributeType -> AttributeType)...) -> Self {
        return order(keys)
    }
    public func order(descending keys: [String]) -> Self {
        let descriptors = keys.map() { NSSortDescriptor(key: $0, ascending: false) }
        return order(descriptors)
    }
    public func order(descending keys: String...) -> Self {
        return order(descending: keys)
    }
    public func order(descending keys: [AttributeType]) -> Self {
        return order(descending: keys.map({ String($0) }))
    }
    public func order(descending keys: AttributeType...) -> Self {
        return order(descending: keys)
    }
    public func order(descending keys: QueryEntityType.EntityAttributeType -> [AttributeType]) -> Self {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return order(descending: keys(attribute))
    }
    public func order(descending keys: [QueryEntityType.EntityAttributeType -> AttributeType]) -> Self {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return order(descending: keys.map({ $0(attribute) }))
    }
    public func order(descending keys: (QueryEntityType.EntityAttributeType -> AttributeType)...) -> Self {
        return order(descending: keys)
    }
}

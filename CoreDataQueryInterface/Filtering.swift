//
//  Filter.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

extension QueryType {
    
    public func filter(predicate: NSPredicate) -> Self {
        var builder = self.builder
        builder.predicates.append(predicate)
        return Self(builder: builder)
    }
    
    public func filter(createPredicate: QueryEntityType.EntityAttributeType -> NSPredicate) -> Self {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        let predicate = createPredicate(attribute)
        return filter(predicate)
    }
    
    public func filter(format: String, arguments: CVaListPointer) -> Self {
        let predicate = NSPredicate(format: format, arguments: arguments)
        return filter(predicate)
    }
    
    public func filter(format: String, arguments: [AnyObject]) -> Self {
        let predicate = NSPredicate(format: format, argumentArray: arguments)
        return filter(predicate)
    }
    
    public func filter(format: String, _ arguments: CVarArgType...) -> Self {
        return withVaList(arguments) { arg in filter(format, arguments: arg) }
    }
}

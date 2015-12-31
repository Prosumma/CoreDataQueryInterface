//
//  Filter.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

extension QueryType {
    /**
    Filter based on the given Core Data predicate. All other
    `filter` methods feed into this one. Chain multiple `filter`
    calls to create an `&&` relationship between the predicates.
    
    - note: If you are using this method directly, you are
    most likely not getting the most out of CDQI. Try using
    one of the other overloads.
    */
    public func filter(predicate: NSPredicate) -> Self {
#if DEBUG
        debugPrint(predicate)
#endif
        var builder = self.builder
        builder.predicates.append(predicate)
        return Self(builder: builder)
    }
    
    /**
    Creates an `NSPredicate` using `AttributeType`s. For example:
    
    `moc.filter({ employee in employee.department.name == "Engineering" })`
    
    - note: This is the `filter` method you want to use.
    - parameter createPredicate: A block that takes an `AttributeType` and returns an `NSPredicate`.
    */
    public func filter(createPredicate: QueryEntityType.EntityAttributeType -> NSPredicate) -> Self {
        let attribute = QueryEntityType.EntityAttributeType()
        let predicate = createPredicate(attribute)
        return filter(predicate)
    }
    
    /**
    Creates an `NSPredicate` based on a format string and arguments, then filters, e.g.,
    
    `moc.filter("department.name == %@", "Engineering")`
    
    - note: The format string and arguments are exactly those that would be used when
    creating an `NSPredicate` instance directly.
    
    - parameter format: A standard Core Data format string, e.g., `"%K == %@"`.
    - parameter arguments: An array of `CVarArgType`s for format string substitution.
    */
    public func filter(format: String, _ arguments: CVarArgType...) -> Self {
        return withVaList(arguments) { arg in filter(NSPredicate(format: format, arguments: arg)) }
    }
}

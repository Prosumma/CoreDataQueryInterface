//
//  RequestBuilder.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public enum Expression<E: EntityMetadata> {
    case Attribute(String)
    case Function(String, String, String) // function, attribute, name
    case Description(NSExpressionDescription)
    
    public func attributeDescription(attribute: String, managedObjectContext: NSManagedObjectContext) -> NSAttributeDescription? {
        let managedObjectModel = managedObjectContext.persistentStoreCoordinator!.managedObjectModel
        let entityDescription = managedObjectModel.entitiesByName[E.entityName] as! NSEntityDescription
        return entityDescription.attributesByName[attribute] as! NSAttributeDescription?
    }
    
    public func propertyDescription(managedObjectContext: NSManagedObjectContext) -> NSPropertyDescription {
        var propertyDescription: NSPropertyDescription!
        switch self {
        case .Attribute(let attribute):
            propertyDescription = attributeDescription(attribute, managedObjectContext: managedObjectContext)!
        case let .Function(function, attribute, name):
            let expressionDescription = NSExpressionDescription()
            expressionDescription.expression = NSExpression(forFunction: function, arguments: [ NSExpression(forKeyPath: attribute) ])
            expressionDescription.expressionResultType = attributeDescription(attribute, managedObjectContext: managedObjectContext)!.attributeType
            expressionDescription.name = name
            propertyDescription = expressionDescription
        case let .Description(description):
            propertyDescription = description
        }
        return propertyDescription
    }
}

public struct QueryBuilder<E where E: EntityMetadata, E: AnyObject> {
    
    public private(set) var predicates = [NSPredicate]()
    public private(set) var fetchLimit: UInt = 0
    public private(set) var fetchOffset: UInt = 0
    public private(set) var sortDescriptors = [NSSortDescriptor]()
    public private(set) var managedObjectContext: NSManagedObjectContext!
    public private(set) var propertiesToFetch = [Expression<E>]()
    public private(set) var propertiesToGroupBy = [Expression<E>]()
    
    internal func request(_ resultType: NSFetchRequestResultType = .ManagedObjectResultType) -> NSFetchRequest {
        let request = NSFetchRequest(entityName: E.entityName)
        switch predicates.count {
        case 0: break
        case 1: request.predicate = predicates[0]
        default: request.predicate = NSCompoundPredicate(type: .AndPredicateType, subpredicates: predicates)
        }
        request.fetchLimit =  Int(fetchLimit)
        request.fetchOffset = Int(fetchOffset)
        request.sortDescriptors = sortDescriptors.count == 0 ? nil : sortDescriptors
        request.resultType = resultType
        if resultType == .DictionaryResultType {
            request.propertiesToFetch = propertiesToFetch.map() { $0.propertyDescription(self.managedObjectContext) }
            request.propertiesToGroupBy = propertiesToGroupBy.count == 0 ? nil : propertiesToGroupBy.map() { $0.propertyDescription(self.managedObjectContext) }
        }
        return request
    }
    
    public func context(managedObjectContext: NSManagedObjectContext) -> QueryBuilder<E> {
        var builder = self
        builder.managedObjectContext = managedObjectContext
        return builder
    }
    
    public func filter(predicate: NSPredicate) -> QueryBuilder<E> {
        var builder = self
        builder.predicates.append(predicate)
        return builder
    }
    
    public func limit(limit: UInt) -> QueryBuilder<E> {
        var builder = self
        builder.fetchLimit = limit
        return builder
    }
    
    public func offset(offset: UInt) -> QueryBuilder<E> {
        var builder = self
        builder.fetchOffset = offset
        return builder
    }
    
    public func order(descriptors: [NSSortDescriptor]) -> QueryBuilder<E> {
        var builder = self
        builder.sortDescriptors += descriptors
        return builder
    }
    
    public func select(expressions: [Expression<E>]) -> QueryBuilder<E> {
        var builder = self
        builder.propertiesToFetch += expressions
        return builder
    }
    
    public func select(expression: Expression<E>) -> QueryBuilder<E> {
        return select([expression])
    }
    
    public func groupBy(expressions: [Expression<E>]) -> QueryBuilder<E> {
        var builder = self
        builder.propertiesToGroupBy += expressions
        return builder
    }
}

//
//  QueryBuilder.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public struct QueryBuilder<E: EntityType> {
    public var managedObjectContext: NSManagedObjectContext?
    public var predicates = [NSPredicate]()
    public var descriptors = [NSSortDescriptor]()
    public var expressions = [Expression]() // TODO: Change this
    public var limit: UInt?
    
    public func request(managedObjectContext: NSManagedObjectContext, resultType: NSFetchRequestResultType) -> NSFetchRequest {
        let request = NSFetchRequest(entityName: E.entityName)
        request.resultType = resultType
        if let limit = limit { request.fetchLimit = Int(limit) }
        if !predicates.isEmpty { request.predicate = NSCompoundPredicate.andPredicateWithSubpredicates(predicates) }
        if !descriptors.isEmpty && resultType != .CountResultType {
            request.sortDescriptors = descriptors
        }
        if !expressions.isEmpty && resultType == .DictionaryResultType {
            var propertiesToFetch = [NSPropertyDescription]()
            let entityDescription = managedObjectContext.persistentStoreCoordinator!.managedObjectModel.entitiesByName[E.entityName]!
            for expression in expressions {
                switch expression {
                case .Property(let propertyDescription):
                    propertiesToFetch.append(propertyDescription)
                case .Attribute(let name):
                    let propertyDescription = entityDescription.propertiesByName[name]!
                    propertiesToFetch.append(propertyDescription)
                case let .Function(function, name, type):
                    let attributeDescription = entityDescription.propertiesByName[name]! as! NSAttributeDescription
                    let functionExpression = NSExpression(forFunction: function, arguments: [NSExpression(forKeyPath: name)])
                    let expressionDescription = NSExpressionDescription()
                    expressionDescription.expression = functionExpression
                    expressionDescription.expressionResultType = type ?? attributeDescription.attributeType
                    propertiesToFetch.append(expressionDescription)
                    break
                }
            }
        }
        return request
    }
    
    public func count(var managedObjectContext: NSManagedObjectContext?) throws -> UInt {
        managedObjectContext = managedObjectContext ?? self.managedObjectContext
        var error: NSError?
        let count = managedObjectContext!.countForFetchRequest(self.request(managedObjectContext!, resultType: .CountResultType), error: &error)
        guard error == nil else { throw error! }
        return UInt(count)
    }
    
    public func execute<R: AnyObject>(var managedObjectContext: NSManagedObjectContext?, resultType: NSFetchRequestResultType) throws -> [R] {
        managedObjectContext = managedObjectContext ?? self.managedObjectContext
        return try managedObjectContext!.executeFetchRequest(self.request(managedObjectContext!, resultType: resultType)) as! [R]
    }
}

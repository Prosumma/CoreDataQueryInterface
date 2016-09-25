//
//  Query.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 9/25/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public struct Query<M: NSManagedObject, R: NSFetchRequestResult> where M: Entity {
    private let builder: QueryBuilder<M>
    
    internal init(builder: QueryBuilder<M> = QueryBuilder<M>()) {
        self.builder = builder
    }
    
    public static func from(_: M.Type) -> Query<M, M> {
        return Query<M, M>()
    }
    
    public func context(managedObjectContext: NSManagedObjectContext) -> Query<M, R> {
        var builder = self.builder
        builder.managedObjectContext = managedObjectContext
        return Query<M, R>(builder: builder)
    }
    
    public func filter(_ predicate: NSPredicate) -> Query<M, R> {
        var builder = self.builder
        builder.predicates.append(predicate)
        return Query<M, R>(builder: builder)
    }
    
    public func filter(_ block: (M.CDQIAttribute) -> NSPredicate) -> Query<M, R> {
        let predicate = block(M.CDQIAttribute())
        return filter(predicate)
    }
    
    public func refilter() -> Query<M, R> {
        var builder = self.builder
        builder.predicates = []
        return Query<M, R>(builder: builder)
    }
    
    public func select<P: Sequence>(_ properties: P) -> Query<M, NSDictionary> where P.Iterator.Element: PropertyConvertible {
        var builder = self.builder
        builder.properties.append(contentsOf: properties.map{ $0.cdqiProperty })
        return Query<M, NSDictionary>(builder: builder)
    }
    
    public func select(_ properties: PropertyConvertible...) -> Query<M, NSDictionary> {
        var builder = self.builder
        builder.properties.append(contentsOf: properties.map{ $0.cdqiProperty })
        return Query<M, NSDictionary>(builder: builder)
    }
    
    public func select(_ block: (M.CDQIAttribute) -> [PropertyConvertible]) -> Query<M, NSDictionary> {
        var builder = self.builder
        builder.properties.append(contentsOf: block(M.CDQIAttribute()).map{ $0.cdqiProperty })
        return Query<M, NSDictionary>(builder: builder)
    }
    
//    public func select() -> Query<M, NSDictionary> {
//        return Query<M, NSDictionary>(builder: builder)
//    }
//    
    public func reselect() -> Query<M, NSDictionary> {
        var builder = self.builder
        builder.properties = []
        return Query<M, NSDictionary>(builder: builder)
    }
    
    public func order<O: Sequence>(_ sortDescriptors: O, ascending: Bool = true) -> Query<M, R> where O.Iterator.Element: SortDescriptorConvertible {
        var builder = self.builder
        builder.sortDescriptors.append(contentsOf: sortDescriptors.map{ $0.cdqiSortDescriptor(ascending: ascending)  })
        return Query<M, R>(builder: builder)
    }
    
    public func order(ascending: Bool = true, _ blocks: ((M.CDQIAttribute) -> SortDescriptorConvertible)...) -> Query<M, R> {
        var builder = self.builder
        let attribute = M.CDQIAttribute()
        let sortDescriptors = blocks.map{ $0(attribute).cdqiSortDescriptor(ascending: ascending) }
        builder.sortDescriptors.append(contentsOf: sortDescriptors)
        return Query<M, R>(builder: builder)
    }
    
    public func order<O: Sequence>(ascending: Bool = true, _ blocks: O) -> Query<M, R> where O.Iterator.Element == ((M.CDQIAttribute) -> SortDescriptorConvertible) {
        var builder = self.builder
        let attribute = M.CDQIAttribute()
        let sortDescriptors = blocks.map{ $0(attribute).cdqiSortDescriptor(ascending: ascending) }
        builder.sortDescriptors.append(contentsOf: sortDescriptors)
        return Query<M, R>(builder: builder)
    }
    
    public func reorder() -> Query<M, R> {
        var builder = self.builder
        builder.sortDescriptors = []
        return Query<M, R>(builder: builder)
    }
    
    public func objects() -> Query<M, M> {
        return Query<M, M>(builder: builder)
    }
    
    public func ids() -> Query<M, NSManagedObjectID> {
        return Query<M, NSManagedObjectID>(builder: builder)
    }
    
    public func limit(_ fetchLimit: Int) -> Query<M, R> {
        var builder = self.builder
        builder.fetchLimit = fetchLimit
        return Query<M, R>(builder: builder)
    }
    
    public func request() -> NSFetchRequest<R> {
        return builder.request()
    }
    
    public func first(managedObjectContext: NSManagedObjectContext? = nil) throws -> R? {
        let results = try limit(1).all(managedObjectContext: managedObjectContext)
        return results.count == 0 ? nil : results[0]
    }
    
    public func all(managedObjectContext: NSManagedObjectContext? = nil) throws -> [R] {
        let request: NSFetchRequest<R> = builder.request()
        return try (managedObjectContext ?? builder.managedObjectContext)!.fetch(request)
    }
    
    public func array<T>(_ property: PropertyConvertible, managedObjectContext: NSManagedObjectContext? = nil) throws -> [T] {
        let results: [NSDictionary] = try reselect().select(property).all(managedObjectContext: managedObjectContext)
        if results.count == 0 { return [] }
        let key = results[0].allKeys[0]
        return results.map { $0[key]! as! T }
    }
    
    public func array<T>(managedObjectContext: NSManagedObjectContext? = nil, _ block: (M.CDQIAttribute) -> PropertyConvertible) throws -> [T] {
        return try array(block(M.CDQIAttribute()), managedObjectContext: managedObjectContext)
    }
    
    public func value<T>(_ property: PropertyConvertible, managedObjectContext: NSManagedObjectContext? = nil) throws -> T? {
        let results: [T] = try limit(1).array(property)
        return results.count == 0 ? nil : results[0]
    }
    
    public func value<T>(managedObjectContext: NSManagedObjectContext? = nil, _ block: (M.CDQIAttribute) -> PropertyConvertible) throws -> T? {
        return try value(block(M.CDQIAttribute()), managedObjectContext: managedObjectContext)
    }
}

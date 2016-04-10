/*
The MIT License (MIT)

Copyright (c) 2015 Gregory Higley (Prosumma)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import CoreData
import Foundation

/**
Constructs an instance of `NSFetchRequest` using the given state.
*/
public struct QueryBuilder<E: EntityType> {
    public var managedObjectContext: NSManagedObjectContext?
    public var predicates = [NSPredicate]()
    public var descriptors = [NSSortDescriptor]()
    public var expressions = [CustomPropertyConvertible]()
    public var groupings = [CustomPropertyConvertible]()
    public var limit: UInt?
    public var offset: UInt?
    public var returnsDistinctResults: Bool = false
    
    /**
    Creates a new `NSFetchRequest` using the given arguments.
    - parameter resultType: The type of request to create.
    - parameter managedObjectModel: The managed object model to use for metadata. (Used only for expression queries.)
    */
    public func request(resultType: NSFetchRequestResultType, managedObjectModel: NSManagedObjectModel) -> NSFetchRequest {
        let request = NSFetchRequest(entityName: E.entityNameInManagedObjectModel(managedObjectModel))
        request.resultType = resultType
        if let limit = limit { request.fetchLimit = Int(limit) }
        if let offset = offset { request.fetchOffset = Int(offset) }
        request.returnsDistinctResults = returnsDistinctResults
        if !predicates.isEmpty { request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates) }
        if !descriptors.isEmpty { request.sortDescriptors = descriptors }
        if !expressions.isEmpty || !groupings.isEmpty {
            if !expressions.isEmpty {
                request.propertiesToFetch = expressions.map() { $0.property }
            }
            if !groupings.isEmpty {
                request.propertiesToGroupBy = groupings.map() { $0.property }
            }
        }
        Logger.log(request)
        return request
    }
    
    public func request(resultType: NSFetchRequestResultType, managedObjectContext: NSManagedObjectContext? = nil) -> NSFetchRequest {
        let moc = managedObjectContext ?? self.managedObjectContext!
        return request(resultType, managedObjectModel: moc.persistentStoreCoordinator!.managedObjectModel)
    }
    
    public func count(managedObjectContext: NSManagedObjectContext?) -> UInt {
        let moc = managedObjectContext ?? self.managedObjectContext!
        var error: NSError?
        let count = moc.countForFetchRequest(self.request(.CountResultType, managedObjectContext: moc), error: &error)
        if error != nil {
            assertionFailure(String(error))
        }
        return UInt(count)
    }
    
    public func execute<R: AnyObject>(managedObjectContext: NSManagedObjectContext?, resultType: NSFetchRequestResultType) -> [R] {
        let moc = managedObjectContext ?? self.managedObjectContext!
        return try! moc.executeFetchRequest(self.request(resultType, managedObjectContext: moc)) as! [R]
    }
}

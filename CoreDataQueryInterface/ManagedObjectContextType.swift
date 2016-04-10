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
Extend `NSManagedObjectContext` with this protocol in your project to
benefit from these methods. Default implementations are provided.
*/
public protocol ManagedObjectContextType {
    /**
    Initiates a query whose result type is `E`.
    */
    func from<E: EntityType>(_: E.Type) -> EntityQuery<E>
    
    /**
    Inserts a newly allocated entity of type `E` into this `NSManagedObjectContext`.
    */
    func newEntity<E: NSManagedObject where E: EntityType>(_: E.Type) -> E
    
    /**
    Inserts a newly allocated entity of type `E` into this `NSManagedObjectContext`.
    */
    func newEntity<E: NSManagedObject where E: EntityType>() -> E
}

extension ManagedObjectContextType where Self: NSManagedObjectContext {
    public func from<E: EntityType>(_: E.Type) -> EntityQuery<E> {
        return EntityQuery(builder: QueryBuilder()).context(self)
    }
    
    public func newEntity<E: NSManagedObject where E: EntityType>(_: E.Type) -> E {
        return NSEntityDescription.insertNewObjectForEntityForName(E.entityNameInManagedObjectModel(persistentStoreCoordinator!.managedObjectModel), inManagedObjectContext: self) as! E
    }
    
    public func newEntity<E: NSManagedObject where E: EntityType>() -> E {
        return newEntity(E)
    }
}

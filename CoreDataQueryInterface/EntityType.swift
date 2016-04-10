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
import ObjectiveC

public protocol EntityType: class {
    associatedtype EntityAttributeType: Attribute = Attribute
    static func entityNameInManagedObjectModel(managedObjectModel: NSManagedObjectModel) -> String
}

private var EntityCache = [String: String]()
private let EntityCacheQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL)

/**
Returns the name of the entity corresponding to the current class.
- parameter aClass: The class for which to retrieve the entity
- parameter managedObjectModel: The managed object model in which to look for the entity.
- returns: The name of the entity.
*/
public func entityNameForClass(aClass: AnyClass, inManagedObjectModel managedObjectModel: NSManagedObjectModel) -> String? {
    let className = String.fromCString(class_getName(aClass))!
    var entityName: String?
    dispatch_sync(EntityCacheQueue) {
        entityName = EntityCache[className]
        if entityName == nil {
            entityName = managedObjectModel.entities.filter({ $0.managedObjectClassName == className }).first!.name!
            if entityName != nil {
                EntityCache[className] = entityName
            }
        }
    }
    return entityName
}

extension EntityType {
    /**
    Returns the name of the entity corresponding to the current class.
    - parameter managedObjectModel: The managed object model in which to look for the entity.
    - returns: The name of the entity.
    - warning: Throws an exception if the entity cannot be located.
    */
    public static func entityNameInManagedObjectModel(managedObjectModel: NSManagedObjectModel) -> String {
        return entityNameForClass(self, inManagedObjectModel: managedObjectModel)!
    }
}

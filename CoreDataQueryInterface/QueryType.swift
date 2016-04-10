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

public protocol QueryType {
    associatedtype QueryEntityType: EntityType
    associatedtype QueryResultType: AnyObject
    
    init(builder: QueryBuilder<QueryEntityType>)
    var builder: QueryBuilder<QueryEntityType> { get }
    var resultType: NSFetchRequestResultType { get }
}

extension QueryType {
    /**
    Starts a new query of the given type.
    */
    public static func from(_: QueryEntityType.Type) -> Self {
        return self.init(builder: QueryBuilder<QueryEntityType>())
    }
    
    /**
    Sets the managed object context.
    */
    public func context(managedObjectContext: NSManagedObjectContext) -> Self {
        var builder = self.builder
        builder.managedObjectContext = managedObjectContext
        return Self(builder: builder)
    }
    
    /**
    Limit the query to a certain number of records.
    */
    public func limit(limit: UInt?) -> Self {
        var builder = self.builder
        builder.limit = limit
        return Self(builder: builder)
    }
    
    /**
    Start the query at a certain offset.
    */
    public func offset(offset: UInt?) -> Self {
        var builder = self.builder
        builder.offset = offset
        return Self(builder: builder)
    }
}

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

import Foundation

extension QueryType {
    
    /**
    Sorts ascending by the given keys. However, if `NSSortDescriptor`s are passed,
    their implicit direction is honored.
    
    `order(NSSortDescriptor(key: "foo", ascending: false))` sorts _descending_, but
    `order("foo")` sorts _ascending_.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: An array of elements implementing the `CustomSortDescriptorConvertible` protocol.
    */
    public func order(keys: [CustomSortDescriptorConvertible]) -> Self {
        let descriptors = keys.map() { $0.toSortDescriptor(ascending: true) }
        var builder = self.builder
        builder.descriptors.appendContentsOf(descriptors)
        return Self(builder: builder)
    }

    /**
    Sorts ascending by the given keys. However, if `NSSortDescriptor`s are passed,
    their implicit direction is honored.
    
    `order(NSSortDescriptor(key: "foo", ascending: false))` sorts _descending_, but
    `order("foo")` sorts _ascending_.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: An array of elements implementing the `CustomSortDescriptorConvertible` protocol.
    */
    public func order(keys: CustomSortDescriptorConvertible...) -> Self {
        return order(keys)
    }

    /**
    Sorts ascending by the keys returned from the block.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: A block which returns an array of `CustomSortDescriptorConvertible`s to sort by.
    */
    public func order(@noescape keys: QueryEntityType.EntityAttributeType -> [CustomSortDescriptorConvertible]) -> Self {
        let attribute = QueryEntityType.EntityAttributeType()
        return order(keys(attribute))
    }

    /**
    Sorts ascending by the keys returned from the array of blocks.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: An array of blocks each of which returns an `CustomSortDescriptorConvertible` for sorting.
    */
    public func order(keys: [QueryEntityType.EntityAttributeType -> CustomSortDescriptorConvertible]) -> Self {
        let attribute = QueryEntityType.EntityAttributeType()
        return order(keys.map({$0(attribute)}))
    }

    /**
    Sorts ascending by the keys returned from the array of blocks.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: An array of blocks each of which returns an `CustomSortDescriptorConvertible` for sorting.
    */
    public func order(keys: (QueryEntityType.EntityAttributeType -> CustomSortDescriptorConvertible)...) -> Self {
        return order(keys)
    }
    
    /**
    Sorts descending by the given keys. However, if `NSSortDescriptor`s are passed,
    their implicit direction is honored.
    
    `order(NSSortDescriptor(key: "foo", ascending: false))` sorts _descending_, but
    `order("foo")` sorts _ascending_.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: An array of elements implementing the `CustomSortDescriptorConvertible` protocol.
    */
    public func order(descending keys: [CustomSortDescriptorConvertible]) -> Self {
        let descriptors = keys.map() { $0.toSortDescriptor(ascending: false) }
        var builder = self.builder
        builder.descriptors.appendContentsOf(descriptors)
        return Self(builder: builder)
    }
    
    /**
    Sorts descending by the given keys. However, if `NSSortDescriptor`s are passed,
    their implicit direction is honored.
    
    `order(NSSortDescriptor(key: "foo", ascending: false))` sorts _descending_, but
    `order("foo")` sorts _ascending_.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: An array of elements implementing the `CustomSortDescriptorConvertible` protocol.
    */
    public func order(descending keys: CustomSortDescriptorConvertible...) -> Self {
        return order(descending: keys)
    }

    /**
    Sorts descending by the keys returned from the block.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: A block which returns an array of `CustomSortDescriptorConvertible`s to sort by.
    */
    public func order(@noescape descending keys: QueryEntityType.EntityAttributeType -> [CustomSortDescriptorConvertible]) -> Self {
        let attribute = QueryEntityType.EntityAttributeType()
        return order(descending: keys(attribute))
    }
    
    /**
    Sorts descending by the keys returned from the array of blocks.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: An array of blocks each of which returns an `CustomSortDescriptorConvertible` for sorting.
    */
    public func order(descending keys: [QueryEntityType.EntityAttributeType -> CustomSortDescriptorConvertible]) -> Self {
        let attribute = QueryEntityType.EntityAttributeType()
        return order(descending: keys.map({$0(attribute)}))
    }
    
    /**
    Sorts descending by the keys returned from the array of blocks.
    
    `order` methods can be chained multiple times, e.g., `order(descending: "lastName").order("firstName")`
    sorts first _descending_ by `lastName` and then _ascending_ by `firstName`.
    
    - parameter keys: An array of blocks each of which returns an `CustomSortDescriptorConvertible` for sorting.
    */
    public func order(descending keys: (QueryEntityType.EntityAttributeType -> CustomSortDescriptorConvertible)...) -> Self {
        return order(descending: keys)
    }
    
    /**
    Resets any previous ordering specified in the chain.
    */
    public func reorder() -> Self {
        var builder = self.builder
        builder.descriptors = []
        return Self(builder: builder)
    }
    
}

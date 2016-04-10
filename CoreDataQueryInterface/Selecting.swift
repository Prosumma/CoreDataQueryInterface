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

extension ExpressionQueryType {

    public func select(expressions: [CustomPropertyConvertible]) -> ExpressionQuery<QueryEntityType> {
        var builder = self.builder
        builder.expressions.appendContentsOf(expressions)
        return ExpressionQuery(builder: builder)
    }
    
    public func select(expressions: CustomPropertyConvertible...) -> ExpressionQuery<QueryEntityType> {
        return select(expressions)
    }
    
    public func select(expressions: QueryEntityType.EntityAttributeType -> [CustomPropertyConvertible]) -> ExpressionQuery<QueryEntityType> {
        let attribute = QueryEntityType.EntityAttributeType()
        return select(expressions(attribute))
    }
    
    public func select(expressions: [QueryEntityType.EntityAttributeType -> CustomPropertyConvertible]) -> ExpressionQuery<QueryEntityType> {
        let attribute = QueryEntityType.EntityAttributeType()
        return select(expressions.map() { $0(attribute) })
    }
    
    public func select(expressions: (QueryEntityType.EntityAttributeType -> CustomPropertyConvertible)...) -> ExpressionQuery<QueryEntityType> {
        return select(expressions)
    }
    
    public func distinct() -> ExpressionQuery<QueryEntityType> {
        var builder = self.builder
        builder.returnsDistinctResults = true
        return ExpressionQuery(builder: builder)
    }
    
    /**
    Resets the list of selected expressions
    */
    public func reselect() -> ExpressionQuery<QueryEntityType> {
        var builder = self.builder
        builder.expressions = []
        return ExpressionQuery(builder: builder)
    }
 
}

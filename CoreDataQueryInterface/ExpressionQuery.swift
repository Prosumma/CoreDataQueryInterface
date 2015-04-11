//
//  ExpressionQuery.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public struct ExpressionQuery<E where E: EntityMetadata, E: AnyObject> {
    
    internal var builder = RequestBuilder<E>()
    
    
}

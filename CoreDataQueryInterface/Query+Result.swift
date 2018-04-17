//
//  Query+Result.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public extension Query {
    
    var ids: Query<M, NSManagedObjectID> {
        return Query<M, NSManagedObjectID>(self)
    }
    
    var objects: Query<M, M> {
        return Query<M, M>(self)
    }
    
    var items: Query<M, NSDictionary> {
        return Query<M, NSDictionary>(self)
    }
    
}

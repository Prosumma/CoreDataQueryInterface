//
//  NSManagedObjectContext.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 9/25/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension NSManagedObjectContext {
    public func from<M: NSManagedObject>(_ entity: M.Type = M.self) -> Query<M, M> where M: Entity {
        return Query<M, M>()
    }
}

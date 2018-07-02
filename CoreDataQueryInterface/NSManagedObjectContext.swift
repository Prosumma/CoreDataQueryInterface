//
//  NSManagedObjectContext.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public extension NSManagedObjectContext {
    
    func from<M: NSManagedObject & Entity>(_: M.Type = M.self) -> Query<M, M> {
        return Query().context(self)
    }
    
    func from<M: NSManagedObject & Entity>(_: M.CDQIEntityAttribute) -> Query<M, M> {
        return Query().context(self)
    }
        
    func cdqiNewEntity<E: NSManagedObject & Entity>(_: E.Type = E.self) -> E {
        return E.init(entity: E.entity(), insertInto: self)
    }
}

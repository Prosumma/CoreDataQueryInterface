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
    
    func from<M: NSManagedObject & Entity>(_ type: M.Type = M.self) -> Query<M, M> {
        return Query().context(self)
    }
    
    func cdqiNewEntity<E: NSManagedObject & Entity>(_ type: E.Type = E.self) -> E {
        return E.init(entity: E.entity(), insertInto: self)
    }
}

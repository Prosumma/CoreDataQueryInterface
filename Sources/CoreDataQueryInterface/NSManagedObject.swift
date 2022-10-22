//
//  NSManagedObject.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 2022-10-22.
//

import CoreData
import PredicateQI

extension NSManagedObject: TypeComparable {
  public typealias PQIComparisonType = NSManagedObjectID
}

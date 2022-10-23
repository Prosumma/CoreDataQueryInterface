//
//  Language.swift
//  CoreDataQueryInterfaceTests
//
//  Created by Gregory Higley on 2022-10-22.
//

import CoreData

@objc(Language)
class Language: NSManagedObject {
  @NSManaged var name: String
  @NSManaged var developers: Set<Developer>
}

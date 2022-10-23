//
//  Developer.swift
//  CoreDataQueryInterfaceTests
//
//  Created by Gregory Higley on 2022-10-22.
//

import CoreData

@objc(Developer)
class Developer: NSManagedObject {
  @NSManaged var firstName: String
  @NSManaged var lastName: String
  @NSManaged var languages: Set<Language>
}

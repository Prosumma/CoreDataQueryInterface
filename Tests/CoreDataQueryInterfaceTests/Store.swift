//
//  Store.swift
//  CoreDataQueryInterfaceTests
//
//  Created by Gregory Higley on 2022-10-22.
//

import CoreData
import CoreDataQueryInterface
import PredicateQI

enum Store {
  private static func initPersistentContainer() -> NSPersistentContainer {
    let mom = NSManagedObjectModel.mergedModel(from: [Bundle.module])!
    let container = NSPersistentContainer(name: "developers", managedObjectModel: mom)
    let store = NSPersistentStoreDescription(url: URL(fileURLWithPath: "/dev/null"))
    container.persistentStoreDescriptions = [store]
    container.loadPersistentStores { _, error in
      if let error = error {
        assertionFailure("\(error)")
      }
    }
    loadData(into: container)
    return container
  }
  
  private(set) static var container = Self.initPersistentContainer()
  
  private static func loadData(into container: NSPersistentContainer) {
    let moc = container.viewContext
    let languages = ["Swift", "Haskell", "Visual Basic", "Rust", "Ruby", "Kotlin", "Python"]
    for name in languages {
      let language = Language(context: moc)
      language.name = name
    }
    try! moc.save()
    
    let developers: [[String: Any]] = [
      ["fn": "Iulius", "ln": "Caesar", "ls": ["Ruby", "Swift"]],
      ["fn": "Benjamin", "ln": "Disraeli", "ls": ["Swift", "Kotlin"]],
      ["fn": "Gregory", "ln": "Higley", "ls": ["Swift", "Rust", "Haskell"]]
    ]
    
    for info in developers {
      let firstName = info["fn"] as! String
      let lastName = info["ln"] as! String
      let languageNames = info["ls"] as! [String]
      var languages: Set<Language> = []
      for name in languageNames {
        let language = try! moc.query(Language.self).filter { $0.name == name }.fetchFirst()!
        languages.insert(language)
      }
      let developer = Developer(context: moc)
      developer.firstName = firstName
      developer.lastName = lastName
      developer.languages = languages
    }
    try! moc.save()
  }
}

//
//  CoreDataQueryInterfaceTests.swift
//  CoreDataQueryInterfaceTests
//
//  Created by Gregory Higley on 4/10/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import UIKit
import XCTest

class CoreDataQueryInterfaceTests: XCTestCase {
    
    static let DatabaseName = "CoreDataQI.sqlite"
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        let managedObjectModel = NSManagedObjectModel.mergedModelFromBundles(NSBundle.allBundles())!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        persistentStoreCoordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil, error: nil)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        let woggam1: Woggam = managedObjectContext.newManagedObject()
        woggam1.name = "thgib"
        woggam1.size = 13
        
        let woggam2: Woggam = managedObjectContext.newManagedObject()
        woggam2.name = "eggafnord"
        woggam2.size = 7
        
        let woggam3: Woggam = managedObjectContext.newManagedObject()
        woggam3.name = "idribnagong"
        woggam3.size = 42
        
        assert(managedObjectContext.save(nil), "Seed data could not be saved.")
    }
    
    override func tearDown() {
        managedObjectContext = nil
        super.tearDown()
    }
    
    func testExpressions() {
        let woggams = managedObjectContext.from(Woggam)
        let name = woggams.order("name").select("name").first()!["name"] as! String
        XCTAssertEqual(name, "eggafnord", "\"\(name)\" and \"eggafnord\" don't match.")
    }
        
    func testSort() {
        let woggams = managedObjectContext.from(Woggam)
        let names = woggams.order("name").all()!.map() { $0.name }
        XCTAssertEqual(names, ["eggafnord", "idribnagong", "thgib"], "")
    }
    
    func testReverseSort() {
        let woggams = EntityQuery.from(Woggam)
        let names = woggams.order(descending: "name").all(managedObjectContext: managedObjectContext)!.map() { $0.name }
        XCTAssertEqual(names, ["thgib", "idribnagong", "eggafnord"], "")
    }
    
    func testIteration() {
        let woggams = managedObjectContext.from(Woggam)
        var w: UInt = 0
        for woggam in woggams {
            w++
        }
        XCTAssertEqual(w, woggams.count()!, "The number of iterations was not the same as the number of woggams.")
    }

    func testAnotherExpression() {
        let woggams = managedObjectContext.from(Woggam)
    }
    
    func testFilter() {
        let woggams = EntityQuery.from(Woggam)
        XCTAssertEqual(7, woggams.filter(NSPredicate(format: "name == %@", "eggafnord")).first(managedObjectContext: managedObjectContext)?.size ?? 0, "The query to get the size of eggafnord failed.")
    }
    
}

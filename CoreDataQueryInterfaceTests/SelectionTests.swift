//
//  SelectionTests.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/13/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation
import XCTest

class SelectionTests : BaseTestCase {
 
    func testWatusi() {
        
        let x = try! managedObjectContext.from(Employee).select({ e in Expression.max(e.salary) }).first()!
        let salary = x["salary"]! as! NSNumber
        print("Salary: \(salary)")
    }
    
}
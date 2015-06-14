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
 
    func testSelection() {
        let dictionaries = try! managedObjectContext.from(Employee).select({$0.salary}).order(descending: {$0.salary}).all()
        debugPrint(dictionaries)
    }
    
}
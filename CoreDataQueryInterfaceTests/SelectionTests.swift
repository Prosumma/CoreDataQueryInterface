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
        for dictionary in managedObjectContext.from(Employee).select("firstName") {
            debugPrint(dictionary)
        }
    }
    
}
//
//  AttributeTests.swift
//  CoreDataQueryInterface
//
//  Created by Patrick Goley on 3/30/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import XCTest

class AttributeTests: BaseTestCase {
    
    func testNumericAttributes() {
        
        let floatSalary: CGFloat = 91000.00
        let resultCount = try! managedObjectContext.from(Employee).filter({ $0.salary ** floatSalary }).count()
        XCTAssert(resultCount == 1)
    }
}

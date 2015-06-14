//
//  ExpressionHelperTests.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/14/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation
import XCTest

class ExpressionHelperTests : BaseTestCase {
    
    func testKeyPathName() {
        XCTAssertEqual("maxSalary", ExpressionHelper.nameForKeyPath("salary", prefix: "max"))
        XCTAssertEqual("departmentName", ExpressionHelper.nameForKeyPath("department.name"))
    }
    
}
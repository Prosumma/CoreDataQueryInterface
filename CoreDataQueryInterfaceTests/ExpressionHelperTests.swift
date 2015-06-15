//
//  ExpressionHelperTests.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/14/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation
import XCTest

class ExpressionHelperTests : BaseTestCase {
    
    func testKeyPathName() {
        XCTAssertEqual("maxSalary", ExpressionHelper.nameForKeyPath("salary", prefix: "max"))
        XCTAssertEqual("departmentName", ExpressionHelper.nameForKeyPath("department.name"))
    }
    
    func testFunctionName() {

    }
    
    func testKeyPathForExpression() {
        let expression = NSExpression(forFunction: "max:", arguments: [NSExpression(forKeyPath: "department.name")])
        XCTAssertEqual("department.name", ExpressionHelper.keyPathForExpression(expression)!)
    }
    
    func testFunction() {
    }
}
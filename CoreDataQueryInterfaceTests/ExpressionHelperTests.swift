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
    
    func testKeyPathForExpression() {
        let expression = NSExpression(forFunction: "max:", arguments: [NSExpression(forKeyPath: "department.name")])
        print(ExpressionHelper.keyPathForExpression(expression))
    }
    
    func testFunction() {
        let max = Function.max(NSExpression(forKeyPath: "salary"))
        let function = Function.average(max)
        let entity = managedObjectContext.persistentStoreCoordinator!.managedObjectModel.entitiesByName["Employee"]!
        let property = function.toPropertyDescription(entity) as! NSExpressionDescription
        print(property.name)
        XCTAssertEqual(property.expressionResultType, NSAttributeType.Integer32AttributeType)
    }
}
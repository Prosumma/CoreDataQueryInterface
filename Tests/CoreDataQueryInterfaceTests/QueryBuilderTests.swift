//
//  QueryBuilderTests.swift
//  CoreDataQueryInterfaceTests
//
//  Created by Gregory Higley on 2022-10-24.
//

import PredicateQI
import XCTest

@testable import CoreDataQueryInterface

final class QueryBuilderTests: XCTestCase {
  func testReset() {
    let q1 = Query(Language.self).filter { $0.name |~> "us" }.select(\.name).order(by: \.name)
    let q2 = q1.un(.filter, .order, .select)
    
    // Predicates
    XCTAssertNotEqual(q1.predicates, q2.predicates)
    XCTAssertEqual(q2.predicates.count, 0)
   
    // Order By
    XCTAssertNotEqual(q1.sortDescriptors, q2.sortDescriptors)
    XCTAssertEqual(q2.sortDescriptors.count, 0)
    
    // Select
    XCTAssertNotEqual(q1.propertiesToFetch, q2.propertiesToFetch)
    XCTAssertEqual(q2.propertiesToFetch.count, 0)
  }
}

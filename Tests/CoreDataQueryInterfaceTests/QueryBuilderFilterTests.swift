//
//  QueryBuilderFilterTests.swift
//  
//
//  Created by Greg Higley on 2022-10-22.
//

import CoreData
import CoreDataQueryInterface
import PredicateQI
import XCTest

final class QueryBuilderFilterTests: XCTestCase {
  func testFilterByRelatedEntity() throws {
    let moc = Store.container.viewContext
    let count = try moc.query(Language.self).filter { $0.developers.pqiCount == 0 }.count()
    XCTAssertEqual(count, 2)
  }
  
  func testFilterWithArgs() throws {
    let moc = Store.container.viewContext
    let count = try moc.query(Language.self).filter("%K BEGINSWITH %@", "name", "R").count()
    XCTAssertEqual(count, 2)
  }
}

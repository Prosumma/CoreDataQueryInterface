//
//  QueryBuilderGroupTests.swift
//  CoreDataQueryInterfaceTests
//
//  Created by Gregory Higley on 2022-10-24.
//

import CoreDataQueryInterface
import PredicateQI
import XCTest

final class QueryBuilderGroupTests: XCTestCase {
  func testGroupByName() throws {
    let moc = Store.container.viewContext
    let query = Query(Developer.self)
      .group(by: \.lastName, \.firstName)
      .select(\.firstName, \.lastName, \.languages.name.pqiCount.pqiFloat)
      .filter { ci($0.lastName == "higley")}
    let result = try query.fetchDictionaries(moc)
    print(result[0].keys)
    let count = result[0]["@count"] as! Int64
    XCTAssertEqual(count, 3)
  }
}

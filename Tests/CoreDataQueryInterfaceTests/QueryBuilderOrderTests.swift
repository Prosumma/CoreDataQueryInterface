//
//  QueryBuilderOrderTests.swift
//  CoreDataQueryInterfaceTests
//
//  Created by Greg Higley on 2022-10-22.
//

import CoreDataQueryInterface
import PredicateQI
import XCTest

final class QueryBuilderOrderTests: XCTestCase {
  func testOrderByName() throws {
    let moc = Store.container.viewContext
    let languages = try moc.query(Language.self).order(by: \.name).fetch()
    XCTAssertFalse(languages.isEmpty)
    XCTAssertEqual(languages.first?.name, "Haskell")
  }
}

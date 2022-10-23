//
//  QueryBuilderSelectTests.swift
//  CoreDataQueryInterfaceTests
//
//  Created by Greg Higley on 2022-10-22.
//

import CoreDataQueryInterface
import PredicateQI
import XCTest

import XCTest

final class QueryBuilderSelectTests: XCTestCase {
  func testSelectWithKeyPaths() throws {
    let moc = Store.container.viewContext
    let developers = try Query(Developer.self)
      .context(moc)
      .order(.descending, by: \.lastName, \.firstName)
      .select(\.firstName, \.lastName)
      .fetchDictionaries()
    XCTAssertFalse(developers.isEmpty)
    XCTAssertEqual(developers[0]["lastName"] as? String, "Higley")
  }
  
  func testSelectWithPropertyDescriptions() throws {
    let moc = Store.container.viewContext
    let firstName = NSExpressionDescription()
    firstName.name = "firstName"
    let developers = try moc.query(Developer.self)
      .order(.descending, by: \.lastName)
      .filter { $0.languages.where { any($0.name == "Rust") } }
      .select(firstName)
      .fetchDictionaries()
    XCTAssertFalse(developers.isEmpty)
  }
}

//
//  QueryBuilderFetchTests.swift
//  CoreDataQueryInterfaceTests
//
//  Created by Gregory Higley on 2022-10-24.
//

import CoreDataQueryInterface
import PredicateQI
import XCTest

final class QueryBuilderFetchTests: XCTestCase {
  func testFetchIDs() throws {
    let moc = Store.container.viewContext
    let ids = try Query(Language.self).fetchIDs(moc)
    XCTAssertNotEqual(ids.count, 0)
  }
  
  func testFetchObjects() throws {
    let moc = Store.container.viewContext
    let objects = try moc.query(Language.self).fetchObjects()
    XCTAssertNotEqual(objects.count, 0)
  }
  
  func testFetchDictionaries() throws {
    let moc = Store.container.viewContext
    let dictionaries = try Query(Language.self).context(moc).fetchDictionaries()
    XCTAssertNotEqual(dictionaries.count, 0)
  }
  
  func testFetchOffsetAndLimit() throws {
    let moc = Store.container.viewContext
    let developer = try Query(Developer.self).offset(1).limit(1).order(.descending, by: \.lastName).fetch(moc).first
    XCTAssertEqual(developer?.lastName, "Disraeli")
  }
}

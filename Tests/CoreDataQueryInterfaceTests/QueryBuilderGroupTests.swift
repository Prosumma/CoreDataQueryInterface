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
    watusi(type: Developer.self, \.languages.name.pqiCount)
  }
  
  func watusi<M: NSObject, V: Expression>(type: M.Type, _ keyPath: KeyPath<Object<M>, V>) {
    let o = Object<M>()
    let v = o[keyPath: keyPath]
    print(v.pqiExpression)
  }
}

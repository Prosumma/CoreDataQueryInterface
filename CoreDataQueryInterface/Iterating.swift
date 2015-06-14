//
//  Iterating.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/13/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

extension QueryType {
    public func generate() -> AnyGenerator<QueryResultType> {
        return anyGenerator((try! all()).generate())
    }
}
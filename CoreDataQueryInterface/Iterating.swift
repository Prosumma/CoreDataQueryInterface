//
//  Iterating.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/13/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

extension QueryType {
    public func generate() -> IndexingGenerator<[QueryResultType]> {
        return try! all().generate()
    }
}
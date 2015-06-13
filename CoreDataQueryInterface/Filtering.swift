//
//  Filter.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

extension QueryType {
    public func filter(predicate: NSPredicate) -> Self {
        var builder = self.builder
        builder.predicates.append(predicate)
        return Self(builder: builder)
    }
}

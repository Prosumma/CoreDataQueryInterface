//
//  Ordering.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

extension QueryType {
    public func order(descriptors: [NSSortDescriptor]) -> Self {
        var builder = self.builder
        builder.descriptors.extend(descriptors)
        return Self(builder: builder)
    }
}

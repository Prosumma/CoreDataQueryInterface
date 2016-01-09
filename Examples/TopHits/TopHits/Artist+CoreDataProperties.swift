//
//  Artist+CoreDataProperties.swift
//  TopHits
//
//  Created by Gregory Higley on 1/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Artist {

    @NSManaged var name: String?
    @NSManaged var songs: Song?

}

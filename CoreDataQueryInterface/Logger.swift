//
//  Logger.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/4/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

struct Logger {
    private static var enabled: Bool = { NSProcessInfo().arguments.contains("-com.prosumma.CoreDataQueryInterface.Debug") }()
    
    static func log(message: String) {
        if !enabled { return }
        NSLog("CoreDataQueryInterface: %@", message)
    }
    
    static func log(fetchRequest: NSFetchRequest) {
        var info = [String]()
        if let entityName = fetchRequest.entityName {
            info.append("entity: \(entityName)")
        }
        if let predicate = fetchRequest.predicate {
            info.append("predicate: \(predicate)")
        }
        if let sortDescriptors = fetchRequest.sortDescriptors where sortDescriptors.count > 0 {
            info.append("sortDescriptors: \(sortDescriptors)")
        }
        if fetchRequest.fetchLimit > 0 {
            info.append("limit: \(fetchRequest.fetchLimit)")
        }
        let type: String
        switch fetchRequest.resultType {
        case NSFetchRequestResultType.CountResultType: type = ".CountResultType"
        case NSFetchRequestResultType.DictionaryResultType: type = ".DictionaryResultType"
        case NSFetchRequestResultType.ManagedObjectIDResultType: type = ".ManagedObjectIDResultType"
        default: type = ".ManagedObjectResultType"
        }
        info.append("type: \(type)")
        log(info.joinWithSeparator(" "))
    }
}
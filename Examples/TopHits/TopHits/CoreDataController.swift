//
//  CoreDataController.swift
//  TopHits
//
//  Created by Gregory Higley on 1/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation
import CoreData
import CoreDataQueryInterface

class CoreDataController {
    static let ProgressNotification = "CoreDataControllerProgressNotification"
    static let sharedInstance = CoreDataController()
    
    private init() {}
    
    let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    
    func setup(completion: () -> Void) {
        let databaseFileName = "TopHits.db"
        let fileManager = NSFileManager.defaultManager()
        let documentPath = try! fileManager.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
        let databasePath = documentPath.URLByAppendingPathComponent(databaseFileName)
        let shouldCreateDatabase = !fileManager.fileExistsAtPath(databasePath.path!)
        let managedObjectModel = NSManagedObjectModel.mergedModelFromBundles(nil)!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        try! persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: databasePath, options: nil)
        let finish: () -> Void = {
            self.managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
            completion()
        }
        if shouldCreateDatabase {
            createDatabase(databasePath, persistentStoreCoordinator: persistentStoreCoordinator, completion: finish)
        } else {
            finish()
        }
    }
    
    private func createDatabase(path: NSURL, persistentStoreCoordinator: NSPersistentStoreCoordinator, completion: () -> Void) {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        managedObjectContext.performBlock {
            let YEAR = 0
            let POSITION = 1
            let ARTIST = 2
            let SONG = 3
            let FIELD_COUNT = 4
            
            let numberFormatter = NSNumberFormatter()
            let dataPath = NSBundle.mainBundle().pathForResource("TopHits", ofType: "psv")!
            let data = try! String(contentsOfFile: dataPath)
            var previousYear: NSNumber? = nil
            for line in data.componentsSeparatedByString("\n") {
                let fields = line.componentsSeparatedByString("|")
                if fields.count != FIELD_COUNT { continue }
                let year = numberFormatter.numberFromString(fields[YEAR])!
                if year != previousYear {
                    dispatch_async(dispatch_get_main_queue()) {
                        let userInfo = ["year": year]
                        NSNotificationCenter.defaultCenter().postNotificationName(CoreDataController.ProgressNotification, object: self, userInfo: userInfo)
                    }
                    previousYear = year
                }
                let position = numberFormatter.numberFromString(fields[POSITION])!
                let artistName = fields[ARTIST]
                let songName = fields[SONG]
                let artist = try! managedObjectContext.from(Artist).filter({$0.name == artistName}).first() ?? managedObjectContext.newEntity(Artist)
                artist.name = artistName
                let song = managedObjectContext.newEntity(Song)
                song.year = year.intValue
                song.position = position.intValue
                song.name = songName
                song.artist = artist
            }
            try! managedObjectContext.save()
            dispatch_async(dispatch_get_main_queue(), completion)
        }
    }
}
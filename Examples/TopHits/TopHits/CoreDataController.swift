/*
The MIT License (MIT)

Copyright (c) 2015 Gregory Higley (Prosumma)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

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
                let artist = managedObjectContext.from(Artist).filter({$0.name == artistName}).first() ?? managedObjectContext.newEntity(Artist)
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

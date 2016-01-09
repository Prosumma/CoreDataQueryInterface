//
//  UIViewControllerExtensions.swift
//  TopHits
//
//  Created by Gregory Higley on 1/3/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    
    var managedObjectContext: NSManagedObjectContext {
        return CoreDataController.sharedInstance.managedObjectContext
    }
    
}
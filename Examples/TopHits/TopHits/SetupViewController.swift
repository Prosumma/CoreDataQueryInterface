//
//  ViewController.swift
//  TopHits
//
//  Created by Gregory Higley on 1/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {
    
    @IBOutlet weak var applicationSubtitleLabel: UILabel!
    @IBOutlet weak var progressIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let observer = NSNotificationCenter.defaultCenter().addObserverForName(CoreDataController.ProgressNotification, object: nil, queue: nil) { notification in
            self.applicationSubtitleLabel.hidden = true
            self.progressIndicatorView.startAnimating()
            self.yearLabel.text = "Processing \(notification.userInfo!["year"]!)…"
            self.yearLabel.hidden = false
        }
        CoreDataController.sharedInstance.setup {
            NSNotificationCenter.defaultCenter().removeObserver(observer)
            self.view.window!.rootViewController = self.storyboard!.instantiateViewControllerWithIdentifier("search")
        }
    }
    
}


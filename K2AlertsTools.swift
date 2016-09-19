//
//  K2AlertsTools.swift
//
//  Created by Kailen & Kathryne Engel on 3/2/16.
//  Copyright © 2016 K2. All rights reserved.
//
//  Alert & Notification utility functions
//

import UIKit

func makeAlert(
    for vc: UIViewController,
    title: String,
    message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let cancel = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
        alert.addAction(cancel)
        vc.presentViewController(alert, animated: true, completion: nil)
}

func makeAlertWithActions(
    for vc: UIViewController,
    title: String,
    message: String,
    addButtons: (title: String, block: (UIAlertAction->Void))...,
    withCancel: Bool = true) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        for button in addButtons {
            let action = UIAlertAction(title: button.title, style: .Default, handler: button.block)
            alert.addAction(action)
        }
        
        if withCancel {
            let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alert.addAction(cancel)
        }
        
        vc.presentViewController(alert, animated: true, completion: nil)
}

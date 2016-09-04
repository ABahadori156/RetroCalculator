//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Pasha Bahadori on 9/3/16.
//  Copyright © 2016 Pelican. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The bundle is the bundle of the app, it stores the actual files and things for our application
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
    }

    // This button sound lives in our project somewhere when the app is running on someone's phone. There is an actual URL to that path and it's stored somewhere on the user's device.


}


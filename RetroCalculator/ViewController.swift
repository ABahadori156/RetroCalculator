//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Pasha Bahadori on 9/3/16.
//  Copyright © 2016 Pelican. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The bundle is the bundle of the app, it stores the actual files and things for our application
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        
        // Now we have to convert the path into a URL since iOS works with URLS. We know path will be there so we can force-unwrap it.
        let soundURL = URL(fileURLWithPath: path!)
        
        // Here we're going to try and create an audio player with this sound in it. Because it COULD FAIL and crash our app, we need to do a do-statement which means "do this and if it fails, do this other thing instead"
        
        do {
            // Here we create the audio player inside the Do clause 
            // If this Do block fails and they can't retrieve the soundURL, then we jump into the catch block
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            
            // Gets the button sound audio ready to be played
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
            
            // We loaded it into the URL, the sound itself, how do we play the sound? HAVE THE BUTTONS CALL A FUNCTION
        }
        
    }

    @IBAction func numberPressed(sender: UIButton) {
      playSound()
    }
    
    func playSound() {
        // Allows us to tap the button multiple times quickly and make the sound quickly with btnSound.stop
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
        
    }
    // This button sound lives in our project somewhere when the app is running on someone's phone. There is an actual URL to that path and it's stored somewhere on the user's device.


}


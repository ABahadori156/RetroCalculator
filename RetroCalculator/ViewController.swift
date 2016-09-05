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
    
    @IBOutlet weak var outputLabel: UILabel!
    var btnSound: AVAudioPlayer!
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "="
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    

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
        outputLabel.text = "0"
        
    }

    @IBAction func numberPressed(sender: UIButton) {
      playSound()
        
        // The += allows us to add numbers next to each other like we'd do in a calculator, if it was just = we couldn't have multiple numbers on the label
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearPressed(_ sender: AnyObject) {
       currentOperation = Operation.Empty
        outputLabel.text = "0.0"
        runningNumber = ""
        
    }
   
    
    func playSound() {
        // Allows us to tap the button multiple times quickly and make the sound quickly with btnSound.stop
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    // This button sound lives in our project somewhere when the app is running on someone's phone. There is an actual URL to that path and it's stored somewhere on the user's device.

    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            
            //A user selected an operator, but then selected another operator without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    
                } else if currentOperation ==  Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    
                }
                
                leftValStr = result
                outputLabel.text = result
            }
            currentOperation = operation
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}


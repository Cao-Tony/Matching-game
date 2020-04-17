//
//  Sounds.swift
//  Matching Game
//
//  Created by Tony Cao on 4/16/20.
//  Copyright © 2020 Tony Cao. All rights reserved.
//

import Foundation
import AVFoundation

class soundManager {
    
    
  static var audioPlayer:AVAudioPlayer?
    enum soundEffect {
        case flip
        case shuffle
        case match
        case nomatch
    }
    
    
    static func playSound(_ effect:soundEffect){
        var soundFilename = ""
        
        
        //determine which sound effect we want to play
        //and set the appropraite filename
        switch effect {
        case .flip:
            soundFilename = "cardflip"
            
        case .shuffle:
            soundFilename = "shuffle"
            
        case .match:
            soundFilename = "dingcorrect"
            
        case . nomatch:
            soundFilename = "dingrong"
            
        }
        //get the path to the sound file inside the bundle
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        
        guard bundlePath != nil else{
            print("Couldnt find sound file \(soundFilename) in the bundle")
            return
        }
        //create a URL object from this string path
        let soundURL = URL(fileURLWithPath: bundlePath!)
        do{
        //create audio player object
        audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            //play the sound
            audioPlayer?.play()
        }
        catch{
            //couldnt create audio object log error
            print("couldnt create audio object sound file \(soundFilename)")
            
        }
        }
}

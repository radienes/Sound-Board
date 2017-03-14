//
//  SoundViewController.swift
//  Sound Board
//
//  Created by Napatsorn Lam Sakulsuwan on 3/8/17.
//  Copyright © 2017 Napatsorn Lam Sakulsuwan. All rights reserved.
//

import UIKit
import AVFoundation


class SoundViewController: UIViewController {
    

    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer
    var audioURL : URL = URL()?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
    
    }
    
    func setupRecorder() {
        do {
            //Create an audio session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            //Create URL for the audio file
            
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            print("#")
            print(audioURL)
            print("#")
            
            //Create setting for the audio recorder
            var settings : [String:Any] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
            settings[AVSampleRateKey] = 44100.0
            settings[AVNumberOfChannelsKey] = 2
            
            //Create audio recoder object
            
            
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder!.prepareToRecord()
        } catch let error as NSError {
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        
        if audioRecorder!.isRecording {
        
            //Stop the recording
            audioRecorder?.stop()
            
            //Chage button title to Record
        
            recordButton.setTitle("Record", for: .normal)
            
        } else {
            
           //Start the recording
            audioRecorder?.record()
        
            //Change button title to Stop
            recordButton.setTitle("Stop", for: .normal)
        }
    }
    
    @IBAction func playTapped(_ sender: Any) {
        do {
         try audioPlayer = AVAudioPlayer(contentsOf: audioURL)
            audioPlayer.play()
            
        }catch {}
    
    }
    
    @IBAction func addTapped(_ sender: Any) {
    }
}

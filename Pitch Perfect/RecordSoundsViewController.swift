//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Aditya Bantwal on 08/04/16.
//  Copyright © 2016 Aditya Bantwal. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate{

    @IBOutlet weak var TapTORecord: UILabel!
    
    @IBOutlet weak var RecordButton: UIButton!
    @IBOutlet weak var StopButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
            let playsoundVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playsoundVC.recordedAudioURL = recordedAudioURL
        }
    }
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        StopButton.enabled = false
        
    }
    
    
    @IBAction func recodAudio(sender: AnyObject) {
        TapTORecord.text = "Recording in Progress"
        StopButton.enabled=true
        RecordButton.enabled=false
        
        let dirpath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]as String
        
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirpath,recordingName]
        let filepath = NSURL.fileURLWithPathComponents(pathArray)
        print(filepath)
        
        let session = AVAudioSession.sharedInstance()
        try!session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder = AVAudioRecorder(URL: filepath!, settings:[:])
        
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
  
    
    @IBAction func StopRecording(sender: AnyObject) {
        TapTORecord.text="Tap To Record"
        RecordButton.enabled=true
        StopButton.enabled=false
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

   
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
            
        }
        else{
            print("The recording was not successful")
        }
    }
    
}


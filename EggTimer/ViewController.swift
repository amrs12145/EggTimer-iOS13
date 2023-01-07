//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    


    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var remainingTime: UILabel!
    
    var player: AVAudioPlayer!
    var url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
    
    var dictionary = ["soft":3,"medium":20,"hard":30]
    var timer = Timer()
 
    var totalTime: Int = 0
    var timePassed: Int = 0
    
    @IBAction func eggPressed(_ sender: UIButton) {
        
        totalTime = dictionary[sender.currentTitle!.lowercased()]!
        timePassed = 0
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(repeatFunc), userInfo: nil, repeats: true)
    }
    
    
    @objc func repeatFunc()
    {
        if totalTime > timePassed {
            timePassed += 1
            
            progressBar.progress = Float(timePassed)/Float(totalTime)
            remainingTime.text = String(totalTime-timePassed)
        }
        else if totalTime == timePassed {
            
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            remainingTime.textColor = UIColor.red
            progressBar.tintColor = UIColor.green
            remainingTime.text = "Done!"
        }

    }
}

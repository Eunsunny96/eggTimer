//
//  ViewController.swift
//  eggTimer1
//
//  Created by sunny h on 2021/08/19.
//

import UIKit

class ViewController: UIViewController {
  
    var maxImg = 3
    var numImg = 1
    
    
    
    
    @IBOutlet weak var imgGallery: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!

    var seconds = 270
    var timer = Timer()
 
    var isTimerRunning = false
    var resumeTapped = false
    
    //MARK: - IBActions
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
            self.startButton.isEnabled = false
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        pauseButton.isEnabled = true
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            isTimerRunning = false
            self.resumeTapped = true
            self.pauseButton.setTitle("Resume",for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            isTimerRunning = true
            self.pauseButton.setTitle("Pause",for: .normal)
        }
    }
        
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        seconds = 270
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true
    }
    

    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            //Send alert to indicate time's up.
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
           // timerLabel.text = String(seconds)
//            labelButton.setTitle(timeString(time: TimeInterval(seconds)), for: UIControlState.normal)
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%01i:%02i",  minutes, seconds)
    }
    
    

    
    
    //MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseButton.isEnabled = false
        imgGallery.image = UIImage(named: "1.png")
        
    }
    
    
    
        
    @IBAction func btnPrevImage(_ sender: UIButton) {
        numImg = numImg - 1
        
        if (numImg < 1){
            numImg = maxImg
        }
        let imageName = String(numImg) + ".png"
        
        imgGallery.image = UIImage(named: imageName)
        print(numImg)
    }
    
    
    @IBAction func btnNextImage(_ sender: UIButton) {
        numImg = numImg + 1
        
        if(numImg > maxImg) {
            numImg = 1
        }
        
        let imgName = String(numImg) + ".png"
        imgGallery.image = UIImage(named: imgName)
    }
    
}

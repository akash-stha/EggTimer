//
//  TimerViewController.swift
//  EggTimer
//
//  Created by Newarpunk on 3/10/20.
//  Copyright © 2020 Akash Stha. All rights reserved.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController {
    
    @IBOutlet weak var circularTimerView: UIView!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var seconds: Int = 10
    var timer = Timer()
    var isTimeRunning = false
    
    var pauseTapped: Bool = false
    var audioPlayer = AVAudioPlayer()
    
    let shapeLayer = CAShapeLayer()
    let startAngle = -CGFloat.pi/2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonShape(size: 21)
        pauseButton.isEnabled = false
        
        drawCircularShape()
        trackerPath()
        
        let path = Bundle.main.path(forResource: "sound", ofType: ".mp3")
        let url = URL(fileURLWithPath: path!)
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
        } catch {
            print("couldn't load file")
        }
    }
    
    private func buttonShape(size: CGFloat) {
        startButton.layer.cornerRadius = size
        pauseButton.layer.cornerRadius = size
        resetButton.layer.cornerRadius = size
    }
    
    private func drawCircularShape() {
        let center = circularTimerView.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 120, startAngle: startAngle, endAngle: CGFloat(270 * Double.pi / 180), clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 15
        shapeLayer.lineCap = .round
        view.layer.addSublayer(shapeLayer)
    }
    
    private func trackerPath() {
        let center = circularTimerView.center
        let trackerLayer = CAShapeLayer()
        let startPoint = -CGFloat.pi / 2
        let circularPath = UIBezierPath(arcCenter: center, radius: 120, startAngle: startPoint, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackerLayer.path = circularPath.cgPath
        trackerLayer.strokeColor = UIColor.red.withAlphaComponent(0.5).cgColor
        trackerLayer.lineWidth = 15
        trackerLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(trackerLayer)
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        let timeDuration: TimeInterval = TimeInterval(seconds)
        // here you define the fromValue, toValue and duration of your animation
        basicAnimation.fromValue = 0
        basicAnimation.toValue = 1
        basicAnimation.duration = timeDuration
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        // add the animation to your shapeLayer
        shapeLayer.add(basicAnimation, forKey: nil)
        
        if isTimeRunning == false {
            startTimer()
        }
        pauseButton.isEnabled = true
        startButton.isEnabled = false
        startColorChange(color: .brown)
    }
    
    private func startColorChange(color: UIColor) {
        startButton.backgroundColor = color
    }
    
    private func startTimer() {
        isTimeRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        seconds -= 1
//        timerLabel.text = String(seconds)
        timerLabel.text = timeString(time: TimeInterval(seconds))
        if seconds == 0 {
            timer.invalidate()
            timerLabel.blink()
            audioPlayer.play()
            audioPlayer.numberOfLoops = 100
            timerUp()
        }
    }
    
    private func timeString(time: TimeInterval) -> String {
//        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    private func timerUp() {
        let alert = UIAlertController(title: "Timer Complete", message: "Your egg is cooked perfectly", preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.audioPlayer.stop()
            self.reset()
        }
        
        alert.addAction(okAlert)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func pauseButtonClicked(_ sender: UIButton) {
        if self.pauseTapped == false {
            timer.invalidate()
            self.pauseTapped = true
            self.pauseButton.setTitle("Resume", for: .normal)
            self.pauseButton.backgroundColor = .brown
            timerLabel.blink()
        } else {
            startTimer()
            self.pauseTapped = false
            self.pauseButton.setTitle("Pause", for: .normal)
            self.pauseButton.backgroundColor = .black
            timerLabel.stopBlink()
        }
    }
    
    @IBAction func resetButtonClicked(_ sender: UIButton) {
        reset()
    }
    
    private func reset() {
        timer.invalidate()
        seconds = 10
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimeRunning = false
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        startColorChange(color: .black)
        timerLabel.stopBlink()
        audioPlayer.stop()
    }
    
}

extension UIView {
    func blink(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, alpha: CGFloat = 0.0) {
        UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
            self.alpha = alpha
        })
    }
    
    func stopBlink() {
        layer.removeAllAnimations()
        alpha = 1
    }
}


//extension UILabel {
//
//    func startBlink() {
//        UIView.animate(withDuration: 0.8,
//                       delay:0.0,
//                       options:[.allowUserInteraction, .curveEaseInOut, .autoreverse, .repeat],
//                       animations: { self.alpha = 0 },
//                       completion: nil)
//    }
//
//    func stopBlink() {
//        layer.removeAllAnimations()
//        alpha = 1
//    }
//}

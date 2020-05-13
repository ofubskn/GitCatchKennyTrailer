//
//  ViewController.swift
//  catchTheCannyGame
//
//  Created by Ömer Uray on 13.05.2020.
//  Copyright © 2020 Ömer Uray. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
       //variable

    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimmer = Timer()
    var highScore = 0
    //view
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        //highScore check
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "High Score: \(highScore)"
        }
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        //images tıklanabilir olması
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        // recognizer yaratma tıklanmayı algılayan
        let recognizeer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizeer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizeer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizeer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizeer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizeer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizeer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizeer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizeer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        // recognizeri image atama böylece image tıklandığını algılama
        kenny1.addGestureRecognizer(recognizeer1)
        kenny2.addGestureRecognizer(recognizeer2)
        kenny3.addGestureRecognizer(recognizeer3)
        kenny4.addGestureRecognizer(recognizeer4)
        kenny5.addGestureRecognizer(recognizeer5)
        kenny6.addGestureRecognizer(recognizeer6)
        kenny7.addGestureRecognizer(recognizeer7)
        kenny8.addGestureRecognizer(recognizeer8)
        kenny9.addGestureRecognizer(recognizeer9)
        
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny6,kenny7,kenny8,kenny9]
        
        
        //timers
        
        counter = 15
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counterDown), userInfo: nil, repeats: true)
        //hideKenny()
        hideTimmer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
    }
    
    @objc func hideKenny() {
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
        
    }
    
    @objc func increaseScore(){
        
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func counterDown(){
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimmer.invalidate()
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            // hide score
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "High Score \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
            }
            
            //alert
            let alert = UIAlertController(title: "Time is up" , message: "Do you want to game again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction ) in
                // replay funtion
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.counterDown), userInfo: nil, repeats: true)
                //hideKenny()
                self.hideTimmer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }

}


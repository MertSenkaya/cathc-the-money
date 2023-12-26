//
//  ViewController.swift
//  catchmoney2
//
//  Murat mert şenkaya
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var money1: UIImageView!
    @IBOutlet weak var money2: UIImageView!
    @IBOutlet weak var money3: UIImageView!
    @IBOutlet weak var money4: UIImageView!
    @IBOutlet weak var money5: UIImageView!
    @IBOutlet weak var money6: UIImageView!
    @IBOutlet weak var money7: UIImageView!
    @IBOutlet weak var money8: UIImageView!
    
    @IBOutlet weak var money9: UIImageView!
    
    
     var score = 0
     var timer = Timer()
     var timerscore = 10
    var cmoneyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
     override func viewDidLoad() {
         super.viewDidLoad()
       
         scoreLabel.text = "Score: \(score)"
                
                //Highscore check
                
                let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
                
                if storedHighScore == nil {
                    highScore = 0
                  highscoreLabel.text = "Highscore: \(highScore)"
                }
                
                if let newScore = storedHighScore as? Int {
                    highScore = newScore
                    highscoreLabel.text = "Highscore: \(highScore)"
                }
                
         
         
         
         //süre sayacının geri saymasını ve hangi aralıkla saymasını sağlıyor.
         timerscore = 10
         timeLabel.text = " time: \(timerscore)"
         Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timefunction), userInfo: nil, repeats: true)
         hideTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(hidemoney), userInfo: nil, repeats: true)
         
         
         
         money1.isUserInteractionEnabled = true
         money2.isUserInteractionEnabled = true
         money3.isUserInteractionEnabled = true
         money4.isUserInteractionEnabled = true
         money5.isUserInteractionEnabled = true
         money6.isUserInteractionEnabled = true
         money7.isUserInteractionEnabled = true
         money8.isUserInteractionEnabled = true
         money9.isUserInteractionEnabled = true
         
         //bu satırda görsele tıklandığında score değişkeninin artması sağlanıyor.
         let topGesture1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
         let topGesture2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
         let topGesture3 = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
         let topGesture4 = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
         let topGesture5 = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
         let topGesture6 = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
         let topGesture7 = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
         let topGesture8 = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
         let topGesture9 = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
         
                 
         money1.addGestureRecognizer(topGesture1)
         money2.addGestureRecognizer(topGesture2)
         money3.addGestureRecognizer(topGesture3)
         money4.addGestureRecognizer(topGesture4)
         money5.addGestureRecognizer(topGesture5)
         money6.addGestureRecognizer(topGesture6)
         money7.addGestureRecognizer(topGesture7)
         money8.addGestureRecognizer(topGesture8)
         money9.addGestureRecognizer(topGesture9)
         
         cmoneyArray = [money1, money2, money3, money4, money5, money6, money7, money8, money9 ]
          
        hidemoney()

     }
    //array içindeki  görselleri gizlemeyi ve rasgele görünür kılmayı sağlar.
     
    
    @objc func hidemoney() {
        for money in cmoneyArray {
            money.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(cmoneyArray.count - 1)))
        cmoneyArray[random].isHidden = false
    }
  
    
     @objc func imageTapped(){
         score += 1
         scoreLabel.text = "Score: \(score)"
     }

     
     
     @objc func timefunction() {
         timerscore -= 1
         timeLabel.text = "timescore: \(timerscore)"
      
         
         if timerscore == 0 {
             timer.invalidate()
             hideTimer.invalidate()
             
             for money in cmoneyArray {
                 money.isHidden = true
             }
             
             //HighScore
                        
                        if self.score > self.highScore {
                            self.highScore = self.score
                            highscoreLabel.text = "Highscore: \(self.highScore)"
                            UserDefaults.standard.set(self.highScore, forKey: "highscore")
                        }
                        
             
             //Alert
            
             let alert = UIAlertController(title: "süren doldu", message: "tekrar oynamak ister misin?", preferredStyle: UIAlertController.Style.alert)

             let okButton = UIAlertAction(title: "devam et", style: UIAlertAction.Style.cancel, handler: nil)
             
             let replayButton = UIAlertAction(title: "tekrar oyna", style: UIAlertAction.Style.default) { UIAlertAction in
                 //replay fonksiyonu yaz
                 
                 self.score = 0
                 self.scoreLabel.text = "Score: \(self.score)"
                 self.timerscore = 10
                 self.timeLabel.text = String(self.timerscore)
                
                 Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timefunction), userInfo: nil, repeats: true)
                 self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hidemoney), userInfo: nil, repeats: true)
                 
                 
                 
             }
             alert.addAction(okButton)
             alert.addAction(replayButton)
             self.present(alert, animated: true, completion: nil)
             

         }
         
     }
     
     
 }

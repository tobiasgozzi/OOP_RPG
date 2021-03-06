//
//  ViewController.swift
//  OOP-exercise
//
//  Created by Tobias Gozzi on 18.04.16.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var tagSelected: Int = 0
    var player1: Character?
    var player2: Character?
    
    var backgroundSound: AVAudioPlayer!
    var attackSound: AVAudioPlayer!
    
    
    
    @IBOutlet weak var player1AttackBtn: UIButton!
    @IBOutlet weak var player1AttackLabel: UILabel!
    @IBOutlet weak var player2AttackBtn: UIButton!
    @IBOutlet weak var player2AttackLabel: UILabel!
    @IBOutlet weak var chooseOgrBtn: UIButton!
    @IBOutlet weak var chhoseSoldierBtn: UIButton!
    @IBOutlet weak var restartGameBtn: UIButton!
    @IBOutlet weak var startingGameBtn: UIButton!
    @IBOutlet weak var MenuView: UIView!
    @IBOutlet weak var chooseCharacterLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    @IBOutlet weak var leftHPLabel: UILabel!
    @IBOutlet weak var rightHPLabel: UILabel!
    
    
    //different Characters
    @IBOutlet weak var enemyLeft: UIImageView!
    @IBOutlet weak var playerLeft: UIImageView!
    @IBOutlet weak var playerRight: UIImageView!
    @IBOutlet weak var enemyRight: UIImageView!
    
    
    @IBAction func choosingCharacter(sender: UIButton) {
        if player1 == nil {
            switch sender.titleLabel!.text! {
            case "Ogr":
                player1 = Orc(attackpower: 15, hp: 130, name: "Orc King", type: "Orc")
                enemyLeft.hidden = false
                
            case "Soldier":
                player1 = Soldier(name: "Kevin", attackpower: 17, hp: 115, type: "Soldier")
                playerLeft.hidden = false
            default:
                break
            }
            
            chooseCharacterLabel.text = "Player 2 choose character"
            
        } else if player1 != nil && player2 == nil {
            switch sender.titleLabel!.text! {
            case "Ogr":
                player2 = Orc(attackpower: 15, hp: 130, name: "Orc King", type: "Orc")
                enemyRight.hidden = false
            case "Soldier":
                player2 = Soldier(name: "Kevin", attackpower: 17, hp: 115, type: "Soldier")
                playerRight.hidden = false
            default:
                break
            }
            
            chooseOgrBtn.hidden = true
            chhoseSoldierBtn.hidden = true
            startingGameBtn.hidden = false
            
            chooseCharacterLabel.text = "Press start to begin game"
            
        }
    }
    
    @IBAction func startingGame(sender: AnyObject) {
        updatingHPLabel()
        MenuView.hidden = true
        playBackgroundSound()
        
        
    }
    
    @IBAction func attackingPlayer(sender: UIButton) {
        
        playAttackSound()
        
        
        if sender.tag == 1 {
            statsLabel.text = "\(player1!.name) attacked \(player2!.name) for \(player1!.attackpower)"
            player2!.hp -= player1!.attackpower
        } else if sender.tag == 2 {
            statsLabel.text = "\(player2!.name) attacked \(player1!.name) for \(player2!.attackpower)"
            player1!.hp -= player2!.attackpower
        }
        updatingHPLabel()
        
        if (player1?.hp > 0) && (player2?.hp > 0) {
            disableAttackBtn(sender)
        }
        
        //if player reaches 0 HP - Game ending
        if player1?.hp <= 0 {
            playerDied(playerSurvived: 2)
        } else if player2?.hp <= 0 {
            playerDied(playerSurvived: 1)
        }
    }
    
    func playerDied(playerSurvived playerID: Int) {
        if playerID == 1 {
            statsLabel.text = "Player 1 wins"
            playerRight.hidden = true
            enemyRight.hidden = true
        } else if playerID == 2 {
            statsLabel.text = "Player 2 wins"
            playerLeft.hidden = true
            enemyLeft.hidden = true
        }
        
        stopBackgroundSound()
        restartGameBtn.hidden = false
        
        player2AttackLabel.hidden = true
        player1AttackBtn.hidden = true
        player2AttackBtn.hidden = true
        player1AttackLabel.hidden = true
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load Background-Sound
        let pathBgSound = NSBundle.mainBundle().pathForResource("Swords_Collide", ofType: "mp3")
        let pathAttackSound = NSBundle.mainBundle().pathForResource("easier-said-than-killed", ofType: "mp3")

        let bgSoundURL = NSURL.fileURLWithPath(pathBgSound!)
        let attackSoundURL = NSURL.fileURLWithPath(pathAttackSound!)
        
        do {
            try attackSound = AVAudioPlayer(contentsOfURL: bgSoundURL)
            try backgroundSound = AVAudioPlayer(contentsOfURL: attackSoundURL)
            
            attackSound.prepareToPlay()
            backgroundSound.prepareToPlay()
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    @IBAction func restartGame(sender: AnyObject) {
    
        player1 = nil
        player2 = nil
        
        MenuView.hidden = false
        
        playerLeft.hidden = true
        playerRight.hidden = true
        enemyRight.hidden = true
        enemyLeft.hidden = true
        restartGameBtn.hidden = true
        
        startingGameBtn.hidden = true
        chooseCharacterLabel.text = "Player 1 choose character"
        
        chooseOgrBtn.hidden = false
        chhoseSoldierBtn.hidden = false
        
        
        player2AttackLabel.hidden = false
        player1AttackBtn.hidden = false
        player2AttackBtn.hidden = false
        player1AttackLabel.hidden = false

    }
    
    func disableAttackBtn(sender: UIButton) {
        let timer: NSTimer!
        
        
        
        if sender.tag == 1 {
            player1AttackBtn.hidden = true
            player1AttackLabel.hidden = true
            tagSelected = 1
            timer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: #selector(reenablePlyaerBtn), userInfo: nil, repeats: false)

        }
        else if sender.tag == 2 {
            player2AttackBtn.hidden = true
            player2AttackLabel.hidden = true
            tagSelected = 2
            timer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: #selector(reenablePlyaerBtn), userInfo: nil, repeats: false)
        }
        else {

        }
        


    }
    func reenablePlyaerBtn() {
        if tagSelected == 1 {
            player1AttackBtn.hidden = false
            player1AttackLabel.hidden = false        }
        else if tagSelected == 2 {
            player2AttackBtn.hidden = false
            player2AttackLabel.hidden = false
        }
    }
    func updatingHPLabel() {
        leftHPLabel.text = String(player1!.hp)
        rightHPLabel.text = String(player2!.hp)
    }
    
    func playBackgroundSound() {
        backgroundSound.play()
    }
    
    func stopBackgroundSound() {
        backgroundSound.stop()
    }
    
    func playAttackSound() {
        if attackSound.playing {
            attackSound.stop()
        }
        attackSound.play()
    }
    
    

}


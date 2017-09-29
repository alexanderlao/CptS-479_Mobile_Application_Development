//
//  SettingsViewController.swift
//  BounceSpriteKit2
//
//  Created by Alexander Lao on 4/15/17.
//  Copyright © 2017 Larry Holder. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsViewController: UIViewController {

    @IBOutlet weak var soundEffectsSwitch: UISwitch!
    @IBOutlet weak var backgroundMusicSwitch: UISwitch!
    
    var gameVC: GameViewController!
    
    @IBAction func doneButtonTapped(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    // the user flipped the sound effects switch
    @IBAction func soundEffectsSwitched(_ sender: UISwitch)
    {
        // switch is on
        if (sender.isOn)
        {
            // allow sounds
            UserDefaults.standard.set(true, forKey: "sound")
        }
        // switch is off
        else
        {
            // don't allow sounds
            UserDefaults.standard.set(false, forKey: "sound")
        }
    }
    
    // the user flipped the background music switch
    @IBAction func backgroundMusicSwitched(_ sender: UISwitch)
    {
        // switch is on
        if (sender.isOn)
        {
            // turn on the music
            UserDefaults.standard.set(true, forKey: "music")
            
            // if the game is not paused
            if (!gameVC.gameScene.isPaused)
            {
                gameVC.gameScene.playMusic()
            }
        }
        // switch is off
        else
        {
            // turn off the music
            UserDefaults.standard.set(false, forKey: "music")
            gameVC.gameScene.pauseMusic()

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // display the correct position of the switches
        if (UserDefaults.standard.bool(forKey: "sound") == true)
        {
            soundEffectsSwitch.setOn(true, animated: true)
        }
        else
        {
            soundEffectsSwitch.setOn(false, animated: true)
        }
        
        if (UserDefaults.standard.bool(forKey: "music") == true)
        {
            backgroundMusicSwitch.setOn(true, animated: true)
        }
        else
        {
            backgroundMusicSwitch.setOn(false, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

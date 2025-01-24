//
//  RootVC.swift
//  SweetLayers
//
//  Created by 1 on 17/01/25.
//

import UIKit

class RootVC: UIViewController {
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var settingsOpenImage: UIImageView!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    
    let main = UIStoryboard(name: "Main", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coinLabel.text = "\(UserDataConfiguration.shared.getCoins())"
        SoundManager.shared.playBackgroundMusic()
    }
    
    @IBAction func settingsTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.tag = 1
            settingsOpenImage.image = UIImage(named: "settingsOn")
            soundButton.isHidden = false
            musicButton.isHidden = false
        } else {
            sender.tag = 0
            settingsOpenImage.image = nil
            soundButton.isHidden = true
            musicButton.isHidden = true
        }
    }
    
    @IBAction func soundPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.tag = 1
            sender.setBackgroundImage(UIImage(named: "soundOff"), for: .normal)
            SoundManager.shared.setSoundVolume(0.0)
        } else {
            sender.tag = 0
            sender.setBackgroundImage(UIImage(named: "soundOn"), for: .normal)
            SoundManager.shared.setSoundVolume(1.0)
        }
    }
    
    @IBAction func musicPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.tag = 1
            sender.setBackgroundImage(UIImage(named: "musicOff"), for: .normal)
            SoundManager.shared.setMusicVolume(0.0)
        } else {
            sender.tag = 0
            sender.setBackgroundImage(UIImage(named: "musicOn"), for: .normal)
            SoundManager.shared.setMusicVolume(1.0)
        }
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
        let vc = main.instantiateViewController(withIdentifier: "LevelsSelectionVC") as! LevelsSelectionVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func shopPressed(_ sender: UIButton) {
        let vc = main.instantiateViewController(withIdentifier: "MarketVC") as! MarketVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func recipeCollectionPressed(_ sender: UIButton) {
        let vc = main.instantiateViewController(withIdentifier: "RecipesCollectionVC") as! RecipesCollectionVC
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func dailyGiftButtonTapped(_ sender: UIButton) {
        let vc = main.instantiateViewController(withIdentifier: "DailyPrizesVC") as! DailyPrizesVC
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
}

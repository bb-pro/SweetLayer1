//
//  WinningStatusVC.swift
//  SweetLayers
//
//  Created by 1 on 18/01/25.
//

import UIKit

class WinningStatusVC: UIViewController {
    @IBOutlet weak var topTitleImage: UIImageView!
    @IBOutlet weak var centerImageView: UIImageView!
    @IBOutlet weak var cakeImageView: UIImageView!
    @IBOutlet weak var rightButton: UIButton!
    
    var isWon: Bool?
    var cakeImage: UIImage?
    var level: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let isWon = isWon {
            let coinKey = UserDataConfiguration.shared.coins
            centerImageView.image = isWon
            ? UIImage(named: "winCenterImage")
            : UIImage(named: "loseCenterImage")
            topTitleImage.image = isWon
            ? UIImage(named: "victoryText")
            : UIImage(named: "gameOverImage")
            let image = isWon
            ? UIImage(named: "continueButton")
            : UIImage(named: "restartButton")
            rightButton.setBackgroundImage(image, for: .normal)
            if isWon {
                SoundManager.shared.playWinSound()
                UserDataConfiguration.shared.updateValues(key: coinKey,
                                                          value: UserDataConfiguration.shared.getCoins() + 30)
            } else {
                SoundManager.shared.playLoseSound()
                UserDataConfiguration.shared.updateValues(key: coinKey,
                                                          value: UserDataConfiguration.shared.getCoins() - 30)
            }
        }
        
        if let level = level, let isWon = isWon {
            let key = UserDataConfiguration.shared.levels
            if isWon {
                var lvls = UserDataConfiguration.shared.getValueOfKey(key: key) as! [Int]
                if !lvls.contains(level + 1) && level < 11 {
                    lvls.append(level + 1)
                    UserDataConfiguration.shared.updateValues(key: key, value: lvls)
                }
            }
        }
        
        if let cakeImage = cakeImage {
            cakeImageView.contentMode = .scaleAspectFit
            cakeImageView.image = cakeImage
        } else {
            cakeImageView.image = nil
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SoundManager.shared.stopBackgroundMusic()
    }
    
    func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in}
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @IBAction func leftButtonTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func rightButtonTapped(_ sender: UIButton) {
        if let isWon = isWon {
            if isWon {
                if level == 0 {
                    let controller = storyboard?.instantiateViewController(withIdentifier: "BlowingVC") as! BlowingVC
                    navigationController?.pushViewController(controller, animated: true)
                } else if level! < 11 {
                    let vc = storyboard?.instantiateViewController(withIdentifier: "MainGameVC") as! MainGameVC
                    vc.level = level! + 1
                    navigationController?.pushViewController(vc, animated: true)
                } else {
                    let vc = storyboard?.instantiateViewController(withIdentifier: "MainGameVC") as! MainGameVC
                    vc.level = level
                    navigationController?.pushViewController(vc, animated: true)
                }
                SoundManager.shared.playBackgroundMusic()
            } else {
                let vc = storyboard?.instantiateViewController(withIdentifier: "MainGameVC") as! MainGameVC
                if UserDataConfiguration.shared.getCoins() >= 30 {
                    vc.level = level
                    navigationController?.pushViewController(vc, animated: true)
                    SoundManager.shared.playBackgroundMusic()
                } else {
                    showAlertMessage(title: "Attention!", message: "You have no enough coins to continue")
                }
            }
        }
    }
}

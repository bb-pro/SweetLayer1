//
//  DailyPrizesVC.swift
//  SweetLayers
//
//  Created by 1 on 24/01/25.
//

import UIKit

class DailyPrizesVC: UIViewController {
    @IBOutlet var prizesViews: [UIView]!
    @IBOutlet var takeButtons: [UIButton]!
    @IBOutlet weak var coinLabel: UILabel!
    
    
    var prizes: [Int] = [30, 60, 90, 120, 150, 180, 0]
    var randomPrize: Int = UserDataConfiguration.shared.getValueOfKey(key: UserDataConfiguration.shared.bonusIndex) as! Int
    let rewardInterval: TimeInterval = 24 * 60 * 60
    var lastPrizeData = UserDataConfiguration.shared.fetchLastDateOfBonus()
    var coins = UserDataConfiguration.shared.getCoins()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinLabel.text = "\(coins)"
        checkRewardStatus()
    }
    @IBAction func exitTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func takeTapped(_ sender: UIButton) {
        UserDataConfiguration.shared.updateValues(key: UserDataConfiguration.shared.bonusIndex, value: randomPrize)
        if randomPrize < 6 {
            coins += prizes[randomPrize]
            UserDataConfiguration.shared.updateValues(key: UserDataConfiguration.shared.coins, value: coins)
            coinLabel.text = "\(coins)"
        } else if randomPrize == 6 {
            var backgroundImages = UserDataConfiguration.shared.getValueOfKey(key: UserDataConfiguration.shared.availableBackgrounds) as! [Int]
            if !backgroundImages.contains(1) {
                backgroundImages.append(1)
                UserDataConfiguration.shared.updateValues(key: UserDataConfiguration.shared.availableBackgrounds, value: backgroundImages)
            }
        }
        UserDataConfiguration.shared.updateValues(key: UserDataConfiguration.shared.bonusDate, value: Date())
        lastPrizeData = Date()
        checkRewardStatus()
    }
}
private extension DailyPrizesVC {
    private func checkRewardStatus() {
        let currentTime = Date()
        
        if currentTime.timeIntervalSince(lastPrizeData) > rewardInterval {
            randomPrize += 1
            if randomPrize <= 6 {
                for vw in prizesViews {
                    if vw.tag == randomPrize {
                        vw.alpha = 1.0
                        vw.isUserInteractionEnabled = true
                    } else {
                        vw.alpha = 0.8
                        vw.isUserInteractionEnabled = false
                    }
                }
                enableRewardButton()
            } else {
                for view in prizesViews {
                    view.alpha = 1.0
                }
                for btn in takeButtons {
                    btn.isUserInteractionEnabled = false
                    btn.setBackgroundImage(UIImage(named: "selectedPrizes"), for: .normal)
                }
            }
        } else {

            disableRewardButton()
            print("Reward already claimed, wait until the next 24-hour window.")
        }
    }
    
    func disableRewardButton() {
        for vw in prizesViews {
            vw.alpha = 0.8
        }
        for btn in takeButtons {
            btn.isUserInteractionEnabled = false
        }
    }
    
    func enableRewardButton() {
        for btn in takeButtons {
            if btn.tag == randomPrize {
                btn.isUserInteractionEnabled = true
            } else {
                btn.isUserInteractionEnabled = false
            }
        }
    }
}


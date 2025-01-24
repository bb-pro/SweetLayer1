//
//  MarketVC.swift
//  SweetLayers
//
//  Created by 1 on 17/01/25.
//

import UIKit

class MarketVC: UIViewController {
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var powersStack: UIStackView!
    @IBOutlet weak var backgroundsStack: UIStackView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet var buyBackgroundButtons: [UIButton]!
    @IBOutlet var equipButtons: [UIButton]!
    @IBOutlet var marketSelectionButtons: [UIButton]!
    @IBOutlet var priceImages: [UIImageView]!
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinLabel.text = "\(UserDataConfiguration.shared.getCoins())"
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeView(_:)))
        rightSwipeGesture.direction = .right
        view.addGestureRecognizer(rightSwipeGesture)
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeView(_:)))
        leftSwipeGesture.direction = .left
        view.addGestureRecognizer(leftSwipeGesture)
        defineBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SoundManager.shared.stopBackgroundMusic()
        SoundManager.shared.playMarketMusic()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SoundManager.shared.playBackgroundMusic()
        SoundManager.shared.stopMarketMusic()
    }
    
    @objc func swipeView(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            index = 0
        } else if sender.direction == .left {
            index = 1
        }
        defineForIndex()
    }
    
    @IBAction func marketTypeSelectionButtons(_ sender: UIButton) {
        index = sender.tag
        defineForIndex()
    }
    
    @IBAction func xTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func infoGotTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "InfoVC") as! InfoVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func buyBlowerButton(_ sender: UIButton) {
        if UserDataConfiguration.shared.getCoins() >= 30 {
            let blowerKey = UserDataConfiguration.shared.blower
            UserDataConfiguration.shared.updateValues(key: blowerKey,
                                                      value: (UserDataConfiguration.shared.getValueOfKey(key: blowerKey) as! Int) + 1)
            UserDataConfiguration.shared.updateValues(key: UserDataConfiguration.shared.coins, value: UserDataConfiguration.shared.getCoins() - 30)
            coinLabel.text = "\(UserDataConfiguration.shared.getCoins())"
        }
    }
    
    @IBAction func buyTimerButton(_ sender: Any) {
        if UserDataConfiguration.shared.getCoins() >= 30 {
            let timerKey = UserDataConfiguration.shared.timer
            UserDataConfiguration.shared.updateValues(key: timerKey,
                                                      value: (UserDataConfiguration.shared.getValueOfKey(key: timerKey) as! Int) + 1)
            UserDataConfiguration.shared.updateValues(key: UserDataConfiguration.shared.coins, value: UserDataConfiguration.shared.getCoins() - 30)
            coinLabel.text = "\(UserDataConfiguration.shared.getCoins())"
        }
    }
    
    
    @IBAction func buyBackgroundTapped(_ sender: UIButton) {
        var availableBackgrounds = UserDataConfiguration.shared.getValueOfKey(key: UserDataConfiguration.shared.availableBackgrounds) as! [Int]
        if UserDataConfiguration.shared.getCoins() >= 60 {
            if !availableBackgrounds.contains(sender.tag) {
                availableBackgrounds.append(sender.tag)
                UserDataConfiguration.shared.updateValues(key: UserDataConfiguration.shared.coins, value: UserDataConfiguration.shared.getCoins() - 60)
                UserDataConfiguration.shared.updateValues(key: UserDataConfiguration.shared.availableBackgrounds, value: availableBackgrounds)
                coinLabel.text = "\(UserDataConfiguration.shared.getCoins())"
                defineBackground()
            }
        }
    }
    
    @IBAction func equipBackgroundTapped(_ sender: UIButton) {
        let availableBackgrounds = UserDataConfiguration.shared.getValueOfKey(key: UserDataConfiguration.shared.availableBackgrounds) as! [Int]
        if availableBackgrounds.contains(sender.tag) {
            UserDataConfiguration.shared.updateValues(key: UserDataConfiguration.shared.backgroundIndex, value: sender.tag)
            defineBackground()
        }
    }
}
private extension MarketVC {
    func defineBackground() {
        let currentIndex = UserDataConfiguration.shared.getValueOfKey(key: UserDataConfiguration.shared.backgroundIndex) as! Int
        let availableBackgrounds = UserDataConfiguration.shared.getValueOfKey(key: UserDataConfiguration.shared.availableBackgrounds) as! [Int]
        for buyBtn in buyBackgroundButtons {
            if !availableBackgrounds.contains(buyBtn.tag) {
                buyBtn.isHidden = false
            } else {
                buyBtn.isHidden = true
            }
        }
        for equipBtn in equipButtons {
            if equipBtn.tag == currentIndex {
                equipBtn.isEnabled = false
                equipBtn.setBackgroundImage(UIImage(named: "equiped"), for: .normal)
            } else {
                equipBtn.isEnabled = true
                equipBtn.setBackgroundImage(UIImage(named: "equipButton"), for: .normal)
            }
        }
        for priceImage in priceImages {
            if availableBackgrounds.contains(priceImage.tag) {
                priceImage.isHidden = true
            } else {
                priceImage.isHidden = false
            }
        }
    }
    
    func defineForIndex() {
        for btn in marketSelectionButtons {
            if btn.tag == index {
                btn.setBackgroundImage(UIImage(named: "selectedMarket"), for: .normal)
            } else {
                btn.setBackgroundImage(UIImage(named: "unselectedMarket"), for: .normal)
            }
        }
        if index == 0 {
            titleImageView.image = UIImage(named: "marketTextImage")
        } else {
            titleImageView.image = UIImage(named: "backgroundTextImage")
        }
        powersStack.isHidden = (index == 1)
        backgroundsStack.isHidden = (index == 0)
    }
}

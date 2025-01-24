//
//  MainGameVC.swift
//  SweetLayers
//
//  Created by 1 on 18/01/25.
//

import UIKit
import SnapKit

class MainGameVC: UIViewController {
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var blowerAmountLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var timerAmountLabel: UILabel!
    @IBOutlet weak var backCoveredView: UIView!
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var timerProgressView: UIProgressView!
    @IBOutlet var powerButtons: [UIButton]!
    @IBOutlet weak var backCakeImageView: UIImageView!
    @IBOutlet weak var gameBackImageView: UIImageView!
    
    var timer: Timer?
    var remainingTime: Float = 60.0
    var totalTime: Float = 60.0
    var level: Int?
    var imageIndexes: [Int] = [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        startTimer()
        addImagesIntoView()
    }
    
    @IBAction func pauseTapped(_ sender: UIButton) {
        setupPauseView()
    }
    @IBAction func infoTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "InstructionVC") as! InstructionVC
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @IBAction func blowerButtonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let blowerKey = UserDataConfiguration.shared.blower
        if UserDataConfiguration.shared.getValueOfKey(key: blowerKey) as! Int > 0 {
            let tag0Subviews = gameView.subviews.filter { $0.tag == 0 }
            let tag1Subviews = gameView.subviews.filter { $0.tag == 1 }
            let tag2Subviews = gameView.subviews.filter { $0.tag == 2 }
            
            let randomTag0View = tag0Subviews.randomElement() as? UIImageView
            let randomTag1View = tag1Subviews.randomElement() as? UIImageView
            let randomTag2View = tag2Subviews.randomElement() as? UIImageView
            
            randomTag0View?.image = UIImage(named: "shadowTrash0")
            randomTag2View?.image = UIImage(named: "shadowTrash2")
            randomTag1View?.image = UIImage(named: "glass3position")
            
            randomTag0View?.snp.updateConstraints { make in
                make.width.height.equalTo(120)
            }
            randomTag1View?.snp.updateConstraints { make in
                make.width.height.equalTo(120)
            }
            randomTag2View?.snp.updateConstraints { make in
                make.width.height.equalTo(120)
            }
            
            UIView.animate(withDuration: 2.0) {
                randomTag0View?.alpha = 0
                randomTag1View?.alpha = 0
                randomTag2View?.alpha = 0.9
            } completion: { _ in
                randomTag0View?.removeFromSuperview()
                randomTag1View?.removeFromSuperview()
                randomTag2View?.removeFromSuperview()
                sender.isEnabled = true
            }
            sender.isEnabled = true
            UserDataConfiguration.shared.updateValues(key: blowerKey, value: UserDataConfiguration.shared.getValueOfKey(key: blowerKey) as! Int - 1)
            blowerAmountLabel.text = "\(UserDataConfiguration.shared.getValueOfKey(key: UserDataConfiguration.shared.blower) as! Int)"
        }
    }
    
    @IBAction func timerButtonTapped(_ sender: UIButton) {
        let timerKey = UserDataConfiguration.shared.timer
        if UserDataConfiguration.shared.getValueOfKey(key: timerKey) as! Int > 0 {
            remainingTime += 30
            totalTime += 30
            UserDataConfiguration.shared.updateValues(key: timerKey, value: UserDataConfiguration.shared.getValueOfKey(key: timerKey) as! Int - 1)
            timerAmountLabel.text = "\(UserDataConfiguration.shared.getValueOfKey(key: UserDataConfiguration.shared.timer) as! Int)"
        }
    }
    
    @IBAction func toolTapped(_ sender: UIButton) {
        for btn in powerButtons {
            btn.isEnabled = false
        }
        sender.setBackgroundImage(UIImage(named: "emptyTool"), for: .normal)
        
        let toolImageView = UIImageView(image: UIImage(named: "bareTool\(sender.tag)"))
        toolImageView.tag = sender.tag
        toolImageView.contentMode = .scaleAspectFit
        toolImageView.isUserInteractionEnabled = true
        
        gameView.addSubview(toolImageView)
        toolImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.center.equalTo(gameView)
        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        toolImageView.addGestureRecognizer(panGesture)
    }
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let toolImageView = gesture.view else { return }
        
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: gameView)
            toolImageView.center = CGPoint(x: toolImageView.center.x + translation.x, y: toolImageView.center.y + translation.y)
            gesture.setTranslation(.zero, in: gameView)
            
        case .ended:
            if let matchingImageView = gameView.subviews.first(where: { subview in
                guard subview is UIImageView, subview != toolImageView else { return false }
                return subview.tag == toolImageView.tag && subview.frame.intersects(toolImageView.frame)
            }) as? UIImageView {
                matchingImageView.snp.updateConstraints { make in
                    make.height.width.equalTo(120)
                }
                toolImageView.removeFromSuperview()
                matchingImageView.image = UIImage(named: "shadowTrash\(matchingImageView.tag)")
                if matchingImageView.tag == 1 {
                    matchingImageView.image = UIImage(named: "glass2position")
                }
                UIView.animate(withDuration: 1.5) {
                    if matchingImageView.tag == 0 || matchingImageView.tag == 2 {
                        matchingImageView.alpha = 0
                    } else {
                        matchingImageView.alpha = 0.8
                    }
                } completion: { _ in
                    matchingImageView.removeFromSuperview()
                    print("Matched and removed images with tag: \(toolImageView.tag)")
                    for btn in self.powerButtons {
                        btn.setBackgroundImage(UIImage(named: "tool\(btn.tag)"), for: .normal)
                        btn.isEnabled = true
                    }
                    var completion = false
                    let tag3Subviews = self.gameView.subviews.filter { $0.tag == 3 }
                    for subview in self.gameView.subviews {
                        if subview.tag != 0 && subview.tag != 2 && subview.tag != 1 {
                            completion = true
                        } else {
                            completion = false
                            break
                        }
                    }
                    if completion {
                        self.timer?.invalidate()
                        UIView.animate(withDuration: 2.0) {
                            for view in tag3Subviews {
                                view.alpha = 0
                            }
                        } completion: { _ in
                            self.setupVictoryCake()
                        }
                    }
                }
            } else {
                toolImageView.removeFromSuperview()
                for btn in powerButtons {
                    btn.setBackgroundImage(UIImage(named: "tool\(btn.tag)"), for: .normal)
                    btn.isEnabled = true
                }
            }
        default:
            break
        }
    }
}
private extension MainGameVC {
    private func setupLayout() {
        timerProgressView.layer.borderColor = UIColor(red: 243/255, green: 171/255, blue: 224/255, alpha: 1).cgColor
        timerProgressView.layer.borderWidth = 2.0
        if let level = level {
            if level >= 3 && level <= 7 {
                timerProgressView.progressImage = UIImage(named: "blueProgressImage")
            } else {
                timerProgressView.progressImage = UIImage(named: "loadingProgress")
            }
        }
        gameBackImageView.image = UIImage(named: "gameBack\(UserDataConfiguration.shared.getValueOfKey(key: UserDataConfiguration.shared.backgroundIndex) as! Int)")
        blowerAmountLabel.text = "\(UserDataConfiguration.shared.getValueOfKey(key: UserDataConfiguration.shared.blower) as! Int)"
        timerAmountLabel.text = "\(UserDataConfiguration.shared.getValueOfKey(key: UserDataConfiguration.shared.timer) as! Int)"
        if let level = level {
            backCakeImageView.image = UIImage(named: "cake\(level)")
            levelLabel.text = "Level \(level + 1)"
            for _ in 0...level {
                imageIndexes.append([0, 1, 2, 3].randomElement()!)
            }
        }
        coinLabel.text = "\(UserDataConfiguration.shared.getCoins())"
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    
    @objc func updateProgress() {
        if remainingTime > 0 {
            remainingTime -= 1
            let progress = remainingTime / totalTime
            timerProgressView.setProgress(progress, animated: true)
        } else {
            timer?.invalidate()
            timer = nil
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WinningStatusVC") as! WinningStatusVC
            vc.isWon = false
            vc.cakeImage = nil
            vc.level = self.level
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func addImagesIntoView() {
//        imageIndexes.shuffle()
        for index in imageIndexes {
            let imageView = UIImageView(image: UIImage(named: "trash\(index)"))
            imageView.tag = index
            imageView.contentMode = .scaleAspectFit
            
            gameView.addSubview(imageView)
            let randomX = CGFloat.random(in: 0...(gameView.bounds.width - 80))
            let randomY = CGFloat.random(in: 0...(gameView.bounds.height - 80))
            imageView.snp.makeConstraints { make in
                make.width.height.equalTo(80)
                make.left.equalTo(gameView).offset(randomX)
                make.top.equalTo(gameView).offset(randomY)
            }
        }
    }
}
// MARK: - Custom alert views setup by SnapKit

extension MainGameVC {
    func setupVictoryCake() {
        let customView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
            return view
        }()
        let victoryText = UIImageView(image: UIImage(named: "victoryText"))
        let centerCakeImage = UIImageView(image: UIImage(named: "cake\(level!)"))
        let button: UIButton = {
            let button = UIButton(type: .system)
            button.setBackgroundImage(UIImage(named: "addRecipeButton"), for: .normal)
            return button
        }()
        
        SoundManager.shared.stopBackgroundMusic()
        SoundManager.shared.playBonusSound()
        view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        customView.addSubview(centerCakeImage)
        centerCakeImage.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.center.equalToSuperview()
            make.height.equalTo(centerCakeImage.snp.width)
        }
        
        victoryText.contentMode = .scaleAspectFit
        customView.addSubview(victoryText)
        victoryText.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(centerCakeImage.snp.top)
        }
        
        customView.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(centerCakeImage.snp.bottom).offset(-15)
            make.height.equalTo(76)
            make.width.equalTo(112)
            make.centerX.equalToSuperview()
        }
        
        button.addMyAction {
            if self.level! <= 11 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "WinningStatusVC") as! WinningStatusVC
                vc.isWon = true
                vc.cakeImage = UIImage(named: "cake\(self.level!)")
                vc.level = self.level
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    func setupPauseView() {
        timer?.invalidate()
        let customView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
            return view
        }()
        let pauseText = UIImageView(image: UIImage(named: "pauseTitle"))
        let centerViewImage = UIImageView(image: UIImage(named: "pauseCenterImage"))
        let exitButton: UIButton = {
            let button = UIButton(type: .system)
            button.setBackgroundImage(UIImage(named: "exitBtn"), for: .normal)
            return button
        }()
        
        let continueButton: UIButton = {
            let button = UIButton(type: .system)
            button.setBackgroundImage(UIImage(named: "continueButton"), for: .normal)
            return button
        }()
        
        view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        customView.addSubview(centerViewImage)
        centerViewImage.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.center.equalToSuperview()
            make.height.equalTo(centerViewImage.snp.width).dividedBy(1.64)
        }
        
        pauseText.contentMode = .scaleAspectFit
        customView.addSubview(pauseText)
        pauseText.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(centerViewImage.snp.top)
        }
        
        customView.addSubview(exitButton)
        exitButton.snp.makeConstraints { make in
            make.top.equalTo(centerViewImage.snp.bottom).offset(-15)
            make.height.equalTo(76)
            make.width.equalTo(112)
            make.left.equalToSuperview().inset(20)
        }
        
        customView.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(centerViewImage.snp.bottom).offset(-15)
            make.height.equalTo(76)
            make.width.equalTo(112)
            make.right.equalToSuperview().inset(20)
        }
        
        exitButton.addMyAction {
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        continueButton.addMyAction {
            self.startTimer()
            customView.removeFromSuperview()
        }
    }
}

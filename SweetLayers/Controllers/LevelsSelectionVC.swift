//
//  LevelsSelectionVC.swift
//  SweetLayers
//
//  Created by 1 on 17/01/25.
//

import UIKit

class LevelsSelectionVC: UIViewController {
    @IBOutlet var levelButtons: [UIButton]!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let levels = UserDataConfiguration.shared.getValueOfKey(key: UserDataConfiguration.shared.levels) as! [Int]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for btn in levelButtons {
            if btn.tag < levels.max()! {
                btn.isHidden = true
            } else if btn.tag == levels.max()! {
                btn.setBackgroundImage(UIImage(named: "levelButton"), for: .normal)
                btn.isHidden = false
                btn.isUserInteractionEnabled = true
                btn.setTitleColor(UIColor(red: 210/255, green: 45/255, blue: 228/255, alpha: 1), for: .normal)
            } else {
                btn.isHidden = false
                btn.isUserInteractionEnabled = false
                btn.setBackgroundImage(UIImage(named: "disabledLevelButton"), for: .normal)
                btn.setTitleColor(UIColor(red: 131/255, green: 131/255, blue: 131/255, alpha: 1.0), for: .normal)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let currentOffset = scrollView.contentOffset
        let maxXOffset = scrollView.contentSize.width - scrollView.bounds.width
        let newOffset = CGPoint(x: min(maxXOffset, currentOffset.x + 250.0), y: currentOffset.y)
        scrollView.setContentOffset(newOffset, animated: true)
    }
    
    @IBAction func exitPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in}
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @IBAction func LevelButtonGotTapped(_ sender: UIButton) {
        if UserDataConfiguration.shared.getCoins() >= 30 {
            if sender.tag == 0 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "TrainingVC") as! TrainingVC
                navigationController?.pushViewController(vc, animated: true)
            } else if sender.tag == 1 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "BlowingVC") as! BlowingVC
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = storyboard?.instantiateViewController(withIdentifier: "MainGameVC") as! MainGameVC
                vc.level = sender.tag
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            showAlertMessage(title: "Attention!", message: "You have no enough coins to continue")
        }
    }
}

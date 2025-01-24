//
//  TrainingVC.swift
//  SweetLayers
//
//  Created by 1 on 24/01/25.
//

import UIKit

class TrainingVC: UIViewController {
    @IBOutlet weak var centerImageView: UIImageView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTraining()
    }
    
    @IBAction func firstButtonTapped(_ sender: UIButton) {
        if index < 5 {
            index += 1
        } else {
            index = 0
            firstButton.setBackgroundImage(UIImage(named: "nextButton"), for: .normal)
        }
        setupTraining()
        if index == 5 {
            firstButton.setBackgroundImage(UIImage(named: "repeatButton"), for: .normal)
        }
    }
    
    @IBAction func secondButtonTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainGameVC") as! MainGameVC
        vc.level = 0
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupTraining() {
        centerImageView.image = UIImage(named: "trainingCenter\(index)")
        if index == 5 {
            secondButton.isHidden = false
        } else {
            secondButton.isHidden = true
        }
    }
}

//
//  BlowingVC.swift
//  SweetLayers
//
//  Created by 1 on 24/01/25.
//

import UIKit

class BlowingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func nextTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainGameVC") as! MainGameVC
        vc.level = 1
        navigationController?.pushViewController(vc, animated: true)
    }
}

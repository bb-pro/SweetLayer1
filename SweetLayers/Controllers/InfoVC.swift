//
//  InfoVC.swift
//  SweetLayers
//
//  Created by 1 on 17/01/25.
//

import UIKit

class InfoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func xTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

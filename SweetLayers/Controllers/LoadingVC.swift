//
//  ViewController.swift
//  SweetLayers
//
//  Created by 1 on 16/01/25.
//

import UIKit

class LoadingVC: UIViewController {
    @IBOutlet weak var progressView: UIProgressView!
    
    var timer: Timer?
    var progress: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progress = progress
        progressView.layer.masksToBounds = true
        progressView.layer.cornerRadius = 9
        progressView.layer.borderColor = UIColor.black.cgColor
        progressView.layer.borderWidth = 2.0
        kickOffAnimation()
    }

    func kickOffAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.progress += 0.01
            self.progressView.setProgress(self.progress, animated: true)
            if self.progress >= 1.0 {
                self.timer?.invalidate()
                if let vc = storyboard?.instantiateViewController(withIdentifier: "RootNavBar") {
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true)
                }
            }
        }
    }
}


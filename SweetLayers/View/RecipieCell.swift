//
//  RecipieCell.swift
//  SweetLayers
//
//  Created by 1 on 17/01/25.
//

import UIKit
import SnapKit

class RecipieCell: UICollectionViewCell {
    @IBOutlet weak var cakeImageView: UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var lockImageView: UIImageView!
    
    func setupUI(to width: CGFloat, isOpened: Bool, index: Int) {
        cakeImageView.snp.makeConstraints { make in
            make.width.equalTo(width)
        }
        cakeImageView.image = UIImage(named: "cake\(index)")
        lockImageView.isHidden = isOpened
        blurView.isHidden = isOpened
    }
}

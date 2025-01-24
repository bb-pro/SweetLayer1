//
//  UIButton + Extensions.swift
//  SweetLayers
//
//  Created by 1 on 18/01/25.
//

import Foundation

import UIKit

extension UIButton {
    func addMyAction(_ action: @escaping () -> Void) {
        self.addAction(.init(handler: { _ in
            let impactMedia = UIImpactFeedbackGenerator(style: .medium)
            impactMedia.impactOccurred()
            action()
        }), for: .touchUpInside)
    }
}

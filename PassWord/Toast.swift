//
//  Toast.swift
//  PassWord
//
//  Created by cmStudent on 2021/01/06.
//  Copyright © 2021 20cm0119. All rights reserved.
//

import UIKit

class Toast {
    
    internal static func show(_ text: String, _ parent: UIView) {
        
            let label = UILabel()
            let width = parent.frame.size.width
        let height = parent.frame.size.height / 15
     
            label.backgroundColor = UIColor.black.withAlphaComponent(1)
            label.textColor = UIColor.white
            label.textAlignment = .center;
            label.text = text
     
            label.frame = CGRect(x: parent.frame.size.width / 2 - (width / 2), y: parent.frame.size.height - height, width: width, height: height)
            parent.addSubview(label)
     
        UIView.animate(withDuration: 1.0, delay: 2.0, options: .curveEaseOut, animations: {
                label.alpha = 0.0
            }, completion: { _ in
                label.removeFromSuperview()
            })
        }
    
}

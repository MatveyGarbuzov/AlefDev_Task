//
//  Label.swift
//  AlefDev_Task
//
//  Created by Matvey Garbuzov on 25.11.2021.
//

import UIKit

class Label: UIView {
    let label = UILabel()
    
    func setup(title: String) {
        addSubview(label)
        label.pin(to: self)
        label.textColor = .black
        label.textAlignment = .left
        label.text = title
        label.font = label.font.withSize(25)
        label.adjustsFontSizeToFitWidth = true
        setHeight(to: 50)
    }
    
    func setupErrorLabel(title: String) {
        addSubview(label)
        label.pin(to: self)
        label.textColor = Colors.errorRed
        label.textAlignment = .center
        label.text = title
        label.adjustsFontSizeToFitWidth = true
    }
}

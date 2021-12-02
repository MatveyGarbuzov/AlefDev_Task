//
//  Space.swift
//  AlefDev_Task
//
//  Created by Matvey Garbuzov on 25.11.2021.
//

import UIKit

class Space: UIView {
    let spacingLine = UIView()
    
    func setup(color: UIColor) {
        addSubview(spacingLine)
        spacingLine.pinLeft(to: centerXAnchor)
        spacingLine.setHeight(to: 10)
        spacingLine.backgroundColor = color
    }
}

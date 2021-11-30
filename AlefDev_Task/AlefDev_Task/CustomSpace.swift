//
//  CustomSpacingLine.swift
//  AlefDev_Task
//
//  Created by Matvey Garbuzov on 25.11.2021.
//

import UIKit

class CustomSpace: UIView {
    let spacingLine = UIView()
    
    func setup(color: UIColor) {
//        space.setHeight(to: 1)
        addSubview(spacingLine)
        spacingLine.pinLeft(to: centerXAnchor)
        spacingLine.setHeight(to: 10)
        spacingLine.backgroundColor = color
    }
}

//
//  ScrollView.swift
//  AlefDev_Task
//
//  Created by Matvey Garbuzov on 28.11.2021.
//

import UIKit

class ScrollView: UIView {
    let scrollView  = UIScrollView()
    let kidsStack   = Stack()
    let clearButton = CustomButton()
    
    func setup() {
        setupScrollViewConstraints()
        scrollView.contentSize = CGSize(
            width: self.frame.size.width,
            height: self.frame.size.height
        )
        scrollView.isDirectionalLockEnabled = true
        setupStack()
    }
    
    func setupScrollViewConstraints() {
        addSubview(scrollView)
        scrollView.pinTop(to: self)
        scrollView.pinBottom(to: self)
        scrollView.pinLeft(to: self)
        scrollView.pinRight(to: self)
    }

    
    func setupStack() {
        scrollView.addSubview(kidsStack)
        kidsStack.pin(to: scrollView)
        kidsStack.backgroundColor = .white
        kidsStack.setupChildrenStack()
        kidsStack.stack.removeFullyAllArrangedSubviews()
        kidsStack.pinWidth(to: self.widthAnchor)
        kidsStack.stack.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
        kidsStack.stack.isLayoutMarginsRelativeArrangement = true
    }
}


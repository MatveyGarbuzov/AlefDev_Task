//
//  TextHolder.swift
//  AlefDev_TestTask
//
//  Created by Matvey Garbuzov on 23.11.2021.
//

import UIKit

class TextHolder: UIView {
    let textField = TextField()
    let errorLabel = CustomErrorImage()
    
    func setup(title: String) {
        self.addSubview(textField)
        
        textField.backgroundColor = .white
        textField.clearButtonMode = .whileEditing
        
        textField.pin(to: self)
        setupErrorImageConstraint()
        errorLabel.setup()
    
        textField.borderStyle = .line
        textField.layer.borderWidth = 0.3
        textField.layer.cornerRadius = 5
        
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: title,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
        textField.setLeftPaddingPoints(10)
        
        if (title == "Имя") {
            textField.addTarget(
                self,
                action: #selector(isNameHolderCorrect),
                for: .allEditingEvents)
        } else if (title == "Возраст") {
            textField.addTarget(
                self,
                action: #selector(isAgeHolderCorrect),
                for: .allEditingEvents)
        }
    }
    
    func setupErrorImageConstraint() {
        self.addSubview(errorLabel)
        
        errorLabel.pinTop(to: textField, 10)
        errorLabel.pinBottom(to: textField, 5)
        errorLabel.pinRight(to: textField, 30)
        errorLabel.pinLeft(to: textField.trailingAnchor, -60)
        
        errorLabel.isHidden = true
    }
    
    
    // Эта функция проверяет на корректность ввода в name TextField
    @objc func isNameHolderCorrect() {
        guard let text = textField.text else { return }
        errorLabel.checkForNameError(text: text)
    }
    
    @objc func isAgeHolderCorrect() {
        guard let text = textField.text else { return }
        errorLabel.checkForAgeError(text: text)
    }
    
}

class TextField: UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

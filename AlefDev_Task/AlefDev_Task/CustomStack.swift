//
//  CustomStack.swift
//  AlefDev_Task
//
//  Created by Matvey Garbuzov on 25.11.2021.
//

import UIKit

class CustomStack: UIView {
    var stack = UIStackView()
    
    let name        = TextHolder()
    let age         = TextHolder()
    let errorLabel  = CustomLabel()
    let label       = CustomLabel()
    let space       = CustomSpace()
    let spacingLine = CustomSpace()
    let button      = RoundedButton()
    let clearButton = RoundedButton()
    
    func setupStack() {
        name.setup(title: "Имя")
        age.setup(title: "Возраст")
        age.textField.keyboardType = .numberPad
        errorLabel.setupErrorLabel(title: "")
        stack = UIStackView(arrangedSubviews: [
            name,
            age,
            errorLabel
        ])
        
//        name.textField.backgroundColor = .blue
//        age.textField.backgroundColor = .blue
//        errorLabel.backgroundColor = .blue
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        setHeight(to: 160)
        
        addSubview(stack)
        stack.pin(to: self)
    }
    
    func setupHorizontalStack() {
        label.setup(title: "Дети (макс. 5)")
        button.setup(
            title: "Добавить ребёнка",
            selector: #selector(ViewController.childrenButtonPressed(sender:)),
            borderColor: Colors.borderBlue,
            textColor: Colors.textBlue
        )
        
        stack = UIStackView(arrangedSubviews: [
            label,
            button
        ])
        
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        
        setHeight(to: 50)
        
        addSubview(stack)
        stack.pin(to: self)
    }
    
    func setupChildrenStack() {
        name.setup(title: "Имя")
        button.setup(
            title: "Удалить",
            selector: #selector(ViewController.deleteButtonPressed(sender:)),
            borderColor: .clear,
            textColor: Colors.textBlue
        )
        
        let horizontalStackName = UIStackView(arrangedSubviews: [name, button])
        horizontalStackName.axis = .horizontal
        horizontalStackName.distribution = .fillEqually
        horizontalStackName.spacing = 10
        
        age.setup(title: "Возраст")
        age.textField.keyboardType = .numberPad
        
        let horizontalStackAge = UIStackView(arrangedSubviews: [age, space])
        horizontalStackAge.axis = .horizontal
        horizontalStackAge.distribution = .fillEqually
        horizontalStackAge.spacing = 10
        
        spacingLine.setup(color: Colors.spacingLineGray)
        
        horizontalStackName.setHeight(to: Sizes.kidNameHeight)
        horizontalStackAge.setHeight(to: Sizes.kidAgeHeight)
        
        let filler = UIView()
        filler.setHeight(to: Sizes.kdiFillerHeight)
        
        stack = UIStackView(arrangedSubviews: [
            horizontalStackName,
            horizontalStackAge,
            filler
        ])
        
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 10
        
        
        addSubview(stack)
        stack.pin(to: self)
    }
    
    func setupEmptyStack() {
        stack = UIStackView(arrangedSubviews: [])
        
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        
        setHeight(to: 100)
        
        addSubview(stack)
        stack.pin(to: self)
    }
    
    func animate() {
        UIView.animate(withDuration: 0.15, animations: {
            self.transform = self.transform.scaledBy(x: 1.05, y: 1.05)
        }) { _ in
            UIView.animate(withDuration: 0.15, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }
    
    func animateTransition(view: UIView) {
        if view.alpha == 0 {
            UIView.animate(withDuration: 0.3) {
                view.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                view.alpha = 0
            }
        }
    }
}

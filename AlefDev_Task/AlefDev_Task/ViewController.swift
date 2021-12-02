//
//  ViewController.swift
//  AlefDev_Task
//
//  Created by Matvey Garbuzov on 25.11.2021.
//

import UIKit

class ViewController: UIViewController {
    var mainStack = UIStackView()
    var count = 0
    
    let personDataLabel = CustomLabel()
    static let personalDataStack = CustomStack()
    let labelAndButtonHorizontalStack = CustomStack()
    let kidsScrollView = CustomScrollView()
    let clearButton = RoundedButton()
    let filler = UIView()
    
    let bottomSpacer = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        personDataLabel.setup(title: "Персональные данные")
        ViewController.personalDataStack.setupStack()
        labelAndButtonHorizontalStack.setupHorizontalStack()
        kidsScrollView.setup()
        kidsScrollView.setHeight(to: 250)
        clearButton.setup(
            title: "Очистить",
            selector: #selector(clearButtonPressed(sender:)),
            borderColor: Colors.clearButtonRed,
            textColor: Colors.clearButtonRed
        )
        clearButton.setHeight(to: 50)
        clearButton.alpha = 0
        // ?КОСТЫЛЬ?
        bottomSpacer.setHeight(to: Double(view.frame.height - mainStack.frame.height))
        
        
        
        mainStack = createMyStack()
//        setBackgroundColorsForStack(color: .purple)
        view.addSubview(mainStack)
        mainStack.pin(to: view)
        
        
        
        ViewController.personalDataStack.errorLabel.label.text = ""
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }

    
    func createMyStack() -> UIStackView {
        filler.setHeight(to: 10)
        let stack = UIStackView(arrangedSubviews: [
            personDataLabel,
            ViewController.personalDataStack,
            labelAndButtonHorizontalStack,
            kidsScrollView,
            clearButton,
            filler
        ])
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 10

        return stack
    }
    
    func setBackgroundColorsForStack(color: UIColor) {
        for element in mainStack.arrangedSubviews {
            element.backgroundColor = color
        }
    }
    
    @objc func childrenButtonPressed(sender: CustomButton) {
        sender.animate()
        let childrenDataStack = CustomStack()
        childrenDataStack.setupChildrenStack()
//        childrenDataStack.setWidth(to: Double(kidsScrollView.frame.size.width))
//        childrenDataStack.name.setHeight(to: 75)
//        childrenDataStack.name.setHeight(to: 75)
//        childrenDataStack.stack.setHeight(to: 150)
        
        kidsScrollView.scrollView.addSubview(childrenDataStack)
        kidsScrollView.addSubview(childrenDataStack)
//        mainStack.insertArrangedSubview(childrenDataStack, at: 3)
        
        kidsScrollView.kidsStack.stack.insertArrangedSubview(childrenDataStack, at: 0)
        
        childrenDataStack.animate()
        if (count == 0) {
            clearButton.animateTransition(view: clearButton)
        }
        count += 1
        if (count == 5) {
            sender.disable()
        }
    }
    
    @objc func clearButtonPressed(sender: CustomButton) {
        sender.animate()
        clearButton.animateTransition(view: clearButton)
        kidsScrollView.kidsStack.stack.removeFullyAllArrangedSubviews()
        count = 0
    }
    
    @objc func deleteButtonPressed(sender: CustomButton) {
        print("deleteButtonPressed")
        sender.animate()
        if kidsScrollView.kidsStack.stack.arrangedSubviews.count == 0 {
            return
        }
        let last = kidsScrollView.kidsStack.stack.arrangedSubviews.count - 1
        print(last)
        let view = kidsScrollView.kidsStack.stack.arrangedSubviews[last]
        view.removeFromSuperview()
        
        count -= 1
        if count == 4 {
            labelAndButtonHorizontalStack.button.button.enable()
        }
        if (count == 0) {
            clearButton.animateTransition(view: clearButton)
        }
    }
    
    @objc func errorButtonPressed(sender: CustomButton) {
        
        sender.animate()
        print("errorButtonPressed")
//        sender.backgroundColor = .blue
    }
    
    @objc func errorButtonPressed2() {
        print("errorButtonPressed")
    }

}


extension UIStackView {

    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }

}

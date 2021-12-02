//
//  ViewController.swift
//  AlefDev_Task
//
//  Created by Matvey Garbuzov on 25.11.2021.
//

import UIKit

class ViewController: UIViewController {
    var mainStack = UIStackView()
    var kidsCount = 0
    
    let personalDataLabel             = Label()
    static let personalDataStack      = Stack()
    let labelAndButtonHorizontalStack = Stack()
    let kidsScrollView                = ScrollView()
    let clearButton                   = RoundedButton()
    let filler                        = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    func setupView() {
        view.backgroundColor = .white
        addCancelEditing()
        setupStack()
    }
    
    func addCancelEditing() {
        // Need this to cancel editing in textHolder by tapping anywhere
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func setupStack() {
        mainStack = createMyStack()
        view.addSubview(mainStack)
        mainStack.pin(to: view)
    }
    
    func createMyStack() -> UIStackView {
        setupStackElements()
        let stack = UIStackView(arrangedSubviews: [
            personalDataLabel,
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
    
    func setupStackElements() {
        personalDataLabel.setup(title: "Персональные данные")
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
        filler.setHeight(to: 10)
    }
    
    @objc func childrenButtonPressed(sender: CustomButton) {
        sender.animate()
        
        let childrenDataStack = Stack()
        childrenDataStack.animate()
        childrenDataStack.setupChildrenStack()
        
        kidsScrollView.scrollView.addSubview(childrenDataStack)
        kidsScrollView.kidsStack.stack.insertArrangedSubview(childrenDataStack, at: 0)
        kidsScrollView.kidsStack.alpha = 1
        
        if (kidsCount == 0) {
            clearButton.animateTransition(view: clearButton)
        }
        kidsCount += 1
        if (kidsCount == 5) {
            sender.disable()
        }
    }
    
    @objc func clearButtonPressed(sender: CustomButton) {
        sender.animate()
        
        // Create actiohSheet
        let actionSheetController: UIAlertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )

        let firstAction: UIAlertAction = UIAlertAction(
                title: "Сбросить данные", style: .destructive) { action -> Void in
            self.clearButton.animateTransition(view: self.clearButton)
            self.kidsScrollView.kidsStack.animateTransition(view: self.kidsScrollView.kidsStack)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.kidsScrollView.kidsStack.stack.removeFullyAllArrangedSubviews()
            }
            self.kidsCount = 0
            self.labelAndButtonHorizontalStack.button.button.enable()
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }

        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(cancelAction)

        actionSheetController.popoverPresentationController?.sourceView = sender // works for iPhone & iPad
        present(actionSheetController, animated: true)
    }
    
    @objc func deleteButtonPressed(sender: CustomButton) {
        sender.animate()
        if kidsScrollView.kidsStack.stack.arrangedSubviews.count == 0 { return }
        
        let last = kidsScrollView.kidsStack.stack.arrangedSubviews.count - 1
        let view = kidsScrollView.kidsStack.stack.arrangedSubviews[last]
        view.removeFromSuperview()
        
        kidsCount -= 1
        if kidsCount == 4 {
            labelAndButtonHorizontalStack.button.button.enable()
        }
        if (kidsCount == 0) {
            clearButton.animateTransition(view: clearButton)
        }
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

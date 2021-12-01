//
//  CustomWarningView.swift
//  AlefDev_Task
//
//  Created by Matvey Garbuzov on 26.11.2021.
//

import UIKit

class CustomErrorImage: UIView {
    var errorImage = UIImageView()
    var currentError = UILabel()
    
    func setup() {
        addImageToView()
        addActionToView()
    
        addSubview(errorImage)
        errorImage.frame   = CGRect(x: 0, y: 0, width: 25, height: 25)
        print(self.frame.height)
    }
    
    func addImageToView() {
        let imageName = "error.png"
        let image = UIImage(named: imageName)
        errorImage = UIImageView(image: image!)
        errorImage.setImageColor(color: Colors.errorRed)
    }
    
    func addActionToView() {
        errorImage.isUserInteractionEnabled = true
        errorImage.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(errorImageTapped(_:))
        ))
    }
    
    func animate() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = self.transform.scaledBy(x: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }
    
    func animateErrorLabel() {
        let myView = ViewController.personalDataStack.errorLabel.label
        UIView.animate(withDuration: 0.1, animations: {
            myView.transform = myView.transform.scaledBy(x: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                myView.transform = CGAffineTransform.identity
            })
        }
    }
    
    func animateTransition(view: UIView) {
        UIView.transition(
            with: view, duration: 0.4,
            options: .transitionCrossDissolve,
            animations: {
                view.isHidden = false
            }
        )
    }
    
    func checkForNameError(text: String) {
        isOneLetterName(text: text)
        isOneLanguageAndSpecialSymbols(text: text)
        isNumberInName(text: text)
    }
    
    func checkForAgeError(text: String) {
        isAgeRelevant(text: text)
    }
    
    func isOneLetterName(text: String) {
        if (text.count == 1) {
//            errorDetected(errorName: "Only one letter")
            errorDetected(errorName: "В имени не может быть одна буква")
        } else {
            errorDetected(errorName: nil)
            currentError.text = nil
        }
    }
    
    func isNumberInName(text: String) {
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = text.rangeOfCharacter(from: decimalCharacters)
        if decimalRange != nil {
//            errorDetected(errorName: "Number in name")
            errorDetected(errorName: "В имени не могут быть цифры")
        } else if (currentError.text == nil) {
            errorDetected(errorName: nil)
            currentError.text = nil
        }
    }
    
    func isOneLanguageAndSpecialSymbols(text: String) {
        let russian = isRussian(text: text)
        let english = isEnglish(text: text)
        let special = isNoSpecialSymbols(text: text)
        print("Russian: \(russian)")
        print("English: \(english)")
        print("Special: \(special)")
        
        if (russian == false && english == false) {
//            errorDetected(errorName: "Two languages")
            errorDetected(errorName: "В имени не может быть два языка")
        } else if (currentError.text == nil) {
            errorDetected(errorName: nil)
            currentError.text = nil
        }
        if special == true && text != "" && (!russian || !english) {
//            errorDetected(errorName: "Special Cymbol")
            errorDetected(errorName: "В имени не могут быть специальные символы")
        }
    }
    
    func isEnglish(text: String) -> Bool {
        let englishAlphabet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        if text.rangeOfCharacter(from: englishAlphabet.inverted) == nil {
            return true
        }
        return false
    }
    
    func isRussian(text: String) -> Bool {
        let russianAlhabet = CharacterSet(charactersIn: "абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ")
        if text.rangeOfCharacter(from: russianAlhabet.inverted) == nil {
            return true
        }
        return false
    }
    
    func isNoSpecialSymbols(text: String) -> Bool {
        let specialSymbols = CharacterSet(charactersIn: ",./;'[]!@#$%^&*()_-+=~`{}\\|\":<>?")
        if text.rangeOfCharacter(from: specialSymbols.inverted) == nil {
            return true
        } else if (currentError.text == nil) {
            return false
        }
        return false
    }
    
    // Проверка на адекватность возраста
    func isAgeRelevant(text: String?) {
        if (text == "") {
            errorDetected(errorName: nil)
            currentError.text = nil
        } else {
            guard let age = Int(text ?? "") else { return }
            if (age <= 3 || 95 <= age) {
//                errorDetected(errorName: "Age is not relevant")
                errorDetected(errorName: "Некорректный возраст")
            } else {
                errorDetected(errorName: nil)
                currentError.text = nil
            }
        }
        if (currentError.text == nil) {
            errorDetected(errorName: nil)
            currentError.text = nil
        }
    }
    
    func errorDetected(errorName text: String?) {
        let myView = ViewController.personalDataStack.errorLabel.label
//        print("|||Text: \(text)")
//        print("|||currentError: \(currentError.text)")
        if (text == nil && currentError.text == nil) {
            self.isHidden = true
            self.animate()
//            print("correct")
        } else {
            self.isHidden = false
            self.animate()
//            print("ErrorName: \"\(text ?? "unknown")\"")
            animateTransition(view: myView)
            myView.text = text
            currentError.text = text
        }
    }
    
    @objc private func errorImageTapped(_ recognizer: UITapGestureRecognizer) {
        animate()
        animateErrorLabel()
    }
}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

//
//  ButtonClass.swift
//  AlefDev_TestTask
//
//  Created by Matvey Garbuzov on 23.11.2021.
//

import UIKit

final class RoundedButton: UIView {
    let button = CustomButton(type: .system)
    
    func setup(title: String, selector: Selector, borderColor: UIColor, textColor: UIColor) {
        self.addSubview(button)
        button.pin(to: self)
        button.setup(title: title, selector: selector,
                     borderColor: borderColor, textColor: textColor)
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

class CustomButton: UIButton {
    func setup(title: String, selector: Selector,
               borderColor: UIColor, textColor: UIColor) {
        isEnabled = true
        backgroundColor = .white
        layer.borderWidth = 2
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = 25
        
        setTitle(title, for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 0.5
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        addTarget(nil, action: selector, for: .touchUpInside)
    }
    
    func animate(scaledByX x:CGFloat = 0.95, scaledByY y:CGFloat = 0.95) {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = self.transform.scaledBy(x: x, y: y)
            
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }
    
    func disable(count : Float = 3, for duration : TimeInterval = 0.2,
                 withTranslation translation : Float = 5) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
        layer.borderColor = UIColor.gray.cgColor
        setTitleColor(.gray, for: .normal)
        isEnabled = false
    }
    
    func enable() {
        animate(scaledByX: 1.03, scaledByY: 1.03)
        layer.borderColor = Colors.borderBlue.cgColor
        setTitleColor(Colors.textBlue, for: .normal)
        isEnabled = true
    }
}

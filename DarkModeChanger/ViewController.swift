//
//  ViewController.swift
//  DarkModeChanger
//
//  Created by Semyon Chulkov on 18.07.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    private let colorChangerView = ColorChangerView()
    private var snapshot: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        themeProvider.register(observer: self)
        setupLayout()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return themeProvider.theme == .dark ? .lightContent : .default
    }
    
    func setupLayout() {
        
        view.addSubview(colorChangerView)
        colorChangerView.delegate = self
        colorChangerView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            colorChangerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorChangerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colorChangerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            colorChangerView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
    }
}

extension ViewController: SwitchDelegate, CAAnimationDelegate {
    
    func didTriggerSwitch(_ sender: UISwitch) {
        
        snapshot = view.snapshotView(afterScreenUpdates: true)
        
        view.addSubview(snapshot!)
        snapshot?.layer.zPosition = -1
        
        self.themeProvider.toggleTheme()
        self.animate(toView: self.snapshot!, fromTriggerSwitch: sender)
    }
    
    func animate(toView: UIView, fromTriggerSwitch triggerSwitch: UISwitch) {
        let rect = CGRect(x: triggerSwitch.center.x,
                          y: triggerSwitch.center.y,
                          width: triggerSwitch.frame.width,
                          height: triggerSwitch.frame.width)
        let circleMaskPathInitial = UIBezierPath(ovalIn: rect)
        let fullHeight = toView.bounds.height
        let extremePoint = CGPoint(x: triggerSwitch.center.x,
                                   y: triggerSwitch.center.y - fullHeight)
        let radius = sqrt((extremePoint.x*extremePoint.x) +
                          (extremePoint.y*extremePoint.y))
        let circleMaskPathFinal = UIBezierPath(ovalIn: triggerSwitch.frame.insetBy(dx: -radius,
                                                                                   dy: -radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.cgPath
        ///we add mask to the view we want to see changed
        colorChangerView.layer.mask = maskLayer
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.cgPath
        maskLayerAnimation.toValue = circleMaskPathFinal.cgPath
        maskLayerAnimation.duration = 0.7
        maskLayerAnimation.delegate = self
        maskLayer.add(maskLayerAnimation, forKey: "path")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        snapshot?.removeFromSuperview()
        snapshot = nil
    }
    
}

extension ViewController: Themeable {
    func apply(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
    }
}


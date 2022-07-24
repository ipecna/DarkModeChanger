//
//  ColorChangerView.swift
//  DarkModeChanger
//
//  Created by Semyon Chulkov on 18.07.2022.
//

import UIKit

class ColorChangerView: UIView {
    lazy private var darkModeLabel: UILabel = {
        var label = UILabel()
        label.text = "Change application theme"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = themeProvider.theme.labelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var darkModeSwitch: UISwitch = {
        var darkSwitch = UISwitch()
        darkSwitch.isOn = themeProvider.theme == .dark ? false : true
        darkSwitch.translatesAutoresizingMaskIntoConstraints = false
        darkSwitch.addTarget(nil, action: #selector(didTriggerSwitch), for: .valueChanged)
        return darkSwitch
    }()
    
    lazy private var darkModeStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [darkModeLabel, darkModeSwitch])
        stack.spacing = 20
        stack.axis = .horizontal
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy private var textLabel: UILabel = {
        var label = UILabel()
        label.text =
        """
        Another head hangs lowly
        Child is slowly taken
        And the violence, caused such silence
        Who are we mistaken?
        
        But you see, it's not me
        It's not my family
        In your head, in your head, they are fighting
        With their tanks, and their bombs
        And their bombs, and their guns
        In your head, in your head they are crying
        
        """
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = themeProvider.theme.labelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var mainStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [darkModeStack, textLabel])
        stack.spacing = 20 
        stack.axis = .vertical
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    weak var delegate: SwitchDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func setupLayout() {
        backgroundColor = themeProvider.theme.backgroundColor
        themeProvider.register(observer: self)
        addSubview(mainStack)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
    @objc
    func didTriggerSwitch(_ sender: UISwitch) {
        delegate?.didTriggerSwitch(sender)
    }
}

extension ColorChangerView : Themeable {
    func apply(theme: Theme) {
        textLabel.textColor = theme.textColor
        darkModeLabel.textColor = theme.labelColor
        backgroundColor = theme.backgroundColor
    }
}

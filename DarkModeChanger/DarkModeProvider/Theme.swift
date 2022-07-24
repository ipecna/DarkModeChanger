//
//  Theme.swift
//  DarkModeChanger
//
//  Created by Semyon Chulkov on 18.07.2022.
//

import UIKit

protocol Themeable: AnyObject {
    func apply(theme: Theme)
}

extension Themeable where Self: UITraitEnvironment {
    var themeProvider: ThemeProvider {
        return LegacyThemeProvider.shared
    }
}

struct Theme: Equatable {
    static let light = Theme(type: .light, colors: .light)
    static let dark = Theme(type: .dark, colors: .dark)
    
    enum `Type` {
        case light
        case dark
    }
    
    let type: Type

    let backgroundColor: UIColor
    let labelColor: UIColor
    let textColor: UIColor
    
    /// here we must init color names that we assigned in color palette
    init(type: Type, colors: ColorPalette) {
        self.type = type
        self.backgroundColor = colors.backgroundColor
        self.labelColor = colors.labelColor
        self.textColor = colors.textColor
        //TODO: Add more colors
    }
    
    public static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.type == rhs.type
    }
}

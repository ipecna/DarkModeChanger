//
//  ColorPalette.swift
//  DarkModeChanger
//
//  Created by Semyon Chulkov on 18.07.2022.
//

import UIKit.UIColor
import UIKit

struct ColorPalette {
    ///here we add color names we want in our project
    let backgroundColor: UIColor
    let labelColor: UIColor
    let textColor: UIColor
    
    ///assign colors for color names for light mode
    static let light: ColorPalette = .init (
        backgroundColor: UIColor.white,
        labelColor: UIColor.black,
        textColor: UIColor.black.withAlphaComponent(0.8)
    )
    
    ///assign colors for color names for dark mode
    static let dark: ColorPalette = .init(
        backgroundColor: UIColor.black,
        labelColor: UIColor.white,
        textColor: UIColor.white.withAlphaComponent(0.8)
        
    )
}

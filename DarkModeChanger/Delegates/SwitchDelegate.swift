//
//  SwitchDelegate.swift
//  DarkModeChanger
//
//  Created by Semyon Chulkov on 18.07.2022.
//

import UIKit

protocol SwitchDelegate: AnyObject {
    func didTriggerSwitch(_ sender: UISwitch)
}

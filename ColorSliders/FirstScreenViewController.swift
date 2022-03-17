//
//  FirstScreenViewController.swift
//  ColorSliders
//
//  Created by mac mini on 3/17/22.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewColor(for color: UIColor)
}

class FirstScreenViewController: UIViewController {
    
    var currentColor: CIColor {
        CIColor(color: view.backgroundColor ?? .white)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.viewColor = currentColor
        settingsVC.delegate = self
    }
}

//MARK: - SettingsViewControllerDelegate
extension FirstScreenViewController: SettingsViewControllerDelegate {
    func setNewColor(for color: UIColor) {
        view.backgroundColor = color
    }
    
    
}

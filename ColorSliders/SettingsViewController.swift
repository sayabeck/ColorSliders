//
//  SettingsViewController.swift
//  ColorSliders
//
//  Created by mac mini on 3/10/22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redLabelTF: UITextField!
    @IBOutlet weak var greenLabelTF: UITextField!
    @IBOutlet weak var blueLabelTF: UITextField!
    
    var viewColor: CIColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewWillAppear(_ animated: Bool) {
        redSlider.value = Float(viewColor.red)
        greenSlider.value = Float(viewColor.green)
        blueSlider.value = Float(viewColor.blue)
        
        redValueChanged()
        greenValueChanged()
        blueValueChanged()
        
        colorView.backgroundColor = UIColor(ciColor: viewColor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 20
        
        redLabelTF.delegate = self
        greenLabelTF.delegate = self
        blueLabelTF.delegate = self
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        switch sender {
        case redSlider: redValueChanged()
        case greenSlider: greenValueChanged()
        default: blueValueChanged()
        }
        
        colorChanged()
    }
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        delegate.setNewColor(for: colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
}

//MARK: - Private method
extension SettingsViewController {
    private func colorChanged() {
        
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
    }
    
    private func redValueChanged() {
        redLabel.text = String(format: "%.2f", redSlider.value)
        redLabelTF.text = String(format: "%.2f", redSlider.value)
    }
    
    private func greenValueChanged() {
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        greenLabelTF.text = String(format: "%.2f", greenSlider.value)
    }
    
    private func blueValueChanged() {
        blueLabel.text = String(format: "%.2f", blueSlider.value)
        blueLabelTF.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let decimalNumber = Float(textField.text ?? "0") else {
            return showAlert(
                title: "Incorrect value",
                message: "Please, entry a decimal value in the format: 0.00")}
        switch textField {
        case redLabelTF:
            redSlider.value = decimalNumber
            redValueChanged()
        case greenLabelTF:
            greenSlider.value = decimalNumber
            greenValueChanged()
        default:
            blueSlider.value = decimalNumber
            blueValueChanged()
        }
        
        colorChanged()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}


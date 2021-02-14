//
//  Task_a_ViewController.swift
//  homeWork 14
//
//  Created by Андрей Таланчук on 30.01.2021.
//

import UIKit

class Task_a_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstNameTaexField.text = Persistance.persistanse.userFirstName
        self.secondNameTextField.text = Persistance.persistanse.userSecondName
    }
    
    @IBOutlet weak var firstNameTaexField: UITextField!
    
    @IBOutlet weak var secondNameTextField: UITextField!
    
    @IBAction func firstNameTextAction(_ sender: Any) {
        Persistance.persistanse.userFirstName = self.firstNameTaexField.text
    }

    @IBAction func secondNameTextAction(_ sender: Any) {
        Persistance.persistanse.userSecondName = self.secondNameTextField.text
    }
}

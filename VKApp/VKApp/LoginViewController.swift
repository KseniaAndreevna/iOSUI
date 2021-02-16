//
//  ViewController.swift
//  VKApp
//
//  Created by Ksusha on 12.02.2021.
// 


import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        passwordTextField.isSecureTextEntry = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        print("Login: \(loginTextField.text ?? "")")
        print("Password: \(passwordTextField.text ?? "")")
    }
}




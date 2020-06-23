//
//  LoginViewController.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 10/05/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import UIKit
import PureLayout

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    var quizNameLabel: UILabel!
    
    var usernameTextField: UITextField!
    
    var passwordTextField: UITextField!
    
    var loginButton: UIButton!
    
    var textFields: [UITextField] {
        return [usernameTextField, passwordTextField]
    }
    
    private let loginService = LoginService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        createConstraints()
        textFields.forEach { $0.delegate = self }
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden  = true
        usernameTextField.text = ""
        passwordTextField.text = ""
        usernameTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func buildViews() {
        quizNameLabel = UILabel()
        quizNameLabel.text = "QUIZZOO"
        quizNameLabel.textAlignment = .center
        view.addSubview(quizNameLabel)
        
        let color = UIColor.black
        
        usernameTextField = UITextField()
        usernameTextField.autocapitalizationType = .none
        usernameTextField.clearButtonMode = .whileEditing
        usernameTextField.autocorrectionType = .no
        usernameTextField.autoSetDimensions(to: .init(width: 300, height: 35))
        usernameTextField.placeholder = "Username"
        usernameTextField.layer.borderColor = color.cgColor
        usernameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(usernameTextField)
        
        passwordTextField = UITextField()
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autoSetDimensions(to: .init(width: 300, height: 35))
        passwordTextField.layer.borderColor = color.cgColor
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(passwordTextField)
        
        loginButton = UIButton()
        loginButton.autoSetDimensions(to: .init(width: 300, height: 35))
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.backgroundColor = UIColor(red: 0.3451, green: 0.6627, blue: 0.9373, alpha: 1.0)
        loginButton.addTarget(self, action: #selector(onClickLogin(_:)), for: .touchUpInside)
        view.addSubview(loginButton)
    }
    
    func createConstraints() {
        quizNameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 200)
        quizNameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        quizNameLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 50)
        
        usernameTextField.autoPinEdge(.top, to: .bottom, of: quizNameLabel, withOffset: 40)
        usernameTextField.autoAlignAxis(.vertical, toSameAxisOf: quizNameLabel)
        
        passwordTextField.autoPinEdge(.top, to: .bottom, of: usernameTextField, withOffset: 20)
        passwordTextField.autoAlignAxis(.vertical, toSameAxisOf: usernameTextField)
        
        loginButton.autoPinEdge(.top, to: .bottom, of: passwordTextField, withOffset: 30)
        loginButton.autoAlignAxis(.vertical, toSameAxisOf: passwordTextField)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let selectedTextFieldIndex = textFields.firstIndex(of: textField), selectedTextFieldIndex < textFields.count - 1 {
            textFields[selectedTextFieldIndex + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @objc func onClickLogin(_ sender: UIButton) {
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        loginService.doLogin(username!,password!){ token,id in
            self.checkToken(token: token,id: id,username: username!)
        }
    }
    
    func checkToken(token : String?,id: Int?, username: String?) {
        guard let token = token else {
            DispatchQueue.main.sync{
                let alert = UIAlertController(title: "Alert", message: "Username or password is incorrect!", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                present(alert,animated: true,completion:nil)
            }
            return
        }
        
        DispatchQueue.main.sync{
            let defaults = UserDefaults.standard
            defaults.set(token, forKey: "accessToken")
            defaults.set(id, forKey: "Id")
            defaults.set(username, forKey: "username")
            print("USPJESNO")
            
            let vc = TabBarController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
}


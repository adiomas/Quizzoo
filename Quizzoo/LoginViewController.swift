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
    var usernameTextFieldConstraint: NSLayoutConstraint?
    var passwordTextField: UITextField!
    var passwordTextFieldConstraint: NSLayoutConstraint?
    
    
    var loginButton: UIButton!
    var loginButtonConstraint: NSLayoutConstraint?
    
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 2.1, animations: {
            self.quizNameLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.quizNameLabel.alpha = 1
        }) { _ in
        }
        UIView.animate(withDuration: 1.5, delay: 0.1, options: .curveEaseInOut, animations: {
            self.usernameTextField.transform = CGAffineTransform.identity
            self.usernameTextField.alpha = 1
        }) { _ in
        }
        UIView.animate(withDuration: 1.5, delay: 0.35, options: .curveEaseInOut, animations: {
            self.passwordTextField.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.passwordTextField.alpha = 1
        }) { _ in
        }
        UIView.animate(withDuration: 1.5, delay: 0.60, options: .curveEaseInOut, animations: {
            self.loginButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.loginButton.alpha = 1
        }) { _ in
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden  = true
        
        
        usernameTextField.text = ""
        passwordTextField.text = ""
        usernameTextField.becomeFirstResponder()
        
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0, animations: {
            self.quizNameLabel.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.quizNameLabel.alpha = 0
            self.usernameTextField.transform = CGAffineTransform(translationX: -self.view.bounds.size.width, y: 0)
            self.usernameTextField.alpha = 0
            self.passwordTextField.transform = CGAffineTransform(translationX: -self.view.bounds.size.width, y: 0)
            self.passwordTextField.alpha = 0
            self.loginButton.transform = CGAffineTransform(translationX: -self.view.bounds.size.width, y: 0)
            self.loginButton.alpha = 0
            
        }) { _ in
        }
        
        
        
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
        animateEveryThingOut()
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
    
    func animateEveryThingOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.quizNameLabel.transform = CGAffineTransform(translationX: 0, y: -200)
            self.quizNameLabel.alpha = 0.0
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.15 , animations: {
            self.usernameTextField.transform = CGAffineTransform(translationX: 0, y: -200)
            self.usernameTextField.alpha = 0.0
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.30, animations: {
            self.passwordTextField.transform = CGAffineTransform(translationX: 0, y: -200)
            self.passwordTextField.alpha = 0.0
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.45, animations: {
            self.loginButton.transform = CGAffineTransform(translationX: 0, y: -200)
            self.loginButton.alpha = 0.0
        }) { _ in
        }
        
    }
    
}


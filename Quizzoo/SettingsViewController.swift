//
//  SettingsViewController.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 21/06/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var usernameLabel : UILabel!
    var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildViews()
        createConstraints()
    }
    
    func buildViews() {
        let username = (UserDefaults.standard.value(forKeyPath: "username")! as! String)
        
        usernameLabel = UILabel()
        usernameLabel.text = "Username: " + username
        usernameLabel.textAlignment = .center
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(usernameLabel)
        
        logoutButton = UIButton()
        logoutButton.setTitle("LOGOUT", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.layer.cornerRadius = 5
        logoutButton.layer.borderWidth = 1
        logoutButton.autoSetDimensions(to: .init(width: 150, height: 35))
        logoutButton.backgroundColor = UIColor(red: 0.3451, green: 0.6627, blue: 0.9373, alpha: 1.0)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        view.addSubview(logoutButton)
        
    }
    
    func createConstraints() {
        usernameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 150)
        usernameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        usernameLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
        logoutButton.autoPinEdge(.top, to: .bottom, of: usernameLabel, withOffset: 10)
        logoutButton.autoAlignAxis(.vertical, toSameAxisOf: usernameLabel)
    }
    
    @objc func logout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "accessToken")
        defaults.removeObject(forKey: "Id")
        defaults.removeObject(forKey: "username")
        //        self.navigationController?.popToRootViewController(animated: true)
        self.tabBarController?.navigationController?.popToRootViewController(animated: true)
        
        
        
    }
    
    
}

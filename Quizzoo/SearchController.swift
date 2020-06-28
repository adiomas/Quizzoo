//
//  SeachController.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 21/06/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import UIKit

class SearchController: UIViewController {

    var searchTextField : UITextField!
    
    var searchButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildViews()
        createConstraints()
    }
    
    func buildViews() {
        searchTextField = UITextField()
        searchTextField.autocapitalizationType = .none
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.autocorrectionType = .no
        searchTextField.autoSetDimensions(to: .init(width: 300, height: 35))
        searchTextField.placeholder = "Search"
        searchTextField.layer.borderColor = UIColor.black.cgColor
        searchTextField.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(searchTextField)
        
        searchButton = UIButton()
        searchButton.autoSetDimensions(to: .init(width: 150, height: 35))
        searchButton.setTitle("SEARCH", for: .normal)
        searchButton.layer.cornerRadius = 5
        searchButton.layer.borderWidth = 1
        searchButton.backgroundColor = UIColor(red: 0.3451, green: 0.6627, blue: 0.9373, alpha: 1.0)
        searchButton.addTarget(self, action: #selector(onClickSearch(_:)), for: .touchUpInside)
        view.addSubview(searchButton)
    }
    
  
    
    func createConstraints() {
        searchTextField.autoPinEdge(toSuperviewEdge: .top, withInset: 150)
        searchTextField.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        searchTextField.autoPinEdge(toSuperviewEdge: .trailing, withInset: 50)
        
        searchButton.autoPinEdge(.top, to: .bottom, of: searchTextField, withOffset: 20)
        searchButton.autoAlignAxis(.vertical, toSameAxisOf: searchTextField)
        
    }
    
    @objc func onClickSearch(_ sender: UIButton) {
            
         }

   

}

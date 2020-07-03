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
    
    var tableView = UITableView()
    
    var searchAgainButton : UIButton!
    
    var quizViewModel: QuizViewModel!
    
    var refreshControl: UIRefreshControl!
    
    var quizes : [Quiz]?
    
    convenience init(viewModel: QuizViewModel) {
        self.init()
        self.quizViewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildViews()
        setTableViewDelegates()
        createConstraints()
    }
    
    func buildViews() {
        view.addSubview(tableView)
        tableView.isHidden = true
        tableView.rowHeight = 100
        tableView.register(QuizzesCell.self, forCellReuseIdentifier: "QuizzesCell")
        
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

    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SearchController.refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            self.tableView.isHidden = false
        
        }
    }
    
    
    func createConstraints() {
        searchTextField.autoPinEdge(toSuperviewEdge: .top, withInset: 150)
        searchTextField.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        searchTextField.autoPinEdge(toSuperviewEdge: .trailing, withInset: 50)
        
        searchButton.autoPinEdge(.top, to: .bottom, of: searchTextField, withOffset: 20)
        searchButton.autoAlignAxis(.vertical, toSameAxisOf: searchTextField)
        
        tableView.autoPinEdge(.top, to: .bottom, of: searchButton, withOffset: 10)
        tableView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        tableView.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        tableView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        
        
    }
    
    @objc func onClickSearch(_ sender: UIButton) {
        let searchBy = searchTextField.text
        quizViewModel.searchQuizes(searchBy: searchBy ?? "") { quizes in
            guard let getQuizes = quizes else { return }
            self.quizes = getQuizes
            guard let check = self.quizes?.isEmpty else { return }
            if (check) {
                print("ništa")
            } else {
            self.refresh()
            }
        }
    }

    func sectionArrays() -> [[Quiz]] {
        
        let sportCategory = quizes?.filter{(quiz) -> Bool in return (quiz.category?.contains("SPORTS"))!}
        let scienceCategory = quizes?.filter{(quiz) -> Bool in return (quiz.category?.contains("SCIENCE"))!}
        return [sportCategory!,scienceCategory!]
    }
    
    func headerTitles() -> [String?]{
        return (quizes?.map{$0.category}.removingDuplicates())!
    }
    
    func numberOfCategories() -> Int {
        return quizes?.map{$0.category}.removingDuplicates().count ?? 0
        
    }
}

extension SearchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionArrays()[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfCategories()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizzesCell", for: indexPath) as! QuizzesCell
        let quizzes = sectionArrays()[indexPath.section][indexPath.row]
        cell.setup(withQuizzes: quizzes)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles().count {
            return headerTitles()[section]
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let quizzes = sectionArrays()[indexPath.section][indexPath.row]
        let quizViewController = QuizViewController()
        quizViewController.hidesBottomBarWhenPushed = true
        quizViewController.quizzes = quizzes
        navigationController?.pushViewController(quizViewController, animated: true)
        
    }
    
}

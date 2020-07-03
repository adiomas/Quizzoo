//
//  ViewController.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 09/05/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import UIKit
import PureLayout
import Kingfisher


class ViewController: UIViewController{
    
    var getQuizzesButtton: UIButton!
    
    var funFactLabel: UILabel!
    
    var numberLabel: UILabel!
    
    var quizNameLabel: UILabel!
    
    var errorLabel: UILabel!
    
    var image: UIImageView!
    
    var questionView: QuestionView!
    
    var tableView = UITableView()
    
    var quizViewModel : QuizViewModel!
    
    var quizes : [Quiz]?
    
    private let networkService = QuizService()
    
    var tableFooterView : UIView!
    
    var refreshControl: UIRefreshControl!
    
    convenience init(viewModel: QuizViewModel) {
        self.init()
        self.quizViewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        tabBarController?.tabBar.isHidden = false
        buildViews()
        setTableViewDelegates()
        createConstraints()
        getQuizzes()
        view.backgroundColor = .white
    }
    
    func buildViews() {
        view.addSubview(tableView)
        tableView.isHidden = true
        tableView.rowHeight = 100
        tableView.register(QuizzesCell.self, forCellReuseIdentifier: "QuizzesCell")
        
//        funFactLabel = UILabel()
//        funFactLabel.text = "Fun fact: "
//        funFactLabel.isHidden = true
//        view.addSubview(funFactLabel)
//
//        numberLabel = UILabel()
//        numberLabel.text = "0"
//        numberLabel.isHidden = true
//        view.addSubview(numberLabel)
        
        quizNameLabel = UILabel()
        quizNameLabel.text = "BLABla"
        quizNameLabel.textAlignment = .center
        quizNameLabel.numberOfLines = 0
        quizNameLabel.isHidden = true
        view.addSubview(quizNameLabel)
        
        image = UIImageView()
        image.backgroundColor = .red
        image.isHidden = true
        view.addSubview(image)
        
        questionView = QuestionView()
        questionView.isHidden = true
        view.addSubview(questionView)
        
        errorLabel = UILabel()
        errorLabel.isHidden = true
        view.addSubview(errorLabel)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func createConstraints() {

        
        tableView.autoPinEdge(toSuperviewEdge: .top, withInset: 40)
        tableView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        tableView.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        tableView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        
    }
    
    func getQuizzes() {
        quizViewModel.fetchQuizes { quizes in
            guard let getQuizes = quizes else { return }
           
            self.quizes = getQuizes
            self.refresh()
        }
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            self.tableView.isHidden = false
           
        }
    }
    
    func numberOfCategories() -> Int {
        return quizes?.map{$0.category}.removingDuplicates().count ?? 0
        
    }
    
    func sectionArrays() -> [[Quiz]] {
        
        let sportCategory = quizes?.filter{(quiz) -> Bool in return (quiz.category?.contains("SPORTS"))!}
        let scienceCategory = quizes?.filter{(quiz) -> Bool in return (quiz.category?.contains("SCIENCE"))!}
        return [sportCategory!,scienceCategory!]
    }
    
    func headerTitles() -> [String?]{
        return (quizes?.map{$0.category}.removingDuplicates())!
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
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

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}


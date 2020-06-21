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
    
    var logoutButton: UIButton!
    
    var tableView = UITableView()
    
    var quizes : [QuizModel]?
    
    private let networkService = QuizService()
    
    var getQuiz : [ResponseModel]?
    
    var tableFooterView : UIView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tabBarController?.tabBar.isHidden = false
        buildViews()
        setTableViewDelegates()
        createConstraints()
        getQuizzes()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden  = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func buildViews() {
        view.addSubview(tableView)
        tableView.isHidden = true
        tableView.rowHeight = 100
        tableView.register(QuizzesCell.self, forCellReuseIdentifier: "QuizzesCell")
        
        logoutButton = UIButton()
        logoutButton.setTitle("LOGOUT", for: .normal)
        logoutButton.setTitleColor(.blue, for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 80))
        tableFooterView.backgroundColor = UIColor.white
        tableFooterView.addSubview(logoutButton)
        tableView.tableFooterView = tableFooterView
        
        funFactLabel = UILabel()
        funFactLabel.text = "Fun fact: "
        funFactLabel.isHidden = true
        view.addSubview(funFactLabel)
        
        numberLabel = UILabel()
        numberLabel.text = "0"
        numberLabel.isHidden = true
        view.addSubview(numberLabel)
        
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
    }
    
    func createConstraints() {
        funFactLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 40)
        funFactLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 15)
               
        numberLabel.autoAlignAxis(.horizontal, toSameAxisOf: funFactLabel)
        numberLabel.autoPinEdge(.leading, to: .trailing, of: funFactLabel, withOffset: 5)
        
        tableView.autoPinEdge(.top, to: .bottom, of: funFactLabel, withOffset: 10)
        tableView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        tableView.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        tableView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        
        logoutButton.autoPinEdge(.top, to: .top, of: tableFooterView, withOffset: 20)
        logoutButton.autoAlignAxis(.vertical, toSameAxisOf: tableFooterView)
    }
    
    func getQuizzes() {
        networkService.getQuizzes() {  (quizes) in
            guard let getQuiz = quizes else {
                return
            }
            self.quizes = getQuiz.quizzes
            
            let ffNumber = getQuiz.quizzes
                .map{$0.questions}
                .flatMap{$0.map{$0.question}}
                .filter { (question) -> Bool in
                    return question.contains("NBA")
            }
            .count
            self.refresh(number: ffNumber)
            print(self.headerTitles())
        }
        
    }
    
    
    
    @objc func refresh(number : Int) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.numberLabel.text = String(number)
            self.numberLabel.isHidden = false
            self.funFactLabel.isHidden = false
        }
    }
    
    func numberOfCategories() -> Int {
        return quizes?.map{$0.category}.removingDuplicates().count ?? 0
        
    }
    
    func sectionArrays() -> [[QuizModel]] {
        let sportCategory = quizes?.filter{(quiz) -> Bool in return (quiz.category?.contains("SPORTS"))!}
        let scienceCategory = quizes?.filter{(quiz) -> Bool in return (quiz.category?.contains("SCIENCE"))!}
        return [sportCategory!,scienceCategory!]
    }
    
    func headerTitles() -> [String?]{
        return (quizes?.map{$0.category}.removingDuplicates())!
    }
    
    
    func quizzes(atIndex index: Int) -> QuizModel? {
        guard let quizes = quizes else {
            DispatchQueue.main.sync {
                let alert = UIAlertController(title: "Alert", message: "Something went wrong", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                present(alert,animated: true,completion:nil)
            }
            return nil
        }
        if(index == quizes.count) {
            return nil
            
        }
        return quizes[index]
    }
    
    
    @objc func logout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "accessToken")
        defaults.removeObject(forKey: "Id")
//        self.navigationController?.popToRootViewController(animated: true)
        self.tabBarController?.navigationController?.popToRootViewController(animated: true)
       
       
 
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

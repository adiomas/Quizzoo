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
    
    var categoryButtons: UIStackView!
    
    var categoryButton1: UIButton!
    
    var categoryButton2: UIButton!
    
    var tableView = UITableView()
    
    var quizes : [QuizModel]?

    private let networkService = QuizService()
    
    var getQuiz : [ResponseModel]?
    

    
    var tableFooterView : UIView!
    
    var answerButtons : [UIButton] {
        return [questionView.answer1Button, questionView.answer2Button, questionView.answer3Button, questionView.answer4Button]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        setTableViewDelegates()
        createConstraints()
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
        


        getQuizzesButtton = UIButton()
        getQuizzesButtton.setTitle("GET QUIZZES", for: .normal)
        getQuizzesButtton.setTitleColor(.blue, for: .normal)
        getQuizzesButtton.addTarget(self, action: #selector(getQuizzes), for: .touchUpInside)
        view.addSubview(getQuizzesButtton)
        
        
        
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
        
        
        
        categoryButtons = UIStackView()
        categoryButtons.axis = .horizontal
        categoryButtons.spacing = 5
        categoryButtons.distribution = .fillEqually
        view.addSubview(categoryButtons)
        
        categoryButton1 = UIButton()
        categoryButtonsInit(button: categoryButton1)
        categoryButton1.backgroundColor = UIColor(red: 0.5843, green: 0.8588, blue: 0, alpha: 1.0)
        categoryButton1.tag = 0
        categoryButtons.addArrangedSubview(categoryButton1)
        
        categoryButton2 = UIButton()
        categoryButtonsInit(button: categoryButton2)
        categoryButton2.backgroundColor = UIColor(red: 0.3451, green: 0.6627, blue: 0.9373, alpha: 1.0)
        categoryButton2.tag = 1
        categoryButtons.addArrangedSubview(categoryButton2)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func categoryButtonsInit(button : UIButton) {
        button.autoSetDimensions(to: .init(width: 200, height: 70))
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.minimumScaleFactor = 0.1
        button.clipsToBounds = true
        button.isHidden = true
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
//        button.addTarget(self, action: #selector(chooseCategory(_:)), for: .touchUpInside)
    }
    
    
    func createConstraints() {
        tableView.autoPinEdgesToSuperviewEdges()
        
        logoutButton.autoPinEdge(.top, to: .top, of: tableFooterView, withOffset: 20)
        logoutButton.autoAlignAxis(.vertical, toSameAxisOf: tableFooterView)
        
        getQuizzesButtton.autoPinEdge(toSuperviewEdge: .top, withInset: 50)
        getQuizzesButtton.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        getQuizzesButtton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 50)
        
        funFactLabel.autoPinEdge(.top, to: .bottom, of: getQuizzesButtton, withOffset: 10)
        funFactLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 15)
        
        numberLabel.autoAlignAxis(.horizontal, toSameAxisOf: funFactLabel)
        numberLabel.autoPinEdge(.leading, to: .trailing, of: funFactLabel, withOffset: 5)
        
        categoryButtons.autoPinEdge(.top, to: .bottom, of: funFactLabel, withOffset: 10)
        categoryButtons.autoAlignAxis(.vertical, toSameAxisOf: getQuizzesButtton)
       
        
        quizNameLabel.autoPinEdge(.top, to: .bottom, of: categoryButtons, withOffset: 10)
        quizNameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        quizNameLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        
        image.autoPinEdge(.top, to: .bottom, of: quizNameLabel, withOffset: 10)
        image.autoAlignAxis(.vertical, toSameAxisOf: quizNameLabel)
        image.autoSetDimensions(to: CGSize(width: 100, height: 100))
        
        questionView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        questionView.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        questionView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        questionView.autoPinEdge(.top, to: .bottom, of: image, withOffset: 10)
        
        errorLabel.autoPinEdge(.top, to: .bottom, of: getQuizzesButtton, withOffset: 20)
        errorLabel.autoAlignAxis(.vertical, toSameAxisOf: getQuizzesButtton)
        
    }
    
    @objc func getQuizzes() {
        networkService.getQuizzes() {  (quizes) in
            guard let getQuiz = quizes else {
                return
            }
            self.quizes = getQuiz.quizzes
            
            self.refresh()
            print(self.headerTitles())
        }
        
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.getQuizzesButtton.isHidden = true
          
            
            
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
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveQuizzes(quizModel : [QuizModel]?) {
        guard let quizModel = quizModel else {
            DispatchQueue.main.sync {
                let alert = UIAlertController(title: "Alert", message: "Something went wrong", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                present(alert,animated: true,completion:nil)
            }
            return
        }
    
//        self.quizzes = quizModel
       
        
        let ffNumber = quizModel
            .map{$0.questions}
            .flatMap{$0.map{$0.question}}
            .filter { (question) -> Bool in
                return question.contains("NBA")
        }
        .count
            
        DispatchQueue.main.sync {
            categoryButton1.setTitle(quizModel[0].title, for: .normal)
            categoryButton2.setTitle(quizModel[1].title, for: .normal)
            
            tableView.isHidden = false
            getQuizzesButtton.isHidden = true
            
            
//            categoryButton1.isHidden = false
//            categoryButton2.isHidden = false
//            funFactLabel.isHidden = false
//            numberLabel.isHidden = false
//            numberLabel.text = String(ffNumber)
//            logoutButton.isHidden = false
        }
    }
//
//    @objc func chooseCategory(_ sender: UIButton) {
//        if sender.tag == 0 {
//            categoryButtonsShow(sender: sender.tag)
//            answerButtons.forEach{button in button.backgroundColor = UIColor(red: 0.5843, green: 0.8588, blue: 0, alpha: 1.0)}
//
//        }else {
//            categoryButtonsShow(sender: sender.tag)
//            answerButtons.forEach{button in button.backgroundColor = UIColor(red: 0.3451, green: 0.6627, blue: 0.9373, alpha: 1.0)}
//        }
//    }
//
//    func categoryButtonsShow(sender : Int) {
//        quizNameLabel.isHidden = false
//        image.isHidden = false
//        questionView.isHidden = false
//        quizNameLabel.text = quizzes[sender].title
//
//        guard let imageURL = URL(string: (quizzes?[sender].image)!) else {return}
//        image.kf.setImage(with:imageURL)
//        questionView.setQuestion(questionModel: quizzes![sender].questions[0])
//    }
    

    
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

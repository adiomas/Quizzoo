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


class ViewController: UIViewController {
    
    var getQuizzesButtton: UIButton!
    var funFactLabel: UILabel!
    
    var numberLabel: UILabel!
    
    var quizNameLabel : UILabel!    
    
    var errorLabel : UILabel!
    
    var image : UIImageView!
    
    var questionView : QuestionView!
    
    var logoutButton : UIButton!
    
    private let networkService = QuizService()
    
    private var quizzes: [QuizModel]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        createConstraints()
     
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden  = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    
    func buildViews() {
    
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
        
        logoutButton = UIButton()
        
        logoutButton.isHidden = true
        logoutButton.setTitle("LOGOUT", for: .normal)
        logoutButton.setTitleColor(.blue, for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        view.addSubview(logoutButton)
    }
    
    
    func createConstraints() {
        
        logoutButton.autoPinEdge(toSuperviewEdge: .top, withInset: 30)
        logoutButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        
        getQuizzesButtton.autoPinEdge(toSuperviewEdge: .top, withInset: 50)
        getQuizzesButtton.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        getQuizzesButtton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 50)
        
        funFactLabel.autoPinEdge(.top, to: .bottom, of: getQuizzesButtton, withOffset: 10)
        funFactLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 15)
        
        numberLabel.autoAlignAxis(.horizontal, toSameAxisOf: funFactLabel)
        numberLabel.autoPinEdge(.leading, to: .trailing, of: funFactLabel, withOffset: 5)
        
        quizNameLabel.autoPinEdge(.top, to: .bottom, of: funFactLabel, withOffset: 10)
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
        networkService.getQuizzes(completionHandler: saveQuizzes(responseModel:))
        
        
    }
    
    @objc func logout() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
        UserDefaults.standard.removeObject(forKey: "accessToken")
    }
    
    func saveQuizzes(responseModel : ResponseModel?) {
        
        guard let responseModel = responseModel else {
            DispatchQueue.main.sync {
               let alert = UIAlertController(title: "Alert", message: "Something went wrong", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                present(alert,animated: true,completion:nil)
            }
            
            return
        }
        
        
        
        quizzes = responseModel.quizzes
        
        let ffNumber = responseModel.quizzes
            .map({$0.questions})
            .flatMap({$0.map({$0.question})})
            .filter { (question) -> Bool in
                return question.contains("NBA")
        }
        .count
        
        DispatchQueue.main.sync {
            
            funFactLabel.isHidden = false
            numberLabel.isHidden = false
            quizNameLabel.isHidden = false
            image.isHidden = false
            questionView.isHidden = false
            logoutButton.isHidden = false
            numberLabel.text = String(ffNumber)
            let quiz = responseModel.quizzes[0]
            quizNameLabel.text = quiz.title
            
            guard let imageURL = URL(string: quiz.image) else {return}
            image.kf.setImage(with:imageURL)
            
            questionView.setQuestion(questionModel: quiz.questions[0])
        }
        
        
        
    }
}


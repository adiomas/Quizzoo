//
//  QuizViewController.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 02/06/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import UIKit
import Kingfisher
import PureLayout

class QuizViewController: UIViewController {
    
    var titleLabel : UILabel!
    var quizImage : UIImageView!
    var startQuizButton : UIButton!
    var questionView: QuestionView!
    
    var answerButtons : [UIButton] {
        return [questionView.answer1Button, questionView.answer2Button, questionView.answer3Button, questionView.answer4Button]
    }
    
    var quizzes : QuizModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        createConstraints()
        view.backgroundColor = .white
        
    }
    
    var quizTitle: String {
        return quizzes?.title ?? ""
    }
    
    var imageUrl : URL? {
        if let urlString = quizzes?.image {
            return URL(string: urlString)
        }
        return nil
    }
    
    
    func buildViews() {
        titleLabel = UILabel()
        titleLabel.text = quizTitle
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        quizImage = UIImageView()
        quizImage.kf.setImage(with: imageUrl)
        quizImage.layer.cornerRadius = 10
        quizImage.clipsToBounds = true
        view.addSubview(quizImage)
        
        startQuizButton = UIButton()
        startQuizButton.autoSetDimensions(to: .init(width: 150, height: 40))
        startQuizButton.setTitle("START QUIZ", for: .normal)
        startQuizButton.layer.cornerRadius = 5
        startQuizButton.layer.borderWidth = 1
        startQuizButton.backgroundColor = UIColor(red: 0.3451, green: 0.6627, blue: 0.9373, alpha: 1.0)
        startQuizButton.addTarget(self, action: #selector(onClickStartQuiz(_:)), for: .touchUpInside)
        view.addSubview(startQuizButton)
        
        questionView = QuestionView()
        questionView.isHidden = true
        view.addSubview(questionView)
        
        
    }
    
    func createConstraints() {
        titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 100)
        titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
        quizImage.translatesAutoresizingMaskIntoConstraints = false
        quizImage.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 20)
        quizImage.autoAlignAxis(.vertical, toSameAxisOf: titleLabel)
        quizImage.autoSetDimensions(to: CGSize(width: 200, height: 113))
        
        startQuizButton.autoPinEdge(.top, to: .bottom, of: quizImage, withOffset: 20)
        startQuizButton.autoAlignAxis(.vertical, toSameAxisOf: quizImage)
        
        questionView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        questionView.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        questionView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        questionView.autoPinEdge(.top, to: .bottom, of: startQuizButton, withOffset: 20)
        
    }
    
    @objc func onClickStartQuiz(_ sender: UIButton) {
        questionView.isHidden = false
        questionView.setQuestion(questionModel: (quizzes?.questions[0])!)
        
    }
    
    
    
}

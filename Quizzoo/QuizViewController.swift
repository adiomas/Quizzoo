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

class QuizViewController: UIViewController  {
    
    var titleLabel : UILabel!
    var quizImage : UIImageView!
    var startQuizButton : UIButton!
    var questionViews: [QuestionView]! = []
    
    
    var scrollView : UIScrollView!
    var questionsStackView : UIStackView!
    
    var questionsAnswered : Int = 0
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
        
        
        scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isHidden = false
        scrollView.isScrollEnabled = false
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        //
        questionsStackView = UIStackView()
        questionsStackView.axis = .horizontal
        questionsStackView.spacing = 0;
        
        questionsStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(questionsStackView)
        
        
        
        for i in 0..<quizzes!.questions.count{
            questionViews.append(QuestionView())
            questionViews[i].setQuestion(questionModel: (quizzes?.questions[i])!)
            questionViews[i].delegate = self
            questionsStackView.addArrangedSubview(questionViews[i])
            
        }
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
        
        
        
        scrollView.autoPinEdge(.top, to: .bottom, of: startQuizButton, withOffset: 20)
        scrollView.autoAlignAxis(.vertical, toSameAxisOf: startQuizButton)
        scrollView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        scrollView.autoMatch(.width, to: .width, of: view)
        
        for i in 0..<quizzes!.questions.count{
            questionViews[i].autoMatch(.width, to: .width, of: view)
            
        }
        
        questionsStackView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        questionsStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        questionsStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        questionsStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
    }
    
    @objc func onClickStartQuiz(_ sender: UIButton) {
        scrollView.isHidden = false
        let questionView = QuestionView()
        questionView.delegate = self
    }
    
    func scrollToAnotherQuestion() {
        let deltax = questionViews[0].frame.size.width * CGFloat(questionsAnswered)
        scrollView.setContentOffset(CGPoint(x: deltax, y: 0), animated: true)   
    }
}

extension QuizViewController: QuestionViewDelegate {
    func clickedAnswer() {
        print("aa")
        questionViews[questionsAnswered].isUserInteractionEnabled = false
        questionsAnswered += 1
       
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("Timer fired!")
            self.scrollToAnotherQuestion()
        }
        
    }
    
    
}









//
//  QuestionView.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 09/05/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import UIKit

class QuestionView: UIView {
    
    
    var questionLabel : UILabel!
    
    var answer1Button : UIButton!
    var answer2Button : UIButton!
    var answer3Button : UIButton!
    var answer4Button : UIButton!
    
    var answersStackView: UIStackView!
    
    var questionModel: QuestionModel?
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        buildViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildViews()
        makeConstraints()
    }
    
    func buildViews() {
        questionLabel = UILabel()
        questionLabel.text = "Question"
        addSubview(questionLabel)
        
        answersStackView = UIStackView()
        answersStackView.axis = .vertical
        answersStackView.spacing = 10
        answersStackView.distribution = .fillEqually
        addSubview(answersStackView)
        
        answer1Button = UIButton()
        answer1Button.setTitle("A1", for: .normal)
        answer1Button.setTitleColor(.black, for: .normal)
        answer1Button.layer.cornerRadius = 5
        answer1Button.layer.borderWidth = 1
        answer1Button.tag = 0
        answer1Button.addTarget(self, action: #selector(checkAnswer(_:)), for: .touchUpInside)
        answersStackView.addArrangedSubview(answer1Button)
        
        answer2Button = UIButton()
        answer2Button.setTitle("A1", for: .normal)
        answer2Button.setTitleColor(.black, for: .normal)
        answer2Button.layer.cornerRadius = 5
        answer2Button.layer.borderWidth = 1
        answer2Button.tag = 1
        answer2Button.addTarget(self, action: #selector(checkAnswer(_:)), for: .touchUpInside)
        answersStackView.addArrangedSubview(answer2Button)
        
        answer3Button = UIButton()
        answer3Button.setTitle("A1", for: .normal)
        answer3Button.setTitleColor(.black, for: .normal)
        answer3Button.layer.cornerRadius = 5
        answer3Button.layer.borderWidth = 1
        answer3Button.tag = 2
        answer3Button.addTarget(self, action: #selector(checkAnswer(_:)), for: .touchUpInside)
        answersStackView.addArrangedSubview(answer3Button)
        
        answer4Button = UIButton()
        answer4Button.setTitle("A1", for: .normal)
        answer4Button.setTitleColor(.black, for: .normal)
        answer4Button.layer.cornerRadius = 5
        answer4Button.layer.borderWidth = 1
        answer4Button.tag = 3
        answer4Button.addTarget(self, action: #selector(checkAnswer(_:)), for: .touchUpInside)
        answersStackView.addArrangedSubview(answer4Button)
    }
    
    @objc
    func checkAnswer(_ sender: UIButton){
//        self.questionModel = QuestionModel
//        for i in 0..<questionModel?.answers.count{
//
//        }
        
        if questionModel?.correct_answer == sender.tag {
            sender.backgroundColor = .green
            
        }
        else{
            sender.backgroundColor = .red
        }
    }
    
    func makeConstraints(){
        questionLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        questionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
         questionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        
    
        answersStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        answersStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        answersStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        answersStackView.autoPinEdge(.top, to: .bottom
            , of: questionLabel, withOffset: 10)
        
       
    }
    
    func setQuestion(questionModel: QuestionModel) {
        self.questionModel = questionModel
        self.questionLabel.text = questionModel.question
        
        
        for i in 0..<questionModel.answers.count {
            switch i {
            case 0:
                answer1Button.setTitle(questionModel.answers[i], for: .normal)
            case 1:
                answer2Button.setTitle(questionModel.answers[i], for: .normal)
            case 2:
                answer3Button.setTitle(questionModel.answers[i], for: .normal)
            case 3:
                answer4Button.setTitle(questionModel.answers[i], for: .normal)
            default:
                print("OVO NEBI trebalo biti")
            }
        }
    }
}

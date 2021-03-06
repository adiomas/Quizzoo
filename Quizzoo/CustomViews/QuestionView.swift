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
        answer1Button.tag = 0
        buttonsInit(button: answer1Button)
        answersStackView.addArrangedSubview(answer1Button)
        
        answer2Button = UIButton()
        answer2Button.tag = 1
        buttonsInit(button: answer2Button)
        answersStackView.addArrangedSubview(answer2Button)
        
        answer3Button = UIButton()
        answer3Button.tag = 2
        buttonsInit(button: answer3Button)
        answersStackView.addArrangedSubview(answer3Button)
        
        answer4Button = UIButton()
        answer4Button.tag = 3
        buttonsInit(button: answer4Button)
        answersStackView.addArrangedSubview(answer4Button)
    }
    
    func buttonsInit(button: UIButton) {
        button.setTitle("A1", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(checkAnswer(_:)), for: .touchUpInside)
    }
    
    @objc
    func checkAnswer(_ sender: UIButton){
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
        answersStackView.autoPinEdge(.top, to: .bottom, of: questionLabel, withOffset: 10)
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
                print("NEBI SE TREBALO DESITI!")
            }
        }
    }
}

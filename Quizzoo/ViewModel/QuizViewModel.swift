//
//  QuizViewModel.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 25/06/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//


import Foundation
import UIKit
import CoreData

// Struktura koja sluzi da se ReviewTableViewCell napuni njenim podacima
struct QuizCellModel  {
    
   let id: Int16
    let title, quizDescription, category: String?
    let level: Int16
    let image: String?
    var questions: [Question]
    
    init(quiz: Quiz) {
        self.id = quiz.id
        self.title = quiz.title ?? ""
        self.quizDescription = quiz.quizDescription ?? ""
        self.category = quiz.category ?? ""
        self.level = quiz.level
        self.image = quiz.image ?? ""
        self.questions = quiz.questions ?? []
    }
}

class QuizViewModel {
    
    var quizes: [Quiz]?
    var quizes1: [QuizModel]?
    
func fetchQuizes(completion: @escaping (([Quiz]?) -> Void)) -> Void {

    QuizService().getQuizzes() { [weak self] (quizes)  in
            print(quizes)
            self?.quizes = DataController.shared.fetchQuizes()
        
            completion(self?.quizes)
        }
}
    
    func quiz(atIndex index: Int) -> QuizCellModel? {
          guard let quizes = quizes else {
              return nil
          }

        let quizCellModel = QuizCellModel(quiz: quizes[index])
          return quizCellModel
      }

      func numberOfReviews() -> Int {
          return quizes?.count ?? 0
      }
}

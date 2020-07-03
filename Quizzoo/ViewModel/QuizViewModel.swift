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
        self.questions = Array(quiz.questions ?? [])
    }
}

class QuizViewModel {
    
    var quizes: [Quiz]?
    
    
    func fetchQuizes(completionHandler: @escaping ([Quiz]?) -> Void)   {
        
        QuizService().getQuizzes { [weak self] (quizes)  in
            self?.quizes = quizes
            completionHandler(self?.quizes)
        }
    }
    
//    func getNumber() -> Int {
//        var array = [Question]()
//        guard let quizes = quizes else { return 0 }
//        for quiz in quizes {
//            array.append(contentsOf: Array(quiz.questions!))
//        }
//
//        let a = array.map{$0.question}
//            .filter{ (question) -> Bool in return(question?.contains("NBA"))!}
//            .count
//        return a
//    }
    
    func searchQuizes(searchBy: String, completion: @escaping ([Quiz]?) -> Void) {
        self.quizes = DataController.shared.searchQuizes(searchBy: searchBy)
        completion(self.quizes)
    }
}

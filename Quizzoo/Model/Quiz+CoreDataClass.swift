//
//  Quiz+CoreDataClass.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 24/06/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Quiz)
public class Quiz: NSManagedObject {
    
    class func getEntityName() -> String {
        return "Quiz"
    }
    
    class func createFrom(quizModel: QuizModel) -> Quiz? {
        if let quiz = Quiz.firstOrCreate(withId: Int(quizModel.id)) {
            quiz.id = Int16(quizModel.id)
            quiz.title = quizModel.title
            quiz.quizDescription = quizModel.description
            quiz.category = quizModel.category
            quiz.level = Int16(quizModel.level)
            quiz.image = quizModel.image
            
            var questionsSet = Set<Question>()
            
            for question in quizModel.questions {
                guard let question = Question.createFrom(questionModel: question) else { continue }
                questionsSet.insert(question)
            }
            
            quiz.questions = questionsSet
            
            DataController.shared.saveContext()
            return quiz
        }
        else {
            return nil
        }
    }
    
    class func firstOrCreate(withId id: Int) -> Quiz? {
        let context = DataController.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
        request.returnsObjectsAsFaults = false
        
        do {
            let quizes = try context.fetch(request)
            if let quiz = quizes.first {
                return quiz
            } else {
                let newQuiz = Quiz(context: context)
                return newQuiz
            }
        } catch {
            return nil
        }
    }
}

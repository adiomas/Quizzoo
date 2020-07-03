//
//  Question+CoreDataClass.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 24/06/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import Foundation
import CoreData

@objc(Question)
public class Question: NSManagedObject {
    
    
    class func getEntityName() -> String {
        return "Question"
    }
    
    class func firstOrCreate(withId id: Int) -> Question? {
        let context = DataController.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
        request.returnsObjectsAsFaults = false
        
        do {
            let questions = try context.fetch(request)
            if let question = questions.first {
                return question
            } else {
                let newQuestion = Question(context: context)
                return newQuestion
            }
        } catch {
            return nil
        }
    }
    
    class func createFrom(questionModel: QuestionModel) -> Question? {
        
        if let question = Question.firstOrCreate(withId: questionModel.id) {
            question.id = Int16(questionModel.id)
            question.question = questionModel.question
            
            question.answers = questionModel.answers.description
            question.correctAnswer = Int16(questionModel.correct_answer)
            
            DataController.shared.saveContext()
            return question
        }
        else {
            return nil
        }
        
    }
}

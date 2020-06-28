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
    
    class func create(quiz: QuizModel) -> Quiz? {
        
        
        if let quiz1 = Quiz.firstOrCreate(withTitle: quiz.title!) {
            quiz1.id = Int16(quiz.id)
            quiz1.category = quiz.category
            quiz1.title = quiz.title
            quiz1.image = quiz.image
            quiz1.level = Int16(quiz.level)
            quiz1.quizDescription = quiz.description
            
            do {
                let context = DataController.shared.persistentContainer.viewContext
                try context.save()
                return quiz1
            } catch {
                print("Failed saving")
            }
        }
        return nil
    }
    
    class func firstOrCreate(withTitle title: String) -> Quiz? {
        let context = DataController.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        request.predicate = NSPredicate(format: "title = %@", title)
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

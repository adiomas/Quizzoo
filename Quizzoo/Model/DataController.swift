//
//  DataController.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 25/06/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import Foundation
import CoreData


class DataController {
    
    static let shared = DataController()
    
    private init() {}
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchQuizes() -> [Quiz]? {
        // Genericki razred NSFetchRequest predstavlja upit na bazu podataka kojim dohvacamo objekte nekog razreda
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        
        let context = DataController.shared.persistentContainer.viewContext
        let quizes = try? context.fetch(request)
        
        return quizes
    }
    
    func searchQuizes(searchBy: String) -> [Quiz]? {
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[c] %@ OR quizDescription CONTAINS[c] %@", searchBy, searchBy)
        request.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]
        let context = DataController.shared.persistentContainer.viewContext
        
        let quizes = try? context.fetch(request)
        return quizes
    }
    
    func getQuiz(id: Int) -> Quiz? {
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        
        request.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
        let context = DataController.shared.persistentContainer.viewContext
        
        let quizes = try? context.fetch(request)
        if let quiz = quizes?.first {
            return quiz
        }
        
        return nil
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }    }
}

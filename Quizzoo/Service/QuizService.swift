
//
//  Service.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 10/05/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import Foundation

class QuizService {
    
    private let apiString = "https://iosquiz.herokuapp.com/api/quizzes"
    private let session = URLSession.shared
    private let jsonDecoder = JSONDecoder()
    
    func getQuizzes(completionHandler: @escaping (ResponseModel?) -> Void){
        guard let url = URL(string: apiString) else { return }
        
        let task = session.dataTask(with: url) { (data, _ , error) in
            if error != nil {
                print("POGREŠKA")
                completionHandler(nil)
                return
            }
            guard let jsonData = data else {
                completionHandler(nil)
                return
            }
            
            do {
                let response = try self.jsonDecoder.decode(ResponseModel.self, from: jsonData)
                completionHandler(response)
            } catch {
                print("POGREKA")
                completionHandler(nil)
                return
            }
            
        }
        task.resume()
    }
}

struct QuizModel: Codable {
    let id: Int
    let title, description, category: String
    let level: Int
    let image: String
    let questions: [QuestionModel]
}

// MARK: - Question
struct QuestionModel: Codable {
    let id: Int
    let question: String
    let answers: [String]
    let correct_answer: Int
}

struct ResponseModel: Codable {
    let quizzes: [QuizModel]
}

//
//  ResultService.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 09/06/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import Foundation

class ResultService {
    
    private let apiString = "https://iosquiz.herokuapp.com/api/result"
    private let session = URLSession.shared
    
    func sendResults(_ quizId: Int, _ userId: String, _ time: Double, _ correctAnswers: Int) {
        guard let url = URL(string: apiString) else { return }
        let request = NSMutableURLRequest(url: url)
       
        
        let token = UserDefaults.standard.value(forKey: "accessToken")
        let checkTokenString = "\(String(describing: token))"

        guard let checkToken = checkTokenString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = checkToken.base64EncodedString()
          request.httpMethod = "POST"
      
        
       request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
     
        let data = ResultModel(quiz_id: quizId, user_id: userId, time: time, no_of_correct: correctAnswers)
              
//        let jsonData = try JSONEncoder().encode(data)
//        request.httpBody = jsonData
        
        let task = session.dataTask(with: request as URLRequest){
            (data, _ , error) in
            
//            if error != nil {
//                print("POGREŠKA")
//                return
//            }
            if let error = error {
                       print("Error took place \(error)")
                       return
                   }
            
            guard let jsonData = data else {
                return
                
            }
            
            do{
                 let todoItemModel = try JSONDecoder().decode(ResultModel.self, from: jsonData)
                 print("Response data:\n \(todoItemModel)")
             }catch let jsonErr{
                 print(jsonErr)
            }
//            do {
//                let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
//                guard let server_response = json as? NSDictionary else { return }
//                print("response:",server_response)
//                } catch {
//                print("Pogreška")
//
//                return
//            }
        }
        task.resume()
   
    }
}

struct ResultModel: Codable {
    var quiz_id: Int
    var user_id: String
    var time: Double
    var no_of_correct: Int
}

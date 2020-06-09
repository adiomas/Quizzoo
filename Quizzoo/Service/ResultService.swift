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
    
    func sendResults(_ quizId: Int, _ userId: Int, _ time: Double, _ correctAnswers: Int, completionHandler: @escaping (Int?) -> Void) {
        guard let url = URL(string: apiString) else { return }
        let request = NSMutableURLRequest(url: url)
        
        let jsonDict = ["quiz_id": quizId, "user_id": userId, "time": time, "no_of_correct": correctAnswers] as [String : Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonDict, options: [])
        let token = UserDefaults.standard.value(forKey: "accessToken")!
        print(token)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if let error = error {
                print("POGREŠKA:", error)
                return
            }
            
        
            do {
                guard let data = data else { return }
                guard (try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]) != nil else { return }
                let httpResponse = response as! HTTPURLResponse
                print(response!)
                if httpResponse.statusCode == 200 {
                    completionHandler(1)
                } else {
                    completionHandler(0)
                }
            } catch {
                print("error:", error)
                
            }
        }
        
        task.resume()
    }
}

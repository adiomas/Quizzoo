//
//  LeaderBoardService.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 20/06/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import Foundation

class LeaderBoardService {
    private let session = URLSession.shared
    private let jsonDecoder = JSONDecoder()
    
    func getResults(_ quizId: String, completionHandler: @escaping ([Results]?) -> Void) -> Void {
        let apiString = "https://iosquiz.herokuapp.com/api/score?quiz_id=\(quizId)"
        
        guard let url = URL(string: apiString) else { return }
        let request = NSMutableURLRequest(url: url)
        
        guard let token = UserDefaults.standard.value(forKey: "accessToken") else { return }
        print("\(token)")
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if let error = error {
                print("POGREŠKA:", error)
                completionHandler(nil)
                return
            }
            
            guard let data = data else { completionHandler(nil); return }
            
            do {
                let response = try JSONDecoder().decode([Results].self, from: data)
                completionHandler(response)
            } catch{
                completionHandler(nil)
                return
            }
        }
        task.resume()
    }
}


struct Results: Codable {
    let username: String
    let score: String?
}

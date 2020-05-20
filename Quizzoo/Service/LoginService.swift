//
//  LoginService.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 10/05/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import Foundation

class LoginService {
    
    private let apiString = "https://iosquiz.herokuapp.com/api/session"
    private let session = URLSession.shared
    
    func doLogin(_ username: String, _ password: String, completionHandler: @escaping (String?) -> Void) {
        guard let url = URL(string: apiString) else { return }
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        let paramToSend = "username=" + username + "&password=" + password
        request.httpBody = paramToSend.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest){
            (data, _ , error) in
            
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
                let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
                guard let server_response = json as? NSDictionary else { return }
                completionHandler(server_response["token"] as? String)
            } catch {
                print("Pogreška")
                completionHandler(nil)
                return
            }
        }
        task.resume()
    }
}


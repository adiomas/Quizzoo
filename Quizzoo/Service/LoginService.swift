//
//  LoginService.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 10/05/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import Foundation

class LoginService {

    func doLogin(_ username:String, _ password:String,completionHandler: @escaping (String?)->Void)
    {
        let url = URL(string: "https://iosquiz.herokuapp.com/api/session")
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        
        let paramToSend = "username=" + username + "&password=" + password
        
        
        request.httpBody = paramToSend.data(using: String.Encoding.utf8)
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            
            guard let _:Data = data else {return}
            
            let json:Any?
            
            do
            {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
                guard let server_response = json as? NSDictionary else {return}
                let session_data = server_response["token"] as? String
                completionHandler(session_data)
            }
            catch {
                print("Pogreška")
                completionHandler(nil)
                return}
            
        })
        
        task.resume()
    }
}

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
    
  
    
}

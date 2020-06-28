//
//  Question+CoreDataProperties.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 24/06/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var correctAnswer: Int16
    @NSManaged public var answers: [String]?
    @NSManaged public var question: String?
    @NSManaged public var id: Int16
    @NSManaged public var quiz: Quiz?

}

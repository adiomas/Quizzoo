//
//  Quiz+CoreDataProperties.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 24/06/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import Foundation
import CoreData


extension Quiz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quiz> {
        return NSFetchRequest<Quiz>(entityName: "Quiz")
    }

    @NSManaged public var image: String?
    @NSManaged public var level: Int16
    @NSManaged public var category: String?
    @NSManaged public var quizDescription: String?
    @NSManaged public var title: String?
    @NSManaged public var id: Int16
    @NSManaged public var questions: [Question]?

}

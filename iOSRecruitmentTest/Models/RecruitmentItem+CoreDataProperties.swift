//
//  RecruitmentItem+CoreDataProperties.swift
//  iOSRecruitmentTest
//
//  Created by Kordian Ledzion on 22/03/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//
//

import Foundation
import CoreData


extension RecruitmentItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecruitmentItem> {
        return NSFetchRequest<RecruitmentItem>(entityName: "RecruitmentItem")
    }

    @NSManaged public var desc: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var timestamp: Int64
    @NSManaged public var url: String?

}

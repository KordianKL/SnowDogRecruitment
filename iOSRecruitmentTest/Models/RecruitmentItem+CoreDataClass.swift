//
//  RecruitmentItem+CoreDataClass.swift
//  iOSRecruitmentTest
//
//  Created by Kordian Ledzion on 21/03/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//
//

import Foundation
import CoreData


public class RecruitmentItem: NSManagedObject {

    func copy(_ data: DataModel) {
        self.id = data.id
        self.name = data.name
        self.desc = data.description
        self.timestamp = data.timestamp
        self.url = data.url
        self.icon = data.icon
    }
}

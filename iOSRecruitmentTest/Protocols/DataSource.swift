//
//  DataSource.swift
//  iOSRecruitmentTest
//
//  Created by Kordian Ledzion on 22/03/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import Foundation

protocol DataSource {
    
    func getAllItems() -> [RecruitmentItem]
    func add(_ items: [DataModel])
    func deleteAll()
}

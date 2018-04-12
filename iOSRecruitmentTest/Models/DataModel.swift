//
//  DataModel.swift
//  iOSRecruitmentTest
//
//  Created by Kordian Ledzion on 22/03/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import Foundation

struct DataModel: Decodable {
    
    let id: Int16
    let name: String
    let description: String
    let timestamp: Int64
    let url: String
    let icon: String
}

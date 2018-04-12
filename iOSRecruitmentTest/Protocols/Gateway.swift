//
//  DataSource.swift
//  iOSRecruitmentTest
//
//  Created by Kordian Ledzion on 22/03/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import Foundation

protocol Gateway {
    
    func fetchAllItems(_ completion: @escaping (Result<[DataModel], ApiError>) -> Void)
}

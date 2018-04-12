//
//  Decoder.swift
//  iOSRecruitmentTest
//
//  Created by Kordian Ledzion on 22/03/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import Foundation

class Decoder {
    
    static let mainDecoder = Decoder()
    let jsonDecoder = JSONDecoder()
    
    func decode<T>(data jsonData: Data, to type: T.Type) -> T? where T: Decodable {
        return try? jsonDecoder.decode(T.self, from: jsonData)
    }
}

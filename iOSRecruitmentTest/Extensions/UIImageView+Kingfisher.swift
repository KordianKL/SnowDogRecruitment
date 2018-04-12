//
//  UIImageView+Kingfisher.swift
//  iOSRecruitmentTest
//
//  Created by Kordian Ledzion on 23/03/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setUp(with url: String) {
        let url = URL(string: url)
        kf.setImage(with: url)
    }
}

//
//  CurrentData.swift
//  API-project
//
//  Created by Mac on 23.06.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import Foundation
import UIKit

struct CurrentData {
    let tri: String
    let flag: String
    let full: String
}

extension CurrentData: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let tri = JSON["tri"] as? String,
        let flag = JSON["flag"] as? String,
            let full = JSON["full"] as? String else {
                return nil
        }
        self.tri = tri
        self.flag = flag
        self.full = full
    }
}

//
//  Tools.swift
//  XTNotebook
//
//  Created by xc on 2022/11/28.
//

import UIKit

class Tools: NSObject {

}

extension Date {
    
    func get_timestemp() -> TimeInterval {
        
        let timeinterval :TimeInterval = self.timeIntervalSince1970
        return timeinterval
    }
}


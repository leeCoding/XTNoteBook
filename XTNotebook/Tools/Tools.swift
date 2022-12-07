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
    
    func get_date() -> String {
        
        let date = Date.now
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let string_date = formatter.string(from: date);
        return string_date;
        
    }
}


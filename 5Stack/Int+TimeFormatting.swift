//
//  Int+TimeFormatting.swift
//  5Stack
//
//  Created by Joseph McCraw on 2/19/20.
//  Copyright © 2020 Joseph McCraw. All rights reserved.
//

import Foundation

extension Int {
    func timeString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .positional
        
        let formattedString = formatter.string(from: TimeInterval(self)) ?? "0"
        if formattedString == "0" {
            return "GMT"
        }
        if formattedString.hasPrefix("-") {
            return "GMT \(formattedString)"
        } else {
            return "GMT +\(formattedString)"
        }
    }
    
}

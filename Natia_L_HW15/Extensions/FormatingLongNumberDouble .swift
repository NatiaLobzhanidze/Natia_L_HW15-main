//
//  FormatingLongNumberDouble .swift
//  Natia_L_HW15
//
//  Created by Natia's Mac on 12.07.22.
//

import Foundation

let oneFormat = ".1"
extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

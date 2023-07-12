//
//  Decimal+Utils.swift
//  bankey
//
//  Created by huseyin on 6.07.2023.
//

import UIKit

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}

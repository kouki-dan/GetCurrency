//
//  ExchangedCurrency.swift
//  GetCurrency
//
//  Created by Kouki Saito on 8/21/19.
//  Copyright © 2019 Kouki Saito. All rights reserved.
//

import Foundation

struct ExchangedCurrency: Comparable {
    let source: String
    let destination: String
    let sourceAmount: Double
    let destinationUnitPrice: Double
    var destinationAmount: Double {
        return sourceAmount * destinationUnitPrice
    }

    static func < (lhs: ExchangedCurrency, rhs: ExchangedCurrency) -> Bool {
        return lhs.source + lhs.destination < rhs.source + rhs.destination
    }
}

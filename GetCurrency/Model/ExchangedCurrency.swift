//
//  ExchangedCurrency.swift
//  GetCurrency
//
//  Created by Kouki Saito on 8/21/19.
//  Copyright © 2019 Kouki Saito. All rights reserved.
//

import Foundation

struct ExchangedCurrency {
    let source: String
    let destination: String
    let sourceAmount: Double
    let destinationUnitPrice: Double
    var destinationAmount: Double {
        return sourceAmount * destinationUnitPrice
    }
}

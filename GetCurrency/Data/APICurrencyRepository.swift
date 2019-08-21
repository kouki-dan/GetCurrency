//
//  APICurrencyRepository.swift
//  GetCurrency
//
//  Created by Kouki Saito on 8/21/19.
//  Copyright © 2019 Kouki Saito. All rights reserved.
//

import Foundation
import RxSwift

class CachedAPICurrencyRepository: CurrencyRepository {
    func getCurrencyList() -> Observable<[String]> {
        // TODO: fetch from api or get from cache
        return Observable.just([
            "USD",
            "JPY"
        ])
    }

    func getExchangedCurrencies(sourceCurrency: String, sourceAmount amount: Double) -> Observable<[ExchangedCurrency]> {
        // TODO: fetch from api or get from cache
        return Observable.just([
            ExchangedCurrency(
                source: "JPY",
                destination: "USD",
                sourceAmount: amount,
                destinationUnitPrice: 106.301942),
            ExchangedCurrency(
                source: "JPY",
                destination: "USD",
                sourceAmount: amount,
                destinationUnitPrice: 106.301942),
            ExchangedCurrency(
                source: "JPY",
                destination: "USD",
                sourceAmount: amount,
                destinationUnitPrice: 106.301942),
        ])
    }
}

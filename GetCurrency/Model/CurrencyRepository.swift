//
//  CurrencyRepository.swift
//  GetCurrency
//
//  Created by Kouki Saito on 8/21/19.
//  Copyright © 2019 Kouki Saito. All rights reserved.
//

import Foundation
import RxSwift

protocol CurrencyRepository {
    func getCurrencyList() -> Observable<[String]>
    func getExchangedCurrencies(sourceCurrency: String, sourceAmount: Double) -> Observable<[ExchangedCurrency]>
}

//
//  CurrencyViewModel.swift
//  GetCurrency
//
//  Created by Kouki Saito on 8/19/19.
//  Copyright © 2019 Kouki Saito. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

protocol CurrencyViewModelType {
    var inputs: CurrencyViewModelInputs { get }
    var outputs: CurrencyViewModelOutputs { get }
}

protocol CurrencyViewModelInputs {
    var amountChanged: BehaviorRelay<String> { get }
    var currencyChanged: BehaviorRelay<String> { get }
}

protocol CurrencyViewModelOutputs {
    var currencies: Driver<[ExchangedCurrency]> { get }
    var currencyButtonString: Driver<String> { get }
    var selectableCurrencyList: [String] { get }
}

class CurrencyViewModel: CurrencyViewModelType, CurrencyViewModelInputs, CurrencyViewModelOutputs {
    var inputs: CurrencyViewModelInputs {
        return self
    }

    var outputs: CurrencyViewModelOutputs {
        return self
    }

    // MARK: - Inputs
    let amountChanged = BehaviorRelay<String>(value: "0")
    let currencyChanged = BehaviorRelay<String>(value: "USD")

    // MARK: - Outputs
    let currencies: Driver<[ExchangedCurrency]>
    let currencyButtonString: Driver<String>
    var selectableCurrencyList: [String]

    init() {
        currencies = Observable.combineLatest(
            amountChanged.map {
                Double($0) ?? 0
            },
            currencyChanged
        )
        .map { amount, currency in
            // TODO: Use API value or cached value from disk
            return [
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
            ]
        }.asDriver(onErrorDriveWith: .empty())
        currencyButtonString = currencyChanged
            .map {
                "\($0) ▼"
            }
            .asDriver(onErrorDriveWith: .empty())
        // TODO: Use API value or cached value from disk
        selectableCurrencyList = [
            "USD",
            "JPY"
        ]
    }
}

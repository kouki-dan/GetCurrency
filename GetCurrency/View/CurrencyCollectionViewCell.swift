//
//  CurrencyCollectionViewCell.swift
//  GetCurrency
//
//  Created by Kouki Saito on 8/18/19.
//  Copyright © 2019 Kouki Saito. All rights reserved.
//

import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var currencyLabel: UILabel!
    @IBOutlet private var currentPriceLabel: UILabel!
    @IBOutlet private var amountLabel: UILabel!

    func render(currency: ExchangedCurrency) {
        currencyLabel.text = currency.source + currency.destination
        currentPriceLabel.text = String(currency.destinationUnitPrice)
        amountLabel.text = String(currency.destinationAmount)
    }
}

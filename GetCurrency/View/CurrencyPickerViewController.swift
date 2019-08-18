//
//  CurrencyPickerViewController.swift
//  GetCurrency
//
//  Created by Kouki Saito on 8/18/19.
//  Copyright © 2019 Kouki Saito. All rights reserved.
//

import UIKit

class CurrencyPickerViewController: UIViewController {

    var currencySelected: ((String) -> Void)!
    var currencies = [
        "USD",
        "JPY"
    ]

    @IBOutlet private var pickerView: UIPickerView!

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        currencySelected(currencies[pickerView.selectedRow(inComponent: 0)])
    }

    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

extension CurrencyPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
}

extension CurrencyPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
}

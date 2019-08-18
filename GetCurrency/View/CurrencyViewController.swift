//
//  CurrencyViewController.swift
//  GetCurrency
//
//  Created by Kouki Saito on 8/18/19.
//  Copyright © 2019 Kouki Saito. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var selectCurrencyButton: UIButton!
    @IBOutlet private var amountTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Adjust cell width to two cells for a row
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        var size = layout.itemSize
        size.width = (collectionView.frame.width - layout.sectionInset.left - layout.sectionInset.right - layout.minimumInteritemSpacing) / 2
        layout.itemSize = size
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectCurrency" {
            let destination = segue.destination as! CurrencyPickerViewController
            destination.currencies = [ // TODO: use API value
                "JPY",
                "USD"
            ]
            destination.currencySelected = { [weak self] selectedCurrency in
                self?.selectCurrencyButton.setTitle("\(selectedCurrency) ▼", for: .normal)
                // TODO: fetch currencies from API
            }
        }
    }
}

extension CurrencyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Currency", for: indexPath) as! CurrencyCollectionViewCell
        return cell
    }
}

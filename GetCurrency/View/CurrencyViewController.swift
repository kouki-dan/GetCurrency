//
//  CurrencyViewController.swift
//  GetCurrency
//
//  Created by Kouki Saito on 8/18/19.
//  Copyright © 2019 Kouki Saito. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RxOptional

class CurrencyViewController: UIViewController {

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var selectCurrencyButton: UIButton!
    @IBOutlet private var amountTextField: UITextField!

    private let viewModel: CurrencyViewModelType = CurrencyViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.rx.text
            .filterNil()
            .bind(to: viewModel.inputs.amountChanged)
            .disposed(by: disposeBag)

        viewModel.outputs.currencies
            .drive(collectionView.rx.items(cellIdentifier: "Currency", cellType: CurrencyCollectionViewCell.self)) { _, model, cell in
                cell.render(currency: model)
            }
            .disposed(by: disposeBag)

        viewModel.outputs.currencyButtonString
            .drive(selectCurrencyButton.rx.title())
            .disposed(by: disposeBag)
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
            
            destination.currencies = viewModel.outputs.selectableCurrencyList
            destination.currencySelected = { [weak self] selectedCurrency in
                self?.viewModel.inputs.currencyChanged.accept(selectedCurrency)
            }
        }
    }
}

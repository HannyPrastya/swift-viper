//
//  CurrencyMainViewController.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import UIKit
import RxSwift
import RxCocoa

class CurrencyMainView: UIViewController, BaseViewContract {
    var viewModel: CurrencyMainViewModel!
    var presenter: CurrencyMainPresenter!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    private let convertedCurrencyIdentifier = "convertedCurrencyCell"
    
    let amountTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = ViewConfig.textFieldBorderStyle
        textField.setHeight(ViewConfig.textFieldHeight)
        textField.placeholder = "Please enter the amount"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let currencyTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = ViewConfig.textFieldBorderStyle
        textField.setHeight(ViewConfig.textFieldHeight)
        return textField
    }()
    
    let inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        return stackView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 12, bottom: 0, right: 12)
        return stackView
    }()
    
    private lazy var convertedCurrenciesCollectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let numOfColumns: CGFloat = UIApplication.shared.statusBarOrientation.isLandscape ? 5 : 3
        let itemSize: CGFloat = ((UIScreen.main.bounds.width - 64 - (spacing * (numOfColumns - 1))) / numOfColumns)
        
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
    }()
   
    private lazy var convertedCurrenciesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: convertedCurrenciesCollectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindAmountTextField()
        bindSelectingCurrency()
        observeSelectedCurrency()
        observeError()
        observeLoader()
        observeToHideKeyboard()

        setupLayout()
        setupColor()
        setupCollectionView()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupLayout(){
        inputStackView.addArrangedSubview(amountTextField)
        inputStackView.addArrangedSubview(currencyTextField)

        stackView.addArrangedSubview(inputStackView)
        stackView.addArrangedSubview(convertedCurrenciesCollectionView)

        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        amountTextField.widthAnchor.constraint(equalTo: currencyTextField.widthAnchor, multiplier: 1.5).isActive = true
    }
    
    private func setupColor(){
        if #available(iOS 12.0, *) {
            switch traitCollection.userInterfaceStyle {
                case .light, .unspecified:
                    setupDefaultColor()
                    break
                case .dark:
                    break
            @unknown default:
                setupDefaultColor()
            }
        }
    }
    
    private func setupDefaultColor(){
        view.backgroundColor = .white
        convertedCurrenciesCollectionView.backgroundColor = .white
    }
}

//MARK: - BINDING

extension CurrencyMainView {
    private func bindAmountTextField() {
//        User must be able to enter desired amount for selected currency
        amountTextField.rx.text
            .bind(to: viewModel.amount)
            .disposed(by: disposeBag)
    }
    
    private func bindSelectingCurrency(){
//        User must be able to select a currency from a list of currencies provided by the API
        currencyTextField.rx
            .controlEvent(.editingDidBegin)
            .do(onNext: { _ in
                self.currencyTextField.resignFirstResponder()
            })
            .map{CurrencyMainAction.tapCurrency}
            .bind(to: viewModel.actionTrigger)
            .disposed(by: disposeBag)
    }
    
    private func observeSelectedCurrency(){
        viewModel.selectedCurrency
            .subscribe(onNext: { (currency) in
                self.currencyTextField.text = currency.code
            }, onCompleted: {
                self.currencyTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - COLLECTION VIEW

extension CurrencyMainView {
    private func setupCollectionView(){
//        User should then see a list of exchange rates for the selected currency
        convertedCurrenciesCollectionView.register(CurrencyMainExchangeRateCollectionViewCell.self, forCellWithReuseIdentifier: convertedCurrencyIdentifier)
        viewModel.exchangeRates
            .bind(to: convertedCurrenciesCollectionView.rx.items(cellIdentifier: convertedCurrencyIdentifier, cellType: CurrencyMainExchangeRateCollectionViewCell.self)){ row, model, cell in
                cell.setData(model)
            }.disposed(by: disposeBag)
    }
}

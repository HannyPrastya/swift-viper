//
//  CurrencyPickerView.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import UIKit
import RxSwift
import RxCocoa

final class CurrencyPickerView: UIViewController, BaseViewContract {
    typealias PresenterView = CurrencyPickerPresenter
    var viewModel: CurrencyPickerViewModel!
    var presenter: PresenterView!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    private let cellIdentifier = "currencyCell"
    
//    MARK: - DEFINE VIEWS
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search Currency"
        searchController.searchBar.showsCancelButton = true
        
        return searchController
    }()

    private let currencyTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configureTableView()
        
        bindCancelAction()
        bindSearchController()
        bindItemSelected()
        
        observeError()
        observeLoader()
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchController.searchBar.becomeFirstResponder()
    }
}

// MARK: - BINDING

extension CurrencyPickerView {
    private func bindCancelAction(){
        searchController.searchBar.rx
            .cancelButtonClicked
            .map{CurrencyPickerAction.tapCancelButton}
            .bind(to: viewModel.actionTrigger)
            .disposed(by: disposeBag)
    }
    
    private func bindSearchController(){
        searchController.searchBar.rx
            .text
            .orEmpty
            .debounce(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: viewModel.keyword)
            .disposed(by: disposeBag)
    }
    
    private func bindItemSelected(){
        currencyTableView.rx
            .itemSelected
            .map { [self] (indexPath) -> Void in
                viewModel.selectedCurrency.onNext(viewModel.filteredCurrencies.value[indexPath.row])
                return
            }
            .map{CurrencyPickerAction.selectCurrency}
            .bind(to: viewModel.actionTrigger)
            .disposed(by: disposeBag)
    }
}

// MARK: - LAYOUTING

extension CurrencyPickerView {
    
    private func setupView(){
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        navigationItem.titleView = searchController.searchBar
        navigationItem.hidesBackButton = true
    }
    
    private func configureTableView(){
        view.addSubview(currencyTableView)
        
        currencyTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        currencyTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        currencyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        currencyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        currencyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        viewModel.filteredCurrencies
            .bind(to: currencyTableView.rx.items(cellIdentifier: cellIdentifier, cellType: UITableViewCell.self)){row, model, cell in
                cell.textLabel?.text = "\(model.code) \(model.name ?? "")"
            }.disposed(by: disposeBag)
    }
}

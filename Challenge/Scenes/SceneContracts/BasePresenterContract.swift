//
//  BasePresenterContract.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Foundation
import RxSwift

protocol BasePresenterContract: PresenterContract {
    func presentAlert(_ error: Error)
}

extension BasePresenterContract {
    func presentAlert(_ error: Error) {
        if let model = viewModel as? ViewModelEmittableContract {
            model.error.onNext(error)
        }
    }
}

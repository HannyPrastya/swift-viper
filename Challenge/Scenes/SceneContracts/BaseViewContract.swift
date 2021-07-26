//
//  BaseViewContract.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Foundation
import UIKit
import RxSwift
import RxGesture

protocol BaseViewContract: UIViewController, ViewContract {
    var disposeBag: DisposeBag { get }
    var alert: UIAlertController { get }
    
    func observeError() -> Void
    func observeLoader() -> Void
    func observeToHideKeyboard() -> Void
}

extension BaseViewContract {
    var disposeBag: DisposeBag {
        DisposeBag()
    }
    
    var alert: UIAlertController {
        let alert = UIAlertController(title: "Warning", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
    
    func observeError() {
        guard let errorEmitable = viewModel as? ViewModelEmittableContract else {
            return
        }
        errorEmitable.error
            .subscribe(onNext: { [self] error in
                alert.message = error.localizedDescription
                if let appError = error as? AppErrorContract {
                    alert.message = appError.message
                }
                present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    func observeLoader() {
        guard let errorEmitable = viewModel as? ViewModelEmittableContract else {
            return
        }
        errorEmitable.isLoading
            .subscribe(onNext: { isLoading in
                UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
            })
            .disposed(by: disposeBag)
    }
    
    func observeToHideKeyboard() {
        view.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [self] _ in
                view.endEditing (true)
            }).disposed(by: disposeBag)
    }
}

//
//  ViewModelEmittableContract.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import RxSwift

protocol ViewModelEmittableContract {
    var error: PublishSubject<Error> { get }
    var isLoading: PublishSubject<Bool> { get }
}

extension ViewModelEmittableContract {
    var error: PublishSubject<Error> {
        PublishSubject<Error>()
    }
    
    var isLoading: PublishSubject<Bool> {
        PublishSubject<Bool>()
    }
}

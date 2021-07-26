//
//  TestScheduler+Record.swift
//  ChallengeTests
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import RxTest
import RxSwift
import RxCocoa

extension TestScheduler {

    func record<O: ObservableConvertibleType>(_ source: O, disposeBag: DisposeBag) -> TestableObserver<O.Element> {
        let observer = self.createObserver(O.Element.self)
        source
            .asObservable()
            .bind(to: observer)
            .disposed(by: disposeBag)
        return observer
    }
}

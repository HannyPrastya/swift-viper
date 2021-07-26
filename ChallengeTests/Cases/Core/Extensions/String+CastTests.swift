//
//  String+Cast.swift
//  ChallengeTests
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import XCTest
import Quick
import Nimble
import RxTest
import RxSwift

@testable import Challenge

class StringCastTests: QuickSpec {
    override func spec() {
        describe("A string") {
            it("from 0 will be 0") {
                expect("0".toDouble()).to(equal(0.0))
            }
            it("from 1 will be 1") {
                expect("1".toDouble()).to(equal(1.0))
            }
            it("from x will be 0") {
                expect("x".toDouble()).to(equal(0.0))
            }
        }
    }
}

//
//  AppError.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

protocol AppErrorContract: Error {
    var message: String { get set }
}

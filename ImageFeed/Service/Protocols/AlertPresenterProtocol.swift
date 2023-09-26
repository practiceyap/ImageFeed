//
//  AlertPresenterProtocol.swift
//  ImageFeed
//
//  Created by Muller Alexander on 26.09.2023.
//

import Foundation

protocol AlertPresenterProtocol: AnyObject {
    func showSplashView(_ result: AlertModelOneButton)
    func showOneButton(_ result: AlertModelOneButton)
    func showTwoButton(_ result: AlertModelTwoButton)
}

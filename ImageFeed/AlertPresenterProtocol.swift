//
//  AlertPresenterProtocol.swift
//  ImageFeed
//
//  Created by Muller Alexander on 30.08.2023.
//

import UIKit

protocol AlertPresenterProtocol: AnyObject {
    func showSplashView(_ result: AlertModelOneButton)
    func showOneButton(_ result: AlertModelOneButton)
    func showTwoButton(_ result: AlertModelTwoButton)
}

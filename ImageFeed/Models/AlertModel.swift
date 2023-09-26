//
//  AlertModel.swift
//  ImageFeed
//
//  Created by Muller Alexander on 30.08.2023.
//

import UIKit

public struct AlertModelOneButton {
    let title: String
    let message: String
    let buttonText: String
    let completion: (() -> Void)?
}

public struct AlertModelTwoButton {
    let title: String
    let message: String
    let buttonTextOne: String
    let buttonTextTwo: String
    let completionOne: (() -> Void)?
    let completionTwo: (() -> Void)?
}

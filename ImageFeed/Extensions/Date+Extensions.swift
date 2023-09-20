//
//  Date+Extensions.swift
//  ImageFeed
//
//  Created by Muller Alexander on 19.09.2023.
//

import UIKit

var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()

extension Date {
    var dateTimeString: String { dateFormatter.string(from: self) }
}

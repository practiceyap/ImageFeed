//
//  String+Extensions.swift
//  ImageFeed
//
//  Created by Muller Alexander on 19.09.2023.
//

import UIKit

extension String {
    var dateTimeString: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
}


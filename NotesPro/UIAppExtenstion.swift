//
//  UIAppExtenstion.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 02.08.2023.
//

import Foundation
import UIKit

extension UIApplication {
    static let keyWin = UIApplication.shared.connectedScenes.first as? UIWindowScene
    static func getSize() {
        print(keyWin!.windows.first?.screen.bounds.height)
    }
}

extension Date {
    func format(format: String = "dd-MM-yyyy hh-mm-ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        if let newDate = dateFormatter.date(from: dateString) {
            return newDate
        } else {
            return self
        }
    }
}


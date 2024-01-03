//
//  Fonts.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 01.08.2023.
//

import Foundation
import UIKit

extension UIFont {
    static func spaceMono(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "SpaceMono-Regular", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}

extension UIColor {
    static let lightBackground = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0)
    static let darkBackground = UIColor(red: 19/255, green: 19/255, blue: 19/255, alpha: 1.0)
}

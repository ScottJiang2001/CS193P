//
//  Themes.swift
//  Memorize
//
//  Created by Scott Jiang on 2023-06-19.
//

import Foundation
import SwiftUI

struct Theme {
    var name: String
    var emojiArr: Array<String>
    var color: Color
}

let themes: [Theme] = [
    Theme(name: "Nature", emojiArr: ["🌿", "🌺", "🌳", "🌼", "🍃", "🌸"], color: Color.green),
    Theme(name: "Food", emojiArr: ["🍕", "🍔", "🌮", "🍟", "🍦", "🍩"], color: Color.yellow),
    Theme(name: "Sports", emojiArr: ["⚽", "🏀", "🎾", "🏈", "🏓", "🏒"], color: Color.orange),
    Theme(name: "Travel", emojiArr: ["✈️", "🚗", "🛳️", "🌍", "🏰", "🌴"], color: Color.blue),
    Theme(name: "Love", emojiArr: ["💖", "💑", "💍", "💌", "💏", "💘"], color: Color.pink),
    Theme(name: "Animal", emojiArr: ["🐶", "🐱", "🐼", "🦁", "🐯", "🐰"], color: Color.brown)
]


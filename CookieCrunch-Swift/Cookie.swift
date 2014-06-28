//
//  Cookie.swift
//  CookieCrunch-Swift
//
//  Created by Ryoichi Hara on 2014/06/28.
//  Copyright (c) 2014 Ryoichi Hara. All rights reserved.
//

import SpriteKit

enum CookieType: Int {
    case Unknown = 0, Croissant, Cupcake, Danish, Donut, Macaroon, SugarCookie

    var spriteName: String {
        let spriteNames = [
            "Croissant",
            "Cupcake",
            "Danish",
            "Donut",
            "Macaroon",
            "SugarCookie"]

        return spriteNames[toRaw() - 1]
    }

    var highlightedSpriteName: String {
        let highlightedSpriteNames = [
            "Croissant-Highlighted",
            "Cupcake-Highlighted",
            "Danish-Highlighted",
            "Donut-Highlighted",
            "Macaroon-Highlighted",
            "SugarCookie-Highlighted"]

        return highlightedSpriteNames[toRaw() - 1]
    }

    static func random() -> CookieType {
        return CookieType.fromRaw(Int(arc4random_uniform(6)) + 1)!
    }
}

class Cookie {
    var column: Int
    var row: Int
    let cookieType: CookieType
    var sprite: SKSpriteNode?

    init(column: Int, row: Int, cookieType: CookieType) {
        self.column = column
        self.row = row
        self.cookieType = cookieType
    }
}

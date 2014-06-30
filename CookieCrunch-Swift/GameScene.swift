//
//  GameScene.swift
//  CookieCrunch-Swift
//
//  Created by Ryoichi Hara on 2014/06/28.
//  Copyright (c) 2014 Ryoichi Hara. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var level: Level!

    let TileWidth: CGFloat  = 32.0
    let TileHeight: CGFloat = 36.0

    let gameLayer    = SKNode()
    let cookiesLayer = SKNode()
    let tilesLayer   = SKNode()

    // Record the column and row numbers of the cookie that the player first touched
    var swipeFromColumn: Int?
    var swipeFromRow: Int?

    init(size: CGSize) {
        super.init(size: size)

        // This means (0, 0) is in the center of the screen
        anchorPoint = CGPoint(x: 0.5, y: 0.5)

        let background = SKSpriteNode(imageNamed: "Background")
        addChild(background)

        addChild(gameLayer)

        let layerPosition = CGPoint(
            x: -TileWidth * CGFloat(NumColumns) / 2,
            y: -TileHeight * CGFloat(NumRows) / 2)

        tilesLayer.position = layerPosition;
        gameLayer.addChild(tilesLayer)

        cookiesLayer.position = layerPosition
        gameLayer.addChild(cookiesLayer)

        // 'nil' means that these properties have invalid values
        swipeFromColumn = nil
        swipeFromRow = nil
    }

    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(cookiesLayer)

        let (success, column, row) = convertPoint(location)

        if success {
            if let cookie = level.cookieAtColumn(column, row: row) {
                swipeFromColumn = column
                swipeFromRow = row
            }
        }
    }

    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!)  {
        if swipeFromColumn == nil { return }

        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(cookiesLayer)

        let (success, column, row) = convertPoint(location)

        if success {
            var horzDelta = 0, vertDelta = 0

            if column < swipeFromColumn! {  // swipe left
                horzDelta = -1
            } else if column > swipeFromColumn! {  // swipe right
                horzDelta = 1
            } else if row < swipeFromRow! {  // swipe down
                vertDelta = -1
            } else if row > swipeFromRow! {  // swipe up
                vertDelta = 1
            }

            if horzDelta != 0 || vertDelta != 0 {
                trySwapHorizontal(horzDelta, vertical: vertDelta)
                swipeFromColumn = nil
            }
        }
    }

    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!)  {
        swipeFromColumn = nil
        swipeFromRow = nil
    }

    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!)  {
        touchesEnded(touches, withEvent: event)
    }

    func addSpritesForCookies(cookies: Set<Cookie>) {
        for cookie in cookies {
            let sprite = SKSpriteNode(imageNamed: cookie.cookieType.spriteName)
            sprite.position = pointForColumn(cookie.column, row:cookie.row)
            cookiesLayer.addChild(sprite)
            cookie.sprite = sprite
        }
    }

    func pointForColumn(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column) * TileWidth + TileWidth / 2,
            y: CGFloat(row) * TileHeight + TileHeight / 2)
    }

    func addTiles() {
        for row in 0..NumRows {
            for column in 0..NumColumns {
                if let title = level.tileAtColumn(column, row: row) {
                    let tileNode = SKSpriteNode(imageNamed: "Tile")
                    tileNode.position = pointForColumn(column, row: row)
                    tilesLayer.addChild(tileNode)
                }
            }
        }
    }

    func convertPoint(point: CGPoint) -> (success: Bool, column: Int, row: Int) {
        if point.x >= 0 && point.x < CGFloat(NumColumns) * TileWidth &&
            point.y >= 0 && point.y < CGFloat(NumRows) * TileHeight {
            return (true, Int(point.x / TileWidth), Int(point.y / TileHeight))
        } else {
            return (false, 0, 0)  // invalid location
        }
    }

    func trySwapHorizontal(horzDelta: Int, vertical vertDelta: Int) {
        let toColumn = swipeFromColumn! + horzDelta
        let toRow = swipeFromRow! + vertDelta

        if toColumn < 0 || toColumn >= NumColumns { return }
        if toRow < 0 || toRow >= NumRows { return }

        if let toCookie = level.cookieAtColumn(toColumn, row: toRow) {
            if let fromCookie = level.cookieAtColumn(swipeFromColumn!, row: swipeFromRow!) {
                println("*** swapping \(fromCookie) with \(toCookie)")
            }
        }
    }
}

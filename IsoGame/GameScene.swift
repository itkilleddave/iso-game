//
//  GameViewController.swift
//  IsoGame
//
//  Created by Dave Longbottom on 16/01/2015.
//  Copyright (c) 2015 Big Sprite Games. All rights reserved.
//

import UIKit
import SpriteKit


func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGPoint) -> CGPoint {
    return CGPoint(x: point.x * scalar.x, y: point.y * scalar.y)
}

func / (point: CGPoint, scalar: CGPoint) -> CGPoint {
    return CGPoint(x: point.x / scalar.x, y: point.y / scalar.y)
}

enum Tile: Int {
    
    case Grass
    case Wall
    
    var description:String {
        switch self {
        case Grass:
            return "Grass"
        case Wall:
            return "Wall"
        }
    }
    
    var image:String {
        switch self {
        case Grass:
            return "grass"
        case Wall:
            return "wall"
            
        }
    } 
}

class GameScene: SKScene {
    
    //1
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //2
    let view2D:SKSpriteNode
    let viewIso:SKSpriteNode
    
    //3
    let tiles = [
        [1, 1, 1, 1, 1, 1],
        [1 ,0, 0, 0, 0, 1],
        [1 ,0, 0, 0, 0, 1],
        [1 ,0, 0, 0, 0, 1],
        [1 ,0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1, 1]
    ]
    let tileSize = (width:32, height:32)
    
    //4
    override init(size: CGSize) {
        
        view2D = SKSpriteNode()
        viewIso = SKSpriteNode()
        
        super.init(size: size)
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
    }
    
    //5
    override func didMoveToView(view: SKView) {
        
        view2D.position = CGPoint(x:-self.size.width*0.4, y:self.size.height*0.2)
        addChild(view2D)
        
        viewIso.position = CGPoint(x:self.size.width*0.18, y:self.size.height*0.2)
        addChild(viewIso)
        
        placeAllTiles2D()
        placeAllTilesIso()
    }
    
    func placeTile2D(image:String, withPosition:CGPoint) {
        
        let tileSprite = SKSpriteNode(imageNamed: image)
        
        tileSprite.position = withPosition
        
        view2D.addChild(tileSprite)
        
    }
    
    func placeAllTiles2D() {
        
        for i in 0..<tiles.count {
            
            let row = tiles[i];
            
            for j in 0..<row.count {
                let tileInt = row[j]
                
                //1
                let tile = Tile(rawValue: tileInt)!
                
                //2
                var point = CGPoint(x: (j*tileSize.width), y: -(i*tileSize.height))
                
                placeTile2D(tile.image, withPosition:point)
            }
            
        }
        
    }
    
    func placeTileIso(image:String, withPosition:CGPoint) {
        
        let tileSprite = SKSpriteNode(imageNamed: image)
        
        tileSprite.position = withPosition
        
        viewIso.addChild(tileSprite)
        
    }
    
    func placeAllTilesIso() {
        
        for i in 0..<tiles.count {
            
            let row = tiles[i];
            
            for j in 0..<row.count {
                let tileInt = row[j]
                
                let tile = Tile(rawValue: tileInt)!
                
                //1
                var point = point2DToIso(CGPoint(x: (j*tileSize.width), y: -(i*tileSize.height)))
                
                //2
                placeTileIso(("iso_"+tile.image), withPosition:point)
                
            }
        }
    }
    
    func point2DToIso(p:CGPoint) -> CGPoint {
        
        //invert y pre conversion
        var point = p * CGPoint(x:1, y:-1)
        
        //convert using algorithm
        point = CGPoint(x:(point.x - point.y), y: ((point.x + point.y) / 2))
        
        //invert y post conversion
        point = point * CGPoint(x:1, y:-1)
        
        return point
        
    }
    func pointIsoTo2D(p:CGPoint) -> CGPoint {
        
        //invert y pre conversion
        var point = p * CGPoint(x:1, y:-1)
        
        //convert using algorithm
        point = CGPoint(x:((2 * point.y + point.x) / 2), y: ((2 * point.y - point.x) / 2))
        
        //invert y post conversion
        point = point * CGPoint(x:1, y:-1)
        
        return point
        
    }
    
    
    
}
//
//  GameScene.swift
//  IsoGame
//
//  Created by Dave Longbottom on 16/01/2015.
//  Copyright (c) 2015 Big Sprite Games. All rights reserved.
//

import SpriteKit

// MARK: Tile

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
        
    }
    
    func placeTile2D(image:String, withPosition:CGPoint) {
        
        let tileSprite = SKSpriteNode(imageNamed: image)
        
        tileSprite.position = withPosition
        
        view2D.addChild(tileSprite)
        
    }
    
    func placeAllTiles2D() {
        
        //place tiles
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
    
}

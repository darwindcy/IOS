//
//  Card.swift
//  CallBreak
//
//  Created by Yadav, Darwin on 11/30/19.
//  Copyright © 2019 Yadav, Darwin. All rights reserved.
//

import Foundation
import SpriteKit

enum Suit: Character, CaseIterable {
    case hearts = "H", diamonds = "D", clubs = "C", spades = "S"
    static let allValues = [hearts, diamonds, clubs, spades]
}

enum Value: Int, CaseIterable {
    case two = 2, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
    static let allValues = [two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace]
}

class Card : SKSpriteNode{
    private let suit: Suit
    private let value: Value
    let frontTexture: SKTexture
    let backTexture :SKTexture
    
    init(_ value: Value, of suit: Suit){
        self.value = value
        self.suit = suit
        
        backTexture = SKTexture(imageNamed: "red_back")
        
        let cardName: String = String(value.rawValue) + String(suit.rawValue)
        
        let resizedImage =  ImageResizer().resizeImage(image: UIImage(imageLiteralResourceName: cardName), targetSize: CGSize(width: 55.0, height: 85.0))
        
        frontTexture = SKTexture(image: resizedImage)
        
        super.init(texture: frontTexture, color: SKColor.clear, size: frontTexture.size())
    }
    
    func flip(){
        if(self.texture == frontTexture){
            self.texture = backTexture
        } else {
            self.texture = frontTexture
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getValue() -> Value{
        return value
    }
    
    func getSuit() -> Suit{
        return suit
    }
    
    // Is the current card stronger than the otherCard
    func compareCards(otherCard: Card) -> Bool {
        if(suit == otherCard.getSuit()){
            if(otherCard.getValue().rawValue > value.rawValue){
                return false
            }
        } else if (otherCard.getSuit() == .spades){
            return false
        }
        return true
    }
    
    func toString() -> String {
        return String(value.rawValue) + " of " + String(suit.rawValue)
    }
    
}

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}

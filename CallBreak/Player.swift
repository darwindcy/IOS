//
//  Player.swift
//  CallBreak
//
//  Created by Yadav, Darwin on 11/30/19.
//  Copyright © 2019 Yadav, Darwin. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Player: SKSpriteNode, GKGameModelPlayer{
    var playerId: Int
    
    var playerCards = [Card]()
    var imageResizer = ImageResizer()
    var xPosition:Double
    var yPosition:Double
    var score = [Int]()
    
    init(xPos: Double, yPos: Double, id: Int) {
        
        xPosition = xPos
        yPosition = yPos
        
        playerCards = []
        
        //let resizedImage = imageResizer.resizeImage(image: UIImage(imageLiteralResourceName: "gray_black"), targetSize: CGSize(width: 55.0, height: 85.0))
        
        let resizedImage = imageResizer.resizeImage(image: UIImage(imageLiteralResourceName: "purple_back"), targetSize: CGSize(width: 55.0, height: 85.0))
        
        let texture = SKTexture(image: resizedImage)
        
        self.playerId = id
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
    }
    
    func addScore(roundScore: Int){
        score.append(roundScore)
    }
    
    func isLegalCard(currentCard: Card, currentRound: Round) -> Bool{
        
        if(currentRound.roundCards.count == 0){
            return true
        }
        
        var validSameSuit: Bool = false
        
        for eachCard in playerCards {
            if eachCard.getSuit() == currentRound.roundCards[0].getSuit() {
                validSameSuit = true
                break
            }
        }
        
        if(validSameSuit){
            if(currentRound.roundCards[0].getSuit() == currentCard.getSuit()){
                return true
            }
        } else {
            if currentCard.getSuit() == .spades{
                return true
            }

            if(currentRound.roundCards[0].getSuit() == .spades){
                return true
            }
            return true
        }
        
        return false
    }
    
    func xPos() -> Double {
        return xPosition
    }
    
    func yPos() -> Double{
        return yPosition
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cardCount() -> Int{
        return playerCards.count
    }
    
    func removeCard(theCard: Card){
        if let index = playerCards.firstIndex(of: theCard){
            playerCards.remove(at: index)
        }
    }
    
    func giveCard(topCard: Card){
        playerCards.append(topCard)
    }
    
    func playCard(cardsOnTable: [Card]) -> Card{
        return Card(.ace, of: .clubs)
    }
    
    func bestCardForRound(currentRound: Round) -> Card{
        
        var bestCard: Card = playerCards.randomElement()!
        
        let bestRoundCard:Card = currentRound.getHighestCard()

        for eachCard in playerCards {
            if(eachCard.compareCards(otherCard: bestRoundCard)){
                bestCard = eachCard
                break
            }
        }

        return bestCard
    }
}

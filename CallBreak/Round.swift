//
//  Round.swift
//  CallBreak
//
//  Created by Yadav, Darwin on 11/30/19.
//  Copyright © 2019 Yadav, Darwin. All rights reserved.
//

import Foundation

class Round {
    var roundCards = [Card]()
    var startingPlayer:Int = 0
    var runningWinner:Int = 0
    
    func addCard(aCard: Card){
        roundCards.append(aCard)
    }
    
    func addCardToIndex(index: Int, aCard: Card){
        roundCards.insert(aCard, at: index)
    }
    
    func firstInRound() -> Bool{
        return roundCards.isEmpty
    }
    
    func suitToPlay() -> Suit{
        return roundCards[0].getSuit()
    }
    
    func clearCards(){
        roundCards = [Card]()
    }
    
    func getRunningWinner() -> Int{
        return runningWinner
    }
    
    func getHighestCard() -> Card{
        
        if(roundCards.count == 1){
            return roundCards[0]
        }
        
        var runningHighest: Card = roundCards[0]
        
        for i in 1...roundCards.count-1 {
            
            if(roundCards[i].compareCards(otherCard: runningHighest)){
                runningWinner = i
                runningHighest = roundCards[i]
            }
        }
        
        return runningHighest
    }
    
    func getHigherCard() {
        
    }
}

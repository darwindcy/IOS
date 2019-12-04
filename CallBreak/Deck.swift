//
//  Deck.swift
//  CallBreak
//
//  Created by Yadav, Darwin on 11/30/19.
//  Copyright © 2019 Yadav, Darwin. All rights reserved.
//

import Foundation


class Deck {
    private var deck = [Card] ()
    private var deckIndex = -1
    
    init (){
        create()
    }
    
    func create(){
        for cardSuit in Suit.allValues{
            for cardValue in Value.allValues{
                let tempCard = Card(cardValue, of: cardSuit)
                deck.append(tempCard)
            }
        }
    }
    
    func getTopCard() -> Card {
        deckIndex += 1
        return deck[deckIndex]
    }
    
    func shuffle(){
        deck.shuffle()
    }
    
}

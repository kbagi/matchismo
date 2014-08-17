//
//  SetDeck.swift
//  Matchismo
//
//  Created by Karol Baginski on 16/08/2014.
//  Copyright (c) 2014 Karol Baginski. All rights reserved.
//

import Foundation

class SetDeck : Deck {
    override init() {
        super.init()
        
        for colour in 0...2 {
            for symbol in 0...2 {
                for shading in 0...2 {
                    for count in 1...3 {
                        var card = SetCard()
                        card.colour = SetCard.Colour.fromRaw(colour);
                        card.shading = SetCard.Shading.fromRaw(shading);
                        card.symbol = SetCard.Symbol.fromRaw(symbol);
                        card.count = count;
                        self.addCard(card);
                    }
                }
            }
        }
    }

}
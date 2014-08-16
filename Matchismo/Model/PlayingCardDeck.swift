//
//  PlayingCardDeck.swift
//  StanfordStart
//
//  Created by Karol Baginski on 07/06/2014.
//  Copyright (c) 2014 Karol Baginski. All rights reserved.
//

import Foundation

class PlayingCardDeck : Deck{
     override init() {
        super.init()
        for suit in PlayingCard.validSuits{
            for (var rank = 1; rank <= PlayingCard.maxRank; rank++) {
                var card = PlayingCard();
                card.rank = rank
                card.suit = suit
                self.addCard(card)
            }
        }
    }
}

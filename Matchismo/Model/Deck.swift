//
//  Deck.swift
//  StanfordStart
//
//  Created by Karol Baginski on 04/06/2014.
//  Copyright (c) 2014 Karol Baginski. All rights reserved.
//

import Foundation

class Deck{
    private var _cards:[Card]?;
    var cards:[Card]{
        get{
            if _cards == nil{
                _cards = [Card]()
            }
            
            return _cards!;
        }
        set(cards){
            self._cards = cards;
        }
    }
    
    init(){
        
    }
    func addCard(card:Card, atTop:Bool = false){
        if(atTop){
            self.cards.insert(card, atIndex: 0);
        }else{
            self.cards.append(card);
        }
    }
    
    func drawRandomCard() -> Card?{
        var randomCard:Card?;
        if(self.cards.count > 0){
            var randomIn = arc4random() % UInt32(cards.count);
            randomCard = self.cards[Int(randomIn)];
            self.cards.removeAtIndex(Int(randomIn));
        }
        return randomCard;
    }
}
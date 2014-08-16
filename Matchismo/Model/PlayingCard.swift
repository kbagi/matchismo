//
//  PlayingCard.swift
//  StanfordStart
//
//  Created by Karol Baginski on 04/06/2014.
//  Copyright (c) 2014 Karol Baginski. All rights reserved.
//

import Foundation

class PlayingCard : Card{
    private var _suit:String?
    var suit:String{
        get{
            return _suit != nil ? _suit! : "?"
        }
        set(suit){
            for s in PlayingCard.validSuits{
                if(s == suit)
                {
                    self._suit = suit;
                }
            }
        }
    }
    
    private var _rank:Int?
    var rank:Int{
        get{
            return _rank!;
        }
        set(rank){
            if(rank <= PlayingCard.maxRank){
                self._rank = rank
            }
        }
    }
    
    override var contents:String{
        get {
            var s = PlayingCard.rankStrings[rank]
            return "\(PlayingCard.rankStrings[rank])\(self.suit)"
        }
    }
    
    override func match(otherCards: [Card]) -> Int {
        var score = 0;
        
        if otherCards.count == 1 {
            var otherCard = otherCards.first! as PlayingCard;
            if otherCard.rank == self.rank{
                score = 4;
            }else if otherCard.suit == self.suit {
                score = 1;
            }
        }else if otherCards.count == 2 {
            var otherCard1 = otherCards[0] as PlayingCard;
            var otherCard2 = otherCards[1] as PlayingCard;
            
            if otherCard1.rank == self.rank && otherCard2.rank == self.rank {
                score = 8;
            }else if otherCard1.suit == self.suit && otherCard2.suit == self.suit {
                score = 4;
            }
            
            if otherCard1.rank == self.rank || otherCard2.rank == self.rank || otherCard1.rank == otherCard2.rank {
                score = 4;
            }else if
                otherCard1.suit == self.suit || otherCard2.suit == self.suit || otherCard1.suit == otherCard2.suit {
                score = 1;
            }

        }
        return score;
    }
    
    class var rankStrings: [String]{
    return ["?","A","2","3","4","5","6","7","8","9","10","J","Q","K"]
    }
    
    class var validSuits: [String] {
    return ["♥","♦","♠","♣"];
    }
    
    class var maxRank:Int{
    return PlayingCard.rankStrings.count - 1;
    }
    
}



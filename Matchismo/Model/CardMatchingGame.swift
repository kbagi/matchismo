//
//  CardMatchingGame.swift
//  Matchismo
//
//  Created by Karol Baginski on 11/08/2014.
//  Copyright (c) 2014 Karol Baginski. All rights reserved.
//

import Foundation

class CardMatchingGame {
    init(cardCount:Int, deck:Deck){
        for var i = 0; i < cardCount; ++i{
            var card = deck.drawRandomCard();
            if card != nil{
                self.cards.append(card!);
            }else{
                self.cards = [Card]();
                break;
            }
        }
    }
    
    let MATCH_BONUS = 4
    let COST_TO_CHOOSE = 1
    let MISMATCH_PENALTY = 2
    let TWO_CARDS = 0;
    let THREE_CARDS = 1;
    
    var score:Int = 0
    var mode:Int = 0
    private var _cards:[Card]?
    var cards:[Card] {
        get{
            if _cards == nil{
                _cards = [Card]();
            }
            return _cards!;
        }
        set{
            _cards = newValue;
        }
    }
    
    func cardAtIndex(index:Int) -> Card?{
        return index < cards.count ? cards[index] : nil;
    }
    func chooseCardAtIndex(index:Int) -> FlipResult {
        var card = cards[index]
        var flipResult = FlipResult();
       
        if !card.matched{
            if card.chosen{
                card.chosen = false;
                flipResult.type = FlipResult.ResultType.None;
            }else{
                //var cardsToMatch:[Card] = [Card]();
                for otherCard in cards{
                    if otherCard.chosen && !otherCard.matched{
                        //cardsToMatch.append(otherCard)
                        flipResult.cards.append(otherCard)
                    }
                }
                
                if(mode == 0 && flipResult.cards.count == 1) || (mode == 1 && flipResult.cards.count == 2){
                    var matchScore = card.match(flipResult.cards);
                    if matchScore > 0 {
                        score += matchScore * MATCH_BONUS;
                        card.matched = true;
                        flipResult.points = matchScore * MATCH_BONUS;
                        flipResult.type = FlipResult.ResultType.SuccessfulMatch;
                        //message += "Matched \(card.contents)"
                        for card in flipResult.cards
                        {
                            card.matched = true;
                            //message += "\(card.contents) "
                        }
                        //message += "for \(matchScore * MATCH_BONUS) points."
                    }else{
                        score -= MISMATCH_PENALTY
                        //message += "\(card.contents) ";
                        for card in flipResult.cards
                        {
                            card.chosen = false;
                             //message += "\(card.contents) ";
                        }
                         //message += "don’t match! \(MISMATCH_PENALTY) point penalty!"
                        flipResult.points = MISMATCH_PENALTY;
                        flipResult.type = FlipResult.ResultType.UnsuccesfullMatch;
                    }
                }else{
                    flipResult.cards = [Card]();
                }
                score -= COST_TO_CHOOSE;
                card.chosen = true;
            }
        }
        flipResult.cards.insert(card, atIndex: 0)
        return flipResult;
    }
}
//
//  SetFindingGame.swift
//  Matchismo
//
//  Created by Karol Baginski on 16/08/2014.
//  Copyright (c) 2014 Karol Baginski. All rights reserved.
//

class SetFindingGame : CardMatchingGame {
    let SET_MATCH_BONUS = 2
    let SET_COST_TO_CHOOSE = 0
    let SET_MISMATCH_PENALTY = 10
    
    override func chooseCardAtIndex(index:Int) -> FlipResult {
        var card = cards[index]
        var flipResult = FlipResult();
        if !card.matched{
            if card.chosen{
                card.chosen = false;
                flipResult.type = FlipResult.ResultType.None;
            }else{
                for otherCard in cards{
                    if otherCard.chosen && !otherCard.matched{
                        flipResult.cards.append(otherCard)
                    }
                }
                if(flipResult.cards.count > 1){
                    var matchScore = card.match(flipResult.cards);
                    if matchScore > 0 {
                        score += matchScore * SET_MATCH_BONUS;
                        card.matched = true;
                        flipResult.points = matchScore * MATCH_BONUS;
                        flipResult.type = FlipResult.ResultType.SuccessfulMatch;
                        for card in flipResult.cards
                        {
                            card.matched = true;
                        }
                        
                    }else{
                        score -= SET_MISMATCH_PENALTY
                        
                        for card in flipResult.cards
                        {
                            card.chosen = false;
                        }
                        flipResult.points = MISMATCH_PENALTY;
                        flipResult.type = FlipResult.ResultType.UnsuccesfullMatch;
                    }
                }else{
                    flipResult.cards = [Card]();
                }
                score -= SET_COST_TO_CHOOSE;
                card.chosen = true;
            }
        }
        flipResult.cards.insert(card, atIndex: 0)
        return flipResult;
    }
}
